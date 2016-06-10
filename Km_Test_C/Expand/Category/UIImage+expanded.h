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
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)scaleFromImage: (UIImage *) image toSize: (CGSize) size;
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;
//+ (UIImage *)screenShotWidthView:(UIView *)aView;
@end
