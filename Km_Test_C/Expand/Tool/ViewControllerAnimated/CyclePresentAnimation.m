//
//  CyclePresentAnimation.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/21.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "CyclePresentAnimation.h"


@implementation CyclePresentAnimation

+ (instancetype)transitionWithTransitionType:(CyclePresentTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(CyclePresentTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    
//    [toViewController.view setFrame:CGRectMake(010, kSCREEN_HEIGHT - 40, 30, 30)];
//    [toViewController.view.layer setCornerRadius:CGRectGetHeight(toViewController.view.frame)];
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toViewController.view];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        toViewController.view.layer.transform = CATransform3DIdentity;
////        toViewController.view.transform = CGAffineTransformMakeScale(2, 2);
//        toViewController.view.center = CGPointMake(kSCREEN_WIDTH/2, kSCREEN_HEIGHT/2);
////         [toViewController.view.layer setCornerRadius:CGRectGetHeight(toViewController.view.frame)];
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
//
    
    switch (_type) {
        case CyclePresentTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case CyclePresentTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
        default:
            break;
    }

}
    
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //拿到控制器获取button的frame来设置动画的开始结束的路径
    //    UINavigationController *fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect fromButtonFrame = CGRectMake(15, kSCREEN_HEIGHT - 99, 30, 30);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    //画两个圆路径
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:fromButtonFrame];
    //通过如下方法计算获取在x和y方向按钮距离边缘的最大值，然后利用勾股定理即可算出最大半径
    CGFloat x = MAX(fromButtonFrame.origin.x, fromButtonFrame.size.width - fromButtonFrame.origin.x);
    CGFloat y = MAX(fromButtonFrame.origin.y, fromButtonFrame.size.height - fromButtonFrame.origin.y);
    //勾股定理计算半径
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    //以按钮中心为圆心，按钮中心到屏幕边缘的最大距离为半径，得到转场后的path
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //设置layer的path保证动画后layer不会回弹
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    //设置淡入淡出
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    
    
    [transitionContext completeTransition:YES];

}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]; 
    CGRect fromButtonFrame = CGRectMake(15, kSCREEN_HEIGHT - 99, 30, 30);
    UIView *containerView = [transitionContext containerView];
    //画两个圆路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:fromButtonFrame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    
    
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

    
}
@end

