//
//  SegemtedControl.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "SegemtedControl.h"

@interface SegemtedControl ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *selectionIndicator;
@property (nonatomic, assign) NSInteger touchedIndex;
@end

@implementation SegemtedControl

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
//
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    if (!CGRectEqualToRect(self.bounds, self.scrollView.frame)) {
//        self.scrollView.frame = self.bounds;
//        [self rearrangeSegmentsAnimated:NO];
//    }
//}

- (void)appendTitle:(NSString *)title animated:(BOOL)animated{
    [self insertSegmentWithTitle:title atIndex:self.numberOfSegments animated:animated];

}

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = title;
    
    [self.scrollView insertSubview:label atIndex:segment];
    [self rearrangeSegmentsAnimated:animated];
}


- (void)rearrangeSegmentsAnimated:(BOOL)animated {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat segemtedWidth = width/self.numberOfSegments;
    
    CGRect selectionIndicatorRect = CGRectMake(self.selectedSegmentIndex*segemtedWidth, height - kSelectionIndicatorHeight, segemtedWidth, kSelectionIndicatorHeight);
    self.scrollView.contentSize = CGSizeMake(width, height);

    void(^selectionIndicatorAnimations)() = ^{
        self.selectionIndicator.frame = selectionIndicatorRect;
    };
    
    void(^animations)() = ^{
        for (int i = 0; i<self.scrollView.subviews.count;i++) {
            UIView *view = self.scrollView.subviews[i];
            [view setFrame:CGRectMake(segemtedWidth*i, height - kSelectionIndicatorHeight, segemtedWidth, kSelectionIndicatorHeight)];
        }
    };
    
    
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration animations:selectionIndicatorAnimations];
        [UIView animateWithDuration:kAnimationDuration animations:animations completion:nil];
    }else{
        selectionIndicatorAnimations();
        animations();
    }
   
}
static const NSTimeInterval kAnimationDuration = 0.5f;
- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex animated:(BOOL)animated{
    if (_selectedSegmentIndex == selectedSegmentIndex) {
        return;
    }
    
    NSUInteger oldIndex = _selectedSegmentIndex;
    
    _selectedSegmentIndex = selectedSegmentIndex;
    
    CGFloat height = CGRectGetHeight(self.bounds);
    
    UILabel *label = self.scrollView.subviews[oldIndex];
    label.textColor = [UIColor blueColor];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segmentDidTapped:)];
    [label addGestureRecognizer:tapGR];
    
    label.userInteractionEnabled = YES;
    
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

}

- (void)segmentDidTapped:(UITapGestureRecognizer *)recognizer {
    UIView *sender = recognizer.view;
    
    NSUInteger index = [self.scrollView.subviews indexOfObject:sender];
    
    if (index != NSNotFound) {
        [self setSelectedSegmentIndex:index animated:YES];
    }
}

#pragma mark - GET/SET
- (NSUInteger)numberOfSegments {
    return self.scrollView.subviews.count;
}

static const CGFloat kSelectionIndicatorHeight = 2.0f;

- (UIView *)selectionIndicator{
    if (_selectionIndicator) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:view];
        _selectionIndicator = view;
        view.backgroundColor = self.tintColor;
    }
    return _selectionIndicator;
}

- (UIScrollView *)scrollView{
    if (_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        [self bringSubviewToFront:self.selectionIndicator];
    }
    return _scrollView;
}
@end
