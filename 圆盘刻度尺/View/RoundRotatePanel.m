//
//  RoundRotatePanel.m
//  圆盘刻度尺
//
//  Created by nyl on 2018/5/9.
//  Copyright © 2018年 nieyinlong. All rights reserved.
//

#import "RoundRotatePanel.h"

@implementation RoundRotatePanel



- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint location = [touch locationInView:self];
    CGFloat previousRadian = [self radianToCenterPoint:self.centerPoint withPoint:previousLocation];
    CGFloat curRadian = [self radianToCenterPoint:self.centerPoint withPoint:location];
    CGFloat changedRadian = curRadian - previousRadian;
    
    
    
    self.changedRadian = changedRadian;// 记录
    [self rotateByRadian:changedRadian];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

/**
 *  以ColorPanel的anchorPoint为坐标原点建立坐标系，计算坐标点|point|与坐标原点的连线距离x轴正方向的夹角
 *  @param centerPoint 坐标原点坐标
 *  @param point       某坐标点
 *
 *  @return 坐标点|point|与坐标原点的连线距离x轴正方向的夹角
 */
- (CGFloat)radianToCenterPoint:(CGPoint)centerPoint withPoint:(CGPoint)point {
    CGVector vector = CGVectorMake(point.x - centerPoint.x, point.y - centerPoint.y);
    return atan2f(vector.dy, vector.dx);
}

/**
 *  将图层旋转radian弧度
 *  @param radian 旋转的弧度
 */
- (void)rotateByRadian:(CGFloat)radian {
    
    CGAffineTransform transform = self.layer.affineTransform;
    transform = CGAffineTransformRotate(transform, radian);
    self.layer.affineTransform = transform;
}

@end
