//
//  UINavigationBar+expanded.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/22.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "UINavigationBar+expanded.h"
#import <objc/runtime.h>

@implementation UINavigationBar (expanded)
static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cnSetBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        [self setShadowImage:[UIImage new]];        // insert an overlay into the view hierarchy
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
 
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)cnReset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
