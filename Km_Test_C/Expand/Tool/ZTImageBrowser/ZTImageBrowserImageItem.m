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
const CGFloat kSheetViewHeight = 160.f;

#import "ZTImageBrowserImageItem.h"
#import "ZTimageBrowserSheetView.h"
#import "UIView+Frame.h"

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
    UITapGestureRecognizer *tapDisMissGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tapDisMissGesture.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *tapBigGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBigGestureAction:)];
    tapBigGesture.numberOfTapsRequired = 2;
    
    UIPinchGestureRecognizer *pinchGesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchImage:)];
//    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panImage:)];
    
    //吃长安
    UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressImage:)];
    longPressGesture.minimumPressDuration = 0.5;//设置长按时间，默认0.5秒，一般这个值不要修改
    [self addGestureRecognizer:longPressGesture];

    [self addGestureRecognizer:tapDisMissGesture];
    [self addGestureRecognizer:tapBigGesture];
    [self addGestureRecognizer:pinchGesture];
    [self addGestureRecognizer:tapBigGesture];
}

#pragma mark - GestureRecognizer
- (void)tapAction{
    if (_showsSheetView) {
        [self showSheetView:NO];
    }else{
        [self.imageItemDelegate disMissBrowser];
    }
}

- (void)tapBigGestureAction:(UIPinchGestureRecognizer *)gesture{
    
}

- (void)pinchImage:(UIPinchGestureRecognizer *)gesture{
    //NSLog(@"pinch:%i",gesture.state);
    if (gesture.state==UIGestureRecognizerStateChanged) {
        //捏合手势中scale属性记录的缩放比例
        _imageView.transform=CGAffineTransformMakeScale(gesture.scale, gesture.scale);
    }else if(gesture.state==UIGestureRecognizerStateEnded){//结束后恢复
        [UIView animateWithDuration:.5 animations:^{
            _imageView.transform=CGAffineTransformIdentity;//取消一切形变
        }];
    }
}

- (void)longPressImage:(UIPanGestureRecognizer *)gesture{
    NSLog(@"longPressImage");
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (!_showsSheetView) {
            [self showSheetView:YES];
        }else{
            [self showSheetView:NO];
        }
    }
}

- (void)panImage:(UIPanGestureRecognizer *)gesture{
    if (gesture.state==UIGestureRecognizerStateChanged) {
        CGPoint translation=[gesture translationInView:self];//利用拖动手势的translationInView:方法取得在相对指定视图（这里是控制器根视图）的移动
        _imageView.transform=CGAffineTransformMakeTranslation(translation.x, translation.y);
    }else if(gesture.state==UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 animations:^{
            _imageView.transform=CGAffineTransformIdentity;
        }];
    }
}

#pragma mark - Helper
- (void)showSheetView:(BOOL)show{
    if (show && !_showsSheetView) {
        [UIView animateWithDuration:0.3 animations:^{
            [self addSubview:self.sheetView];
            [self.sheetView setY:kSCREEN_HEIGHT - kSheetViewHeight];
            _showsSheetView = YES;
        } completion:^(BOOL finished) {
        }];
    }else if(!show && _showsSheetView){
        [UIView animateWithDuration:0.3 animations:^{
            [self.sheetView setY:kSCREEN_HEIGHT];
        } completion:^(BOOL finished) {
            [self.sheetView removeFromSuperview];
            _showsSheetView = NO;
        }];
    }
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
        _sheetView = [[ZTimageBrowserSheetView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSheetViewHeight)];
        [_sheetView setBackgroundColor:[UIColor redColor]];
    }
    return _sheetView;
}
@end
