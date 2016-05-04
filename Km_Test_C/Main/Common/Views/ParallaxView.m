//
//  ParallaxView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ParallaxView.h"

@interface ParallaxView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *foregroundScrollView;

@property (nonatomic, weak) UIView *backgroundContainer;
@property (nonatomic, weak) UIView *maskView;
@property (nonatomic, strong) NSDate *lastUpdate;
@end
@implementation ParallaxView
static const CGFloat kDefaultBackgroundHeight = 150.0f;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        [self initialize];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}
- (void)initialize {
    self.backgroundHeight = kDefaultBackgroundHeight;
}

- (UIView *)backgroundContainer {
    if (!_backgroundContainer) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [self addSubview:view];
        [self sendSubviewToBack:view];
        view.backgroundColor = [UIColor blackColor];
        _backgroundContainer = view;
    }
    
    return _backgroundContainer;
}

- (UIView *)maskView {
    if (!_maskView) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [self insertSubview:view aboveSubview:self.backgroundContainer];
        view.backgroundColor = self.backgroundColor;
        _maskView = view;
    }
    
    return _maskView;
}


- (UIScrollView *)scrollViewFromForegroundView:(UIView *)foregroundView {
    UIScrollView *scrollView = nil;
    if (foregroundView) {
        if ([foregroundView isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)foregroundView;
        }else {
            //            scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            
        }
        
    }
    return scrollView;
}


#pragma mark - Property Setters & Getters
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.maskView.backgroundColor = backgroundColor;
}
- (void)setBackgroundHeight:(CGFloat)backgroundHeight {
    _backgroundHeight = backgroundHeight;
    [self setContentInset:self.contentInset];
    [self updateParallaxEffect];
    self.lastUpdate = [NSDate date];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;
    [self updateParallaxEffect];
}


- (void)setForegroundView:(UIView *)foregroundView {
    if (foregroundView == _foregroundView) {
        return;
    }
    
    if (_foregroundView) {
//        _foregroundView.backgroundColor = self.maskView.backgroundColor;
        [_foregroundView removeFromSuperview];
    }
    
    
    _foregroundView = foregroundView;
    
    self.foregroundScrollView = [self scrollViewFromForegroundView:foregroundView];
    self.maskView.backgroundColor = self.foregroundScrollView.backgroundColor;
    self.foregroundScrollView.backgroundColor = [UIColor clearColor];
}
- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView == _backgroundView) {
        return;
    }
    
    if (_backgroundView) {
        [_backgroundView removeFromSuperview];
        
//        if ([_backgroundView isKindOfClass:[UIImageView class]]) {
//            [_backgroundView removeObserver:self forKeyPath:@"image"];
//        }
    }
    
    _backgroundView = backgroundView;
    
    if (backgroundView) {
        [self.backgroundContainer addSubview:backgroundView];
    }
}

- (void)setForegroundScrollView:(UIScrollView *)foregroundScrollView {
    if (_foregroundScrollView) {
        [_foregroundScrollView removeFromSuperview];
    }
    
    _foregroundScrollView = foregroundScrollView;
    
    if (foregroundScrollView) {
        
            foregroundScrollView.frame = self.bounds;
            foregroundScrollView.contentInset = UIEdgeInsetsMake(self.backgroundHeight + self.foregroundOffsetY + self.contentInset.top, self.contentInset.left, self.contentInset.bottom, self.contentInset.right);
            
            CGSize contentSize = foregroundScrollView.contentSize;
            CGFloat minContentHeight = CGRectGetHeight(self.bounds) - self.contentInset.top - self.contentInset.bottom - self.foregroundOffsetY;
            
            if (contentSize.height < minContentHeight) {
                contentSize.height = minContentHeight;
                foregroundScrollView.contentSize = contentSize;
            }
        
        
        if ([self canSeeThroughToBackgroundView]) {
            [foregroundScrollView setContentOffset:self.contentOffset animated:YES];
        } else if ([self canSeeThroughToBackgroundViewOfContentOffset:foregroundScrollView.contentOffset]) {
            CGFloat contentOffsetY = self.contentOffset.y;
            CGFloat foregroundScrollViewHeight = CGRectGetHeight(foregroundScrollView.bounds);
            CGFloat foregroundScrollViewContentSizeHeight = foregroundScrollView.contentSize.height;
            
            if (contentOffsetY + foregroundScrollViewHeight > foregroundScrollViewContentSizeHeight) {
                contentOffsetY = -self.contentInset.top - self.foregroundOffsetY;
            }
            
            _contentOffset = CGPointMake(0, contentOffsetY);
            [foregroundScrollView setContentOffset:_contentOffset animated:YES];
        } else {
            _contentOffset = foregroundScrollView.contentOffset;
        }
        
//        foregroundScrollView.paralaxLastUpdateDate = self.lastUpdate;
//        foregroundScrollView.parallaxView = self;
        foregroundScrollView.delegate = self;
        [self addSubview:foregroundScrollView];
        [self bringSubviewToFront:foregroundScrollView];
    
    }}

