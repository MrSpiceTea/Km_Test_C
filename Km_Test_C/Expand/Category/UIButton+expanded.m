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
@end
