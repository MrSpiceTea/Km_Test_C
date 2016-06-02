//
//  UIButton+expanded.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/23.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (expanded)

+ (UIButton*)buttonWidthTitle:(NSString *)title frame:(CGRect )frame  target:(id)target action:(SEL)action;
@end
