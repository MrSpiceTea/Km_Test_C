//
//  ParallaxTableViewController.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//
#import "ParallaxView.h"
#import <UIKit/UIKit.h>

@interface ParallaxTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ParallaxView *parallaxView;

@property (nonatomic, assign) NSTimeInterval retryInterval;

- (void)setBackgroundImage:(UIImage *)image;
- (void)setBackgroundDefaultImage:(UIImage *)image;
- (void)setBackgroundDefaultImageBGColor:(UIColor *)color;
- (void)setBackgroundImageURL:(NSURL *)url;

- (UIImage *)backgroundImage;
@end
