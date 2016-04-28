//
//  ParallaxView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ParallaxView.h"

@interface ParallaxView ()
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

#pragma mark - GET/SET
- (void)setBackgroundHeight:(CGFloat)backgroundHeight{
    
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

@end
