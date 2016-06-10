//
//  UILabel+expanded.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/23.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "UILabel+expanded.h"
#import "NSString+expanded.h"

@implementation UILabel (expanded)

- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width{
    [self setLongString:str withFitWidth:width maxHeight:CGFLOAT_MAX];
}

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight{
    self.numberOfLines = 0;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    CGFloat resultHeight = resultSize.height;
    if (maxHeight > 0 && resultHeight > maxHeight) {
        resultHeight = maxHeight;
    }
    CGRect frame = self.frame;
    frame.size.height = resultHeight;
    [self setFrame:frame];
    self.text = str;
}

- (void) setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth{
    self.numberOfLines = 0;
    self.text = str;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    CGRect frame = self.frame;
    frame.size.height = resultSize.height;
    frame.size.width = resultSize.width;
    [self setFrame:frame];
}


@end
