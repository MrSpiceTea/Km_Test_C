//
//  UIView+animation.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/6/2.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "UIView+animation.h"

@implementation UIView (animation)
- (void)startSelectedAnimation{
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    ani.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    ani.duration = 0.4;
    [self.layer addAnimation:ani forKey:@"transformAni"];
}

@end
