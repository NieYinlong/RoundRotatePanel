//
//  RoundRotatePanel.h
//  圆盘刻度尺
//
//  Created by nyl on 2018/5/9.
//  Copyright © 2018年 nieyinlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundRotatePanel : UIControl
/**
 *  中心点的坐标值
 */
@property (nonatomic, assign) CGPoint centerPoint;


@property (nonatomic, assign) CGFloat changedRadian;

/**
 *  将图层旋转radian弧度
 *  @param radian 旋转的弧度
 */
- (void)rotateByRadian:(CGFloat)radian;


@end