- (void)updateParallaxEffect {
    // We hacked the UIScrollView here to bring the toolbarView up to front but below the scroll indictor
    // If the the toolbarView hierarchy is wired in the comming version (>7.1.0), just fix it here.
//    if (self.toolbarView && self.foregroundView.subviews[0] == self.toolbarView) {
//        [self.toolbarView removeFromSuperview];
//        
//        for (UIView *view in self.foregroundScrollView.subviews) {
//            if ([view isKindOfClass:[UIImageView class]]) {
//                if (view.alpha > 0) {
//                    [self.foregroundScrollView insertSubview:self.toolbarView belowSubview:view];
//                }
//            }
//        }
//    }
//    
    [self updateBackgroundViewPos];
    [self updateMaskViewPos];
//    [self updateToolbarViewPos];
}
#pragma mark - UIView Overrides
- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateBackgroundFrame];
    [self updateForegroundFrame];
    [self updateParallaxEffect];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.backgroundView) {
        CGFloat backgroundViewHeight = CGRectGetHeight(self.backgroundView.bounds);
        
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        
        if (contentOffsetY < 0 && contentOffsetY < -(backgroundViewHeight + self.foregroundOffsetY)) {
            contentOffsetY = -(backgroundViewHeight + self.foregroundOffsetY);
        }
        
        scrollView.contentOffset = CGPointMake(0, contentOffsetY);
    }
    _contentOffset = scrollView.contentOffset;
    [self updateParallaxEffect];
    
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

#pragma mark Parallax Effect
- (void)updateBackgroundFrame {
    if (!self.backgroundView) {
        return;
    }
    
    CGFloat width = CGRectGetWidth(self.bounds);
    
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize size = [self.backgroundView sizeThatFits:maxSize];
    
    if ([self.backgroundView isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self.backgroundView;
        
        if (imageView.image) {
            CGImageRef imgRef = [imageView.image CGImage];
            CGFloat imageWidth = CGImageGetWidth(imgRef);
            CGFloat imageHeight = CGImageGetHeight(imgRef);
            
            CGFloat ratio = width / imageWidth;
            
            size.height = imageHeight * ratio;
        }
        
    }
    CGRect frame = CGRectZero;
    frame.size.width = width;
    frame.size.height = size.height;
    
    if (!CGRectEqualToRect(self.backgroundView.frame, frame)) {
        self.backgroundView.frame = frame;
    }

    
    [self updateBackgroundViewPos];
}

- (void)updateForegroundFrame {
    if (!self.foregroundView) {
        return;
    }
    
    self.foregroundScrollView.delegate = nil;
    
    if (self.foregroundView != self.foregroundScrollView) {
        CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
        CGSize size = [self.foregroundView sizeThatFits:maxSize];
        
        CGRect frame = CGRectZero;
        frame.size.width = size.width;
        frame.size.height = size.height;
        
        self.foregroundView.frame = frame;
        self.foregroundScrollView.contentSize = CGSizeMake(size.width, size.height);
    }
    
    self.foregroundScrollView.frame = self.bounds;
    
    self.foregroundScrollView.contentInset = UIEdgeInsetsMake(self.backgroundHeight + self.foregroundOffsetY + self.contentInset.top, self.contentInset.left, self.contentInset.bottom, self.contentInset.right);
    
    CGSize contentSize = self.foregroundScrollView.contentSize;
    CGFloat minContentHeight = CGRectGetHeight(self.bounds) - self.contentInset.top - self.contentInset.bottom - self.foregroundOffsetY;
    
    if (contentSize.height < minContentHeight) {
        contentSize.height = minContentHeight;
        self.foregroundScrollView.contentSize = contentSize;
    }
    
    [self.foregroundScrollView setContentOffset:self.contentOffset animated:NO];
    
    self.foregroundScrollView.delegate = self;
    [self updateParallaxEffect];
}

- (void)updateBackgroundViewPos {
    if (self.backgroundView) {
        CGFloat bgViewHeight = CGRectGetHeight(self.backgroundView.bounds);
        
        
        CGPoint bgCenter = CGPointMake(CGRectGetWidth(self.bounds) / 2, 0);
        
        CGFloat viewportHeight = [self viewportHeight];
        
        if (viewportHeight > bgViewHeight) {
            bgCenter.y = viewportHeight - bgViewHeight / 2;
        } else {
            bgCenter.y = viewportHeight / 2;
        }
        
        self.backgroundView.center = bgCenter;
    }
}

- (void)updateMaskViewPos {
    CGFloat viewportHeight = self.viewportHeight;
    CGRect frame = self.maskView.frame;
    CGPoint point = CGPointMake(0, viewportHeight + self.foregroundOffsetY);
    frame.origin.y = point.y;
    
    self.maskView.frame = frame;
}
/**
 *  viewportHeight is calculated without contentInset.top
 *
 *  @return viewport height without contentInset.top
 */
- (CGFloat)viewportHeight {
    return [self viewportHeightOfContentOffset:self.contentOffset];
}

- (CGFloat)viewportHeightOfContentOffset:(CGPoint)contentOffset {
    CGFloat viewportHeight = -contentOffset.y - self.foregroundOffsetY;
    
    if (viewportHeight < self.contentInset.top) {
        viewportHeight = self.contentInset.top;
    }
    
    return viewportHeight;
}

- (BOOL)canSeeThroughToBackgroundView {
    return [self canSeeThroughToBackgroundViewOfContentOffset:self.contentOffset];
}

- (BOOL)canSeeThroughToBackgroundViewOfContentOffset:(CGPoint)contentOffset {
    return [self viewportHeightOfContentOffset:contentOffset] > self.contentInset.top;
}

@end
