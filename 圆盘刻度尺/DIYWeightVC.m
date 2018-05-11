//
//  DIYWeightVC.m
//  圆盘刻度尺
//
//  Created by nyl on 2018/5/11.
//  Copyright © 2018年 nieyinlong. All rights reserved.
//

#import "DIYWeightVC.h"


/*
 备注, 圆盘的刻度范围可以自定义, 0~10, 0~500 等等都行, 按照角度比例即可
 */


#import "DIYWeightVC.h"
#import "RoundRotatePanel.h"
#define kScreenBounds     ([UIScreen mainScreen].bounds)
#define kScreenBoundsSize (kScreenBounds.size)
#define kScreenWidth      (kScreenBoundsSize.width)
#define kScreenHeight     (kScreenBoundsSize.height)
#define kRadianToAngel(radian) (180/M_PI*radian)
static double oneRound = 6.2831855; //一圈的弧度 = 360度


@interface DIYWeightVC () {
    double _remWeight;
    double _changedRadian;
}

@property (nonatomic, strong) RoundRotatePanel *rrPanel;
@property (nonatomic, strong) UIImageView *scaleImageV;
@property (nonatomic, strong) UIImageView *indicatorImageV;
@property (nonatomic, strong) UILabel *showLabel;


@end

@implementation DIYWeightVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVIew];
    [self readUserDafauleData];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSUserDefaults standardUserDefaults] setDouble:_changedRadian forKey:@"_changedRadian2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


- (void)initVIew {
    self.view.backgroundColor = [UIColor whiteColor];
    _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 64 + 40, kScreenWidth-40, 100)];
    _showLabel.numberOfLines = 0;
    _showLabel.text = @"旋转结果:";
    [self.view addSubview:_showLabel];
    
    
    // 旋转控制环
    _rrPanel = [[RoundRotatePanel alloc] initWithFrame:CGRectMake((kScreenWidth-300)/2, kScreenHeight-150, 300, 300)];
    _rrPanel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_rrPanel];
    
    _rrPanel.centerPoint = CGPointMake(300 / 2, 300 / 2);
    _rrPanel.layer.cornerRadius = 300 / 2;
    _rrPanel.clipsToBounds = YES;
    [_rrPanel addTarget:self action:@selector(colorPanelRotated:) forControlEvents:UIControlEventValueChanged];
    
    
    
    _scaleImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yibiaopan"]];
    _scaleImageV.frame = CGRectMake(0, 0, 300, 300);
    _scaleImageV.layer.cornerRadius = 300 / 2;
    _scaleImageV.clipsToBounds = YES;
    [_rrPanel addSubview:_scaleImageV];
    
    
    
    _indicatorImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    _indicatorImageV.frame = CGRectMake((kScreenWidth-2)/2, kScreenHeight-160, 2, 25);
    _indicatorImageV.backgroundColor = [UIColor redColor];
    [self.view addSubview:_indicatorImageV];
}

#pragma mark -  读取缓存
- (void)readUserDafauleData {
    _changedRadian = [[NSUserDefaults standardUserDefaults] doubleForKey:@"_changedRadian2"];
    [_rrPanel rotateByRadian:_changedRadian];
    // 体重
    _remWeight = kRadianToAngel(_changedRadian);
    if (_remWeight > 0) {
        _remWeight = 360 - _remWeight;
    }
    _remWeight *= 0.333333333;
    _remWeight = ABS(_remWeight);
    _showLabel.text = [NSString stringWithFormat:@"变化弧度 = %f \n变化角度 = %f \n变化体重 = %.2f Kg", _changedRadian, kRadianToAngel(_changedRadian),  _remWeight];
}



#pragma mark - 旋转 方法
- (void)colorPanelRotated:(id)sender {
    
    // 记录旋转的弧度
    _changedRadian += _rrPanel.changedRadian;
    
    if (_changedRadian > oneRound) {
        _changedRadian -= oneRound;
    } else if (_changedRadian < -oneRound) {
        _changedRadian += oneRound;
    }
    
    
    // 体重
    _remWeight = kRadianToAngel(_changedRadian);
    if (_remWeight > 0) {
        _remWeight = 360 - _remWeight;
    }
    
    // 比例
    // 360 / 1  =  120 / 0.333333333
    _remWeight *= 0.333333333; //
    _remWeight = ABS(_remWeight);
    NSLog(@"remWeight = %f, _changedRadian=%f", _remWeight, _changedRadian);
    
    _showLabel.text = [NSString stringWithFormat:@"变化弧度 = %f \n变化角度 = %f \n变化体重 = %.2f Kg", _changedRadian, kRadianToAngel(_changedRadian),  _remWeight];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


