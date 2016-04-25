//
//  SlideView.h
//  dFiM音乐
//
//  Created by Ken M.Hwang on 6/4/14.
//  Copyright (c) 2014 广州鼎梵有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideView : UIControl

@property (nonatomic, assign) BOOL slideDisabled;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign, getter = isVertical) BOOL vertical;
@property (nonatomic, assign) NSUInteger numOfSlides;

- (NSArray *)slides;

- (void)appendSlide:(UIView *)slide animated:(BOOL)animated;
- (void)insertSlide:(UIView *)slide atIndex:(NSUInteger)index animated:(BOOL)animated;
- (UIView *)slideOfIndex:(NSUInteger)index;
- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;
- (void)rearrangeSlidesAnimated:(BOOL)animated;


@end
