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

#pragma mark - Property Setters & Getters
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.maskView.backgroundColor = backgroundColor;
}
- (void)setBackgroundHeight:(CGFloat)backgroundHeight {
    _backgroundHeight = backgroundHeight;
    
    self.lastUpdate = [NSDate date];
}


- (void)setForegroundView:(UIView *)foregroundView {
    if (foregroundView == _foregroundView) {
        return;
    }
    
    if (_foregroundView) {
        _foregroundView.backgroundColor = self.maskView.backgroundColor;
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
        
        if ([_backgroundView isKindOfClass:[UIImageView class]]) {
            [_backgroundView removeObserver:self forKeyPath:@"image"];
        }
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
    foregroundScrollView.delegate = self;
    [self addSubview:foregroundScrollView];
    [self bringSubviewToFront:foregroundScrollView];
}

- (UIScrollView *)scrollViewFromForegroundView:(UIView *)foregroundView {
    UIScrollView *scrollView = nil;
    if (foregroundView) {
        if ([foregroundView isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)foregroundView;
        }
    }
    return scrollView;
}

#pragma mark Parallax Effect
@end
