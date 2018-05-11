//
//  ViewController.m
//  圆盘刻度尺
//
//  Created by nyl on 2018/5/9.
//  Copyright © 2018年 nieyinlong. All rights reserved.
//

#import "ViewController.h"
#import "RoundScaleVC.h"
#import "DIYWeightVC.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVIew];
}

- (void)initVIew {
    
    NSArray *titles = @[@"圆盘刻度尺(逆时针增大)", @"自定义(顺时针增大)"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(10, 100 + i*50, 360, 20);
        [btn setTitle:titles[i] forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [self.view addSubview:btn];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnCLick:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
 
    
}


- (void)btnCLick:(UIButton *)btn {
    if (btn.tag == 100) {
        RoundScaleVC *VC =  [RoundScaleVC new];
        [self.navigationController pushViewController:VC animated:YES];
    } else if (btn.tag == 101) {
        DIYWeightVC *VC =  [DIYWeightVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


@end
