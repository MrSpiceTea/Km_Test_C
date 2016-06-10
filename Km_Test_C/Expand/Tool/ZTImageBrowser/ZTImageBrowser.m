//
//  ZTImageBrowser.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ZTImageBrowser.h"
#import "UIImage+expanded.h"

#define kPageControlHeight 40.0f

@interface ZTImageBrowser ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate,
ZTImageBrowserImageItemDelegate>
@property (nonatomic,strong) UIImageView *screenshotImageView;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIImage *screenshot;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign,getter=isFirstShow) BOOL firstShow;
@end

@implementation ZTImageBrowser

static NSString * const reuseIdentifier = @"ZTImageBrowserCell";

- (instancetype)init{
    if (self = [super init]) {
        self.screenshot = [self screenShotWidthView:[UIApplication sharedApplication].keyWindow];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewLayout];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.firstShow = YES;
}

- (void)setUpChildViewLayout{
    [self.view addSubview:self.screenshotImageView];
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    [self.collectionView setContentOffset:CGPointMake(self.currentIndex * (kSCREEN_WIDTH), 0.0f) animated:NO];
}

#pragma mark - Helper
- (UIImage *)screenShotWidthView:(UIView *)aView {
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size,NO,[UIScreen mainScreen].scale);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

//- (void)setCurrentItem {
//    NSArray* cells = [self.collectionView visibleCells];
//    if (cells.count != 0) {
//        ZTImageBrowserCell* cell = [cells objectAtIndex:0];
//        NSLog(@"%lu",(unsigned long)cells.count);
//        if (self.currentImageItem != cell.imageItem) {
//            self.currentImageItem = cell.imageItem;
//            [self cacehImageWithIndex:self.currentIndex];
//        }
//    }
//}
- (ZTImageBrowserImageItem *)currentImageItem{
    ZTImageBrowserCell *cell = (ZTImageBrowserCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    return cell.imageItem;
}

//预加载前后两张图片 TODO
- (void)cacehImageWithIndex:(NSInteger)index{
    
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,kSCREEN_WIDTH,self.view.bounds.size.height)
                                             collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[ZTImageBrowserCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize =  [UIScreen mainScreen].bounds.size;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
    }
    return _flowLayout;
}


- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f,
                                                                       kSCREEN_HEIGHT - kPageControlHeight - 10.0f,
                                                                       kSCREEN_WIDTH,
                                                                       kPageControlHeight)];
        _pageControl.numberOfPages =  self.imageModels.count;
        _pageControl.currentPage = self.currentIndex;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (UIImageView *)screenshotImageView {
    if (!_screenshotImageView) {
        _screenshotImageView = [[UIImageView alloc] initWithFrame:kSCREEN_BOUNDS];
        _screenshotImageView.image = self.screenshot;
    }
    return _screenshotImageView;
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:kSCREEN_BOUNDS];
        [_backgroundView setBackgroundColor:[UIColor blackColor]];

    }
    return _backgroundView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource> <UICollectionViewDelegate>
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageModels.count;
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZTImageBrowserCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ZTImageBrowserModel *model =  self.imageModels[indexPath.row];
    cell.imageItem.firstShow = self.isFirstShow;
    cell.model = model;
    cell.imageItem.imageItemDelegate = self;
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset / kSCREEN_WIDTH;
    self.currentIndex = index;
    self.pageControl.currentPage = self.currentIndex;
}

#pragma mark - ImageItemDelegate
- (void)disMissBrowser{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.currentImageItem.imageView.frame = weakSelf.currentImageItem.imageModel.srcImageViewRect;
        weakSelf.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end
