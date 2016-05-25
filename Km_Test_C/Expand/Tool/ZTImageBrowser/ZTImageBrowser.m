//
//  ZTImageBrowser.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ZTImageBrowser.h"
#import "ZTImageBrowserCell.h"
#import "ZTImageBrowserImageItem.h"

#define kPageControlHeight 40.0f

@interface ZTImageBrowser ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate,
ZTImageBrowserImageItemDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign,getter=isFirstShow) BOOL firstShow;
@end

@implementation ZTImageBrowser

static NSString * const reuseIdentifier = @"ZTImageBrowserCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewLayout];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.firstShow = YES;
}


- (void)setUpChildViewLayout{
//    self.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
    [self.collectionView setContentOffset:CGPointMake(self.currentIndex * (kSCREEN_WIDTH), 0.0f) animated:NO];
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
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
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
