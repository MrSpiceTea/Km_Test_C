//
//  ParallaxTableViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ParallaxTableViewController.h"
#import "HeaderInsetTableView.h"
#import "UINavigationBar+expanded.h"

@interface ParallaxTableViewController()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) HeaderInsetTableView *headerInsetTableView;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, strong) UIColor *navBGColorBackup;

@property (nonatomic, strong) UIImageView *topBanner;
@property (nonatomic, strong) UIImageView *bottomBanner;
@end
@implementation ParallaxTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}
- (void)loadView {
    self.view = self.parallaxView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    if (self.parallaxView.contentInset.top == 0) {
        CGFloat insetTop = 0;
        
        if (![UIApplication sharedApplication].statusBarHidden) {
            insetTop += CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        }
        
        if (!self.navigationController.navigationBarHidden) {
            insetTop += CGRectGetHeight(self.navigationController.navigationBar.frame);
        }
        
        CGFloat insetBottom = 0;
        
        if (self.tabBarController.tabBar.translucent && !self.tabBarController.tabBar.hidden && !self.hidesBottomBarWhenPushed) {
            insetBottom += CGRectGetHeight(self.tabBarController.tabBar.frame);
        }
        
        self.parallaxView.contentInset = UIEdgeInsetsMake(insetTop, 0, insetBottom, 0);
        
        [self updateTableViewHeaderInsets];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UIColor * color = [UIColor whiteColor];
        CGFloat offsetY = scrollView.contentOffset.y + kNavBar_Height;
        CGFloat chy =  self.backgroundHeight + kNavBar_Height;
        if (offsetY > - chy + kNavBar_Height) {
            CGFloat alpha = MIN(1, 1 - (-offsetY/chy));
            self.navigationController.navigationBar.tintColor = [UIColor blackColor];
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        } else {
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
        }
    }
}

#pragma mark - Properties setter & getter
//static const CGFloat kTopBannerHeight = 90.5;
static const CGFloat kSegmentedControlHeight = 24 + 15;
- (ParallaxView *)parallaxView {
    if (!_parallaxView) {
        _parallaxView = [[ParallaxView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        _parallaxView.backgroundView = self.imageView;
        _parallaxView.foregroundView = self.tableView;
        _parallaxView.foregroundOffsetY = kSegmentedControlHeight;
        _parallaxView.scrollViewDelegate = self;
    }
    return _parallaxView;
}

- (CGFloat)backgroundHeight{
    return self.parallaxView.backgroundHeight;
}

- (void)setBackgroundHeight:(CGFloat)backgroundHeight{
    self.parallaxView.backgroundHeight = backgroundHeight;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        CGFloat width = CGRectGetWidth(self.view.bounds);
        _imageView.frame = CGRectMake(0, 0, width, width);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
         [_imageView setImage:[UIImage imageNamed:@"AlbumDefault"]];
    }
    
    return _imageView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        self.tableView.rowHeight = 60;
    }
    return _tableView;
}

#pragma mark - Helper Methods
- (void)updateTableViewHeaderInsets {
    CGFloat tableViewContentInsetTop = self.tableView.contentInset.top;
    CGFloat parallaxViewContentInsetTop = self.parallaxView.contentInset.top;
    CGFloat foregroundOffsetY = self.parallaxView.foregroundOffsetY;
    
    self.headerInsetTableView.headerViewInsets = UIEdgeInsetsMake(-(tableViewContentInsetTop - parallaxViewContentInsetTop - foregroundOffsetY), 0, 0, 0);
}
- (void)setBackgroundImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)setBackgroundDefaultImage:(UIImage *)image {
    self.defaultImage = image;
    self.imageView.image = image;
}

- (void)setBackgroundDefaultImageBGColor:(UIColor *)color {
    self.imageView.backgroundColor = color;
}

- (void)setBackgroundImageURL:(NSURL *)url{
    
}

- (UIImage *)backgroundImage {
    return self.imageView.image;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

@end
