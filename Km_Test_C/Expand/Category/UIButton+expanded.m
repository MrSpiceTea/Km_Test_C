//
//  UIButton+expanded.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/23.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "UIButton+expanded.h"
#import "UIView+Frame.h"
#import "NSString+expanded.h"

@implementation UIButton (expanded)
+ (UIButton*)buttonWidthTitle:(NSString *)title frame:(CGRect )frame  target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)setTitle:(NSString *)title font:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    [self setTitle:title forState:UIControlStateNormal];
    CGRect frame = self.frame;
    CGFloat titleWidth = [self.titleLabel.text getWidthWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, frame.size.height)];
    if (titleWidth > maxWidth) {
        titleWidth = maxWidth;
        //        self.titleLabel.minimumScaleFactor = 0.5;
        //        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    [self setWidth:titleWidth];
    [self.titleLabel setWidth:titleWidth];
}

- (void)touchAction{
    
}
@end
