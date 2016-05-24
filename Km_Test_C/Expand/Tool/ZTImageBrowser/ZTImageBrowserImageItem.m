//
//  ZTImageBrowserImageItem.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

const CGFloat kMaximumZoomScale = 3.0f;
const CGFloat kMinimumZoomScale = 1.0f;
const CGFloat kDuration = 0.18f;

#import "ZTImageBrowserImageItem.h"

@interface ZTImageBrowserImageItem()<UIScrollViewDelegate>

@end

@implementation ZTImageBrowserImageItem

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.maximumZoomScale = kMaximumZoomScale;
        self.minimumZoomScale = kMinimumZoomScale;
        self.zoomScale = 1.0f;
        [self addSubview:self.imageView];
        [self setupGestures];
    }
    return self;
}

- (void)setupGestures{
    
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
@end
