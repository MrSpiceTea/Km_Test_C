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
@end
@implementation ParallaxTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
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

static const CGFloat kTopBannerHeight = 90.5;
- (ParallaxView *)parallaxView {
    if (!_parallaxView) {
        _parallaxView = [[ParallaxView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        
        _parallaxView.backgroundView = self.imageView;
        _parallaxView.foregroundView = self.tableView;

    }
    
    return _parallaxView;
}
@end
