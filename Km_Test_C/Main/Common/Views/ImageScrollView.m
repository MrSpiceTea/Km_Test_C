//
//  ImageScrollView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/27.
//  Copyright © 2016年 OMG. All rights reserved.
//
#define kHeight CGRectGetHeight(self.bounds)
#define kWidth  CGRectGetWidth(self.bounds)
#define kPageControlHeight 40.0f
#import "ImageScrollView.h"
#import <UIImageView+WebCache.h>

@interface ImageScrollView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *centerImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) BOOL isURL;
@end

@implementation ImageScrollView

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame images:(NSMutableArray *)images{
    if (self = [self initWithFrame:frame]) {
        if (images>0) {
            self.images = images;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

- (void)setupUI{
    self.delay = 2;
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self prepareImageView];
    [self initTimer];
}

#pragma mark - Helper
- (void)initTimer{
    if (!_timer) {
        self.timer = [NSTimer timerWithTimeInterval:self.delay target:self selector:@selector(imageScorll) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)imageScorll{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    NSLog(@"%f", newOffset.x);
//    NSLog(@"timer");
}


- (void)removeTimer{
    if ([self.timer isValid] == YES) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)prepareImageView {
    UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kWidth, kHeight)];
    UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth, 0,kWidth, kHeight)];
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * 2, 0,kWidth, kHeight)];
    
    center.userInteractionEnabled = YES;
    [center addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap)]];
    
    [_scrollView addSubview:left];
    [_scrollView addSubview:center];
    [_scrollView addSubview:right];
    
    _leftImageView = left;
    _centerImageView = center;
    _rightImageView = right;
}

- (void)reloadImage{
    CGFloat offset = _scrollView.contentOffset.x;
    NSInteger index = offset / kSCREEN_WIDTH;
    if (index == 0) {
        if ((self.pageControl.currentPage == self.currentIndex)&&self.currentIndex == 0) {
            self.currentIndex = self.images.count - 1;
            self.pageControl.currentPage = self.images.count -1;
        }else{
            self.pageControl.currentPage = (self.pageControl.currentPage - 1)%self.images.count;
            self.currentIndex = (self.currentIndex - 1)%self.images.count;
        }
    }else if (index == 2){
        self.pageControl.currentPage = (self.pageControl.currentPage + 1)%self.images.count;
        self.currentIndex = (self.currentIndex + 1)%self.images.count;
    }
    self.centerImageView.image = [UIImage imageNamed:self.images[self.currentIndex]];
  
    NSUInteger leftIndex = (self.currentIndex - 1)%self.images.count;
    if ((self.pageControl.currentPage == self.currentIndex)&&self.currentIndex == 0) {
        leftIndex = self.images.count -1;
    }
    NSUInteger rightIndex = (self.currentIndex + 1)%self.images.count;
    self.leftImageView.image = [UIImage imageNamed:self.images[leftIndex]];
    self.rightImageView.image = [UIImage imageNamed:self.images[rightIndex]];
    NSLog(@"pageindex:%ld,imageIndex:%lu,leftImageView:%lu,rightImageView:%lu",(long)self.pageControl.currentPage,(unsigned long)_currentIndex,(unsigned long)leftIndex,(unsigned long)rightIndex);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    [self.timer setFireDate:[NSDate distantFuture]];//暂停
//    [self removeTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [self.timer setFireDate:[NSDate date]]; //继续。
//    [self.timer setFireDate:[NSDate distantPast]];//开启
    [self initTimer];
    [self reloadImage];
//    CGFloat offset = scrollView.contentOffset.x;
//    NSInteger index = offset / kSCREEN_WIDTH;
//    self.currentIndex = index;
    _scrollView.contentOffset = CGPointMake(kWidth, 0);
//        NSLog(@"dDecelerating");
}

#pragma mark - Action
- (void)imageViewDidTap {
//    NSLog(@"tap");
}

#pragma mark - Setter
- (void)setImages:(NSMutableArray *)images{
    if (_images != images) {
        _images = images;
    }
    self.pageControl.numberOfPages = images.count;
    [self setupUI];
    
    _isURL = [images.firstObject hasPrefix:@"http://"];
//    if (_isURL) {
//        
//    }else{
//        _centerImageView.image = [UIImage imageNamed:images.firstObject];
//    }
    [self reloadImage];
}

#pragma mark - Getter
- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f,
                                                                       kHeight - kPageControlHeight,
                                                                       kWidth,
                                                                       kPageControlHeight)];
        _pageControl.currentPage = 1;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(kWidth * 3,kHeight),
        _scrollView.contentOffset = CGPointMake(kWidth, 0);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}
@end
