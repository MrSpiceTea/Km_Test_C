//
//  UIImage+expanded.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/22.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (expanded)
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
+ (UIImage *)imageOfRoundRectWithImage: (UIImage *)image
                                  size: (CGSize)size
                                radius: (CGFloat)radius;
@end
