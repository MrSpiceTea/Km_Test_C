//
//  ArtistDetailViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "SlideView.h"
#import "RemorsefulScrollView.h"

@interface SlideView () <UIScrollViewDelegate>

@property (nonatomic, weak) RemorsefulScrollView *scrollView;

@property (nonatomic, assign, getter = isDraging) BOOL draging;
@property (nonatomic, assign) BOOL indexIsSettedOutside;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated shouldAjustScrollViewContentOffset:(BOOL)shouldAjust;

@end

@implementation SlideView

- (void)setSlideDisabled:(BOOL)slideDisabled {
    _slideDisabled = slideDisabled;

    self.scrollView.scrollEnabled = !slideDisabled;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        RemorsefulScrollView *scrollView = [[RemorsefulScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    
    return _scrollView;
}

static const NSTimeInterval kAnimationDuration = 0.5;
- (void)appendSlide:(UIView *)slide animated:(BOOL)animated {
    [self insertSlide:slide atIndex:self.scrollView.subviews.count animated:animated];
}

- (void)setVertical:(BOOL)vertical {
    if (_vertical == vertical) {
        return;
    }
    
    _vertical = vertical;
    
    if (vertical) {
        self.scrollView.alwaysBounceVertical = YES;
        self.scrollView.alwaysBounceHorizontal = NO;
    } else {
        self.scrollView.alwaysBounceVertical = NO;
        self.scrollView.alwaysBounceHorizontal = YES;
    }
    
    [self rearrangeSlidesAnimated:YES];
}

- (void)insertSlide:(UIView *)slide atIndex:(NSUInteger)index animated:(BOOL)animated {
    if (index > self.scrollView.subviews.count) {
        index = self.scrollView.subviews.count;
    }
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    slide.frame = CGRectZero;
    
    [self.scrollView insertSubview:slide atIndex:index];
    
    CGRect frame = self.bounds;
    
    CGSize contentSize = self.scrollView.contentSize;
    
    if (self.isVertical) {
        contentSize.width = 0;
        contentSize.height += height;
        frame.origin.y = height * index;
    } else {
        contentSize.width += width;
        contentSize.height = 0;
        frame.origin.x = width * index;
    }
    
    UIViewAnimationOptions options = (UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut);
    
    void (^siblingViewAnimations)() = ^{
        for (NSUInteger i = index;i < self.scrollView.subviews.count;i++) {
            UIView *subView = self.scrollView.subviews[i];
            CGRect subViewFrame = self.bounds;
            
            if (self.isVertical) {
                subViewFrame.origin.y = i * height;
            } else {
                subViewFrame.origin.x = i * width;
            }
            
            subView.frame = subViewFrame;
        }
    };
    
    void (^siblingViewComplection)(BOOL) = ^(BOOL finished) {};
    
    void (^slideAnimations)() = ^{
        slide.frame = frame;
        
        if (self.scrollView.subviews.count < 2) {
            self.scrollView.contentSize = CGSizeZero;
        } else {
            self.scrollView.contentSize = contentSize;
        }
    };
    
    void (^slideCompletion)(BOOL) = ^(BOOL finished) {};
    
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration delay:0 options:options animations:siblingViewAnimations completion:siblingViewComplection];
        [UIView animateWithDuration:kAnimationDuration delay:kAnimationDuration / 5 options:options animations:slideAnimations completion:slideCompletion];
    } else {
        siblingViewAnimations();
        siblingViewComplection(YES);
        slideAnimations();
        slideCompletion(YES);
    }
}

- (UIView *)slideOfIndex:(NSUInteger)index {
    if (index < self.scrollView.subviews.count) {
        return self.scrollView.subviews[index];
    } else {
        return nil;
    }
}

- (NSUInteger)numOfSlides {
    return self.scrollView.subviews.count;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    [self setSelectedIndex:selectedIndex animated:animated shouldAjustScrollViewContentOffset:YES];
    
    if (!self.isDraging) {
        self.indexIsSettedOutside = YES;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated shouldAjustScrollViewContentOffset:(BOOL)shouldAjust {
    NSUInteger oldSelectedIndex = _selectedIndex;
    
    if (selectedIndex >= self.scrollView.subviews.count) {
        selectedIndex = self.scrollView.subviews.count - 1;
    }
    
    _selectedIndex = selectedIndex;
    
    if (shouldAjust && !self.isDraging) {
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        
        CGPoint contentOffset = CGPointZero;
        
        if (self.isVertical) {
            contentOffset.y = height * selectedIndex;
        } else {
            contentOffset.x = width * selectedIndex;
        }
        
        [self.scrollView setContentOffset:contentOffset animated:animated];
    }
    
    if (oldSelectedIndex != selectedIndex && !self.indexIsSettedOutside) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)rearrangeSlidesAnimated:(BOOL)animated {
    UIViewAnimationOptions options = (UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut);
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGSize contentSize = CGSizeZero;
    
    if (self.isVertical) {
        contentSize.width = 0;
        contentSize.height = height * self.scrollView.subviews.count - 1;
    } else {
        contentSize.width = width * self.scrollView.subviews.count - 1;
        contentSize.height = 0;
    }
    
    self.scrollView.contentSize = contentSize;
    
    void (^animations)() = ^{
        for (NSUInteger i = 0;i < self.scrollView.subviews.count;i++) {
            UIView *subView = self.scrollView.subviews[i];
            CGRect subViewFrame = self.bounds;
            
            if (self.isVertical) {
                subViewFrame.origin.y = i * height;
            } else {
                subViewFrame.origin.x = i * width;
            }
            
            subView.frame = subViewFrame;
        }
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {};
    
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration delay:0 options:options animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
    
    [self setSelectedIndex:self.selectedIndex animated:animated shouldAjustScrollViewContentOffset:YES];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGRectEqualToRect(self.bounds, self.scrollView.frame)) {
        self.scrollView.frame = self.bounds;
        [self rearrangeSlidesAnimated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    NSUInteger selectedIndex = 0;
    
    CGPoint contentOffset = scrollView.contentOffset;
    
    if (self.isVertical) {
        selectedIndex = floor((scrollView.contentOffset.y - height / 2) / height) + 1;
        contentOffset.x = 0;
    } else {
        selectedIndex = floor((scrollView.contentOffset.x - width / 2) / width) + 1;
        contentOffset.y = 0;
    }
    
    scrollView.contentOffset = contentOffset;
    
    [self setSelectedIndex:selectedIndex animated:NO shouldAjustScrollViewContentOffset:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.draging = YES;
    self.indexIsSettedOutside = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.draging = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.indexIsSettedOutside = NO;
}

- (NSArray *)slides {
    return self.scrollView.subviews;
}

@end
