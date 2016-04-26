//
//  SlideView.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideView : UIControl
@property (nonatomic, assign, getter = isVertical) BOOL vertical;
@property (nonatomic, assign) NSUInteger numOfSlides;
@property (nonatomic, assign) NSUInteger selectedIndex;
- (void)appendSlide:(UIView *)slide animated:(BOOL)animated;
- (void)insertSlide:(UIView *)slide atIndex:(NSUInteger)index animated:(BOOL)animated;
- (UIView *)slideOfIndex:(NSUInteger)index;
- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;
- (void)rearrangeSlidesAnimated:(BOOL)animated;


@end
