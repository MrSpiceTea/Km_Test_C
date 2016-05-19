//
//  NSString+expanded.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/19.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (expanded)
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
