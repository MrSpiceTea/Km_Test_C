//
//  ParallaxTableViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ParallaxTableViewController.h"

@interface ParallaxTableViewController()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *headerInsetTableView;
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
    self.view.backgroundColor = [UIColor brownColor];
}

#pragma mark - UIViewController Methods Overrides
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

#pragma mark - Properties setter & getter
//static const CGFloat kTopBannerHeight = 90.5;
- (ParallaxView *)parallaxView {
    if (!_parallaxView) {
        _parallaxView = [[ParallaxView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        _parallaxView.backgroundView = self.imageView;
        _parallaxView.foregroundView = self.tableView;
    }
    return _parallaxView;
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
    }
    
    return _imageView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}

#pragma mark - Helper Methods
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

@end
