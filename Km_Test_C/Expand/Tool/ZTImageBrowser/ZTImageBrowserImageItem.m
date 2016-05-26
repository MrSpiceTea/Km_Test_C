//
//  ZTImageBrowserImageItem.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

const CGFloat kMaximumZoomScale = 3.0f;
const CGFloat kMinimumZoomScale = 1.0f;
const CGFloat kDuration = 0.3f;

#import "ZTImageBrowserImageItem.h"
#import "ZTimageBrowserSheetView.h"
#import <UIImageView+WebCache.h>

@interface ZTImageBrowserImageItem()<UIScrollViewDelegate>
@property (nonatomic,strong) ZTimageBrowserSheetView *sheetView;
@property (nonatomic,assign) BOOL showsSheetView;
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
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handledoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;

    UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImage:)];
    longPressGesture.minimumPressDuration = 0.5;//设置长按时间
    
    [self addGestureRecognizer:singleTap];
    [self addGestureRecognizer:doubleTap];
    [self addGestureRecognizer:longPressGesture];
    [singleTap requireGestureRecognizerToFail:doubleTap];
}

#pragma mark - GestureRecognizer
- (void)handleSingleTap:(UITapGestureRecognizer *)gesture{
    if (gesture.numberOfTapsRequired == 1) {
        if (_showsSheetView) {
            [self showSheetView:NO];
        }else{
            if (self.zoomScale != 1.0f) {
                self.zoomScale = 1.0f;
            }
            [self.imageItemDelegate disMissBrowser];
        }
    }
}

- (void)handledoubleTap:(UITapGestureRecognizer *)gesture{
    if (gesture.numberOfTapsRequired == 2) {
        if(self.zoomScale == 1){
            float newScale = [self zoomScale] * 2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:self]];
            [self zoomToRect:zoomRect animated:YES];
        } else {
            float newScale = [self zoomScale] / 2;
            CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:self]];
            [self zoomToRect:zoomRect animated:YES];
        }
    }
}

- (void)longPressImage:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (!_showsSheetView) {
            [self showSheetView:YES];
        }else{
            [self showSheetView:NO];
        }
    }
}

#pragma mark - Helper
- (void)loadHdImage:(BOOL)animated {
    CGRect destinationRect = [self calculateDestinationFrameWithSize:self.imageModel.placeholder.size];
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    BOOL isImageCached = [manager cachedImageExistsForURL:self.imageModel.HDURL];
    __weak typeof(self) weakSelf = self;
    //还未下载的图片
    if (!isImageCached) {
        self.imageView.image = self.imageModel.thumbnailImage;
        if (animated) {
            self.imageView.frame  = self.imageModel.srcImageViewRect;
            [UIView animateWithDuration:0.18f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
               weakSelf.imageView.center = weakSelf.center;
            }completion:^(BOOL finished) {
               if(finished) {
                [weakSelf downloadImageWithDestinationRect:destinationRect];
              }
           }];
        } else {
            weakSelf.imageView.center = weakSelf.center;
            [self downloadImageWithDestinationRect:destinationRect];
        }
    }
    //已经下载的图片
    else {
        if (animated) {
            self.imageView.frame  = self.imageModel.srcImageViewRect;
            [self.imageView sd_setImageWithURL:self.imageModel.HDURL];
            [UIView animateWithDuration:kDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.imageView.frame = destinationRect;
            } completion:^(BOOL finished) {
            }];
        } else {
            [self.imageView sd_setImageWithURL:self.imageModel.HDURL];
            self.imageView.frame = destinationRect;
        }
    }
  
}

- (void)downloadImageWithDestinationRect:(CGRect)destinationRect{
    __weak typeof(self) weakSelf = self;
    SDWebImageManager* manager = [SDWebImageManager sharedManager];
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [manager downloadImageWithURL:self.imageModel.HDURL options:options
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 //TODO:加载动画进度条
                             }completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                 if (finished) {
                                     weakSelf.imageView.image = image;
                                     weakSelf.imageModel.thumbnailImage = image;
                                     // 通知
                                     [UIView animateWithDuration:0.2f animations:^{
                                         weakSelf.imageView.frame = destinationRect;
                                     } completion:^(BOOL finished) {
                                     }];
                                 }
                             }];
    });
}

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width = [self frame].size.width / scale;
    zoomRect.origin.x = center.x - zoomRect.size.width / 2;
    zoomRect.origin.y = center.y - zoomRect.size.height / 2;
    return zoomRect;
}

- (void)showSheetView:(BOOL)show{
    [self.sheetView show:show];
}

- (CGRect)calculateDestinationFrameWithSize:(CGSize)size{
    CGRect rect = CGRectMake(0.0f,
                             (kSCREEN_HEIGHT - size.height * kSCREEN_WIDTH/size.width)/2,
                             kSCREEN_WIDTH,
                             size.height * kSCREEN_WIDTH/size.width);
    return rect;
}

#pragma mark - UIScrollViewDelegate
/**
 *  缩放对象
 *
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

/**
 *  缩放结束
 *
 */
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [scrollView setZoomScale:scale + 0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark - Getter
- (UIImageView *)imageView {
    if (!_imageView) {
//        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
         _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.userInteractionEnabled = YES;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (ZTimageBrowserSheetView *)sheetView{
    if (!_sheetView) {
        _sheetView = [[ZTimageBrowserSheetView alloc]initWithFrame:self.bounds];
        [self addSubview:_sheetView];
    }
    return _sheetView;
}

#pragma mark - Setter
- (void)setImageModel:(ZTImageBrowserModel *)imageModel{
    if (_imageModel != imageModel) {
        _imageModel = imageModel;
    }
    if (!self.isFirstShow) {
        [self loadHdImage:YES];
    }
    else {
        [self loadHdImage:NO];
    }
}
@end
