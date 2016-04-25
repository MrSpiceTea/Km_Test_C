//
//  ArtistDetailViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "SegmentedControl.h"

@interface SegmentedControl ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *selectionIndicator;
@property (nonatomic, assign) NSInteger touchedIndex;

- (UILabel *)labelForTitle:(NSString *)title inState:(UIControlState)state;

- (void)rearrangeSegmentsAnimated:(BOOL)animated;

- (void)segmentDidTapped:(UITapGestureRecognizer *)recognizer;

@end

@implementation SegmentedControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.tintColor = GlobalThemeColor;
    }
    
    return self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
        [self bringSubviewToFront:self.selectionIndicator];
    }
    
    return _scrollView;
}

static const CGFloat kSelectionIndicatorHeight = 2.0f;
- (UIView *)selectionIndicator {
    if (!_selectionIndicator) {
        UIView *indicator = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:indicator];
        
        _selectionIndicator = indicator;
        indicator.backgroundColor = self.tintColor;
    }
    
    return _selectionIndicator;
}

- (NSUInteger)numberOfSegments {
    return self.scrollView.subviews.count;
}

- (UILabel *)labelForTitle:(NSString *)title inState:(UIControlState)state {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = title;
    
    UIFont *font = [ThemeManage themeGolbalTitleFont];
    
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    
    if (state == UIControlStateSelected) {
        label.textColor = self.tintColor;
    } else {
        label.textColor = GlobalGrayColor;
    }
    
    [label sizeToFit];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentDidTapped:)];
    [label addGestureRecognizer:tapGR];
    
    label.userInteractionEnabled = YES;
    
    return label;
}

- (void)appendTitle:(NSString *)title animated:(BOOL)animated {
    [self insertSegmentWithTitle:title atIndex:self.numberOfSegments animated:animated];
}

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated {
    UIControlState state = UIControlStateNormal;
    
    if (self.selectedSegmentIndex == segment) {
        state = UIControlStateSelected;
    }
    
    UILabel *label = [self labelForTitle:title inState:state];
    
    [self.scrollView insertSubview:label atIndex:segment];
    
    [self rearrangeSegmentsAnimated:animated];
}

- (void)removeAllSegments {
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
}

- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated {
    UIView *view = self.scrollView.subviews[segment];
    
    [view removeFromSuperview];
    
    [self rearrangeSegmentsAnimated:animated];
}

- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex {
    [self setSelectedSegmentIndex:selectedSegmentIndex animated:NO];
}

static const NSTimeInterval kAnimationDuration = 0.5f;
- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex animated:(BOOL)animated {
    if (_selectedSegmentIndex == selectedSegmentIndex) {
        return;
    }
    
    NSUInteger oldIndex = _selectedSegmentIndex;
    
    _selectedSegmentIndex = selectedSegmentIndex;
    
    CGFloat height = CGRectGetHeight(self.bounds);
    
    UILabel *label = self.scrollView.subviews[oldIndex];
    label.textColor = GlobalGrayColor;
    
    label = self.scrollView.subviews[selectedSegmentIndex];
    CGRect selectionIndicatorFrame = CGRectMake(label.frame.origin.x, height - kSelectionIndicatorHeight, CGRectGetWidth(label.frame), kSelectionIndicatorHeight);
    
    void (^animations)() = ^{
        label.textColor = self.tintColor;
        
        self.selectionIndicator.frame = selectionIndicatorFrame;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {};
    
    if (animated) {
        UIViewAnimationOptions options = (UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseOut);
        [UIView animateWithDuration:kAnimationDuration delay:0 options:options animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)rearrangeSegmentsAnimated:(BOOL)animated {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGFloat segmentWidth = width / self.numberOfSegments;
    
    if (segmentWidth < self.minSegmentWidth) {
        segmentWidth = self.minSegmentWidth;
    }
    
    self.scrollView.contentSize = CGSizeMake(segmentWidth * self.numberOfSegments, height);
    
    UIViewAnimationOptions options = (UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseOut);
    
    CGRect selectionIndicatorFrame = CGRectMake(segmentWidth * self.selectedSegmentIndex, height - kSelectionIndicatorHeight, segmentWidth, kSelectionIndicatorHeight);
    
    void (^selectionIndicatorAnimations)() = ^{
        self.selectionIndicator.frame = selectionIndicatorFrame;
    };
    
    void (^selectionIndicatorCompletion)(BOOL) = ^(BOOL finished) {};
    
    void (^animations)() = ^{
        for (int i = 0;i < self.scrollView.subviews.count;i++) {
            UIView *subView = self.scrollView.subviews[i];
            
            subView.frame = CGRectMake(segmentWidth * i, 0, segmentWidth, height);
        }
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        UIView *selectedView = self.scrollView.subviews[self.selectedSegmentIndex];
        
        
        [self.scrollView scrollRectToVisible:selectedView.frame animated:animated];
    };
    
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration delay:0 options:options animations:selectionIndicatorAnimations completion:selectionIndicatorCompletion];
        [UIView animateWithDuration:kAnimationDuration delay:0 options:options animations:animations completion:completion];
    } else {
        selectionIndicatorAnimations();
        selectionIndicatorCompletion(YES);
        animations();
        completion(YES);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGRectEqualToRect(self.bounds, self.scrollView.frame)) {
        self.scrollView.frame = self.bounds;
        [self rearrangeSegmentsAnimated:NO];
    }
}

- (void)tintColorDidChange {
    self.selectionIndicator.backgroundColor = self.tintColor;
    
    UILabel *label = nil;
    
    if (self.scrollView.subviews.count > 0 && self.selectedSegmentIndex < self.scrollView.subviews.count) {
        label = self.scrollView.subviews[self.selectedSegmentIndex];
        label.textColor = self.tintColor;
    }
}

- (void)segmentDidTapped:(UITapGestureRecognizer *)recognizer {
    UIView *sender = recognizer.view;
    
    NSUInteger index = [self.scrollView.subviews indexOfObject:sender];
    
    if (index != NSNotFound) {
        [self setSelectedSegmentIndex:index animated:YES];
    }
}

@end
