//
//  SlideViewController.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideViewController : UIViewController

@property (nonatomic, assign) NSUInteger selectedIndex;

- (void)appendViewController:(UIViewController *)viewController withTitle:(NSString *)title animated:(BOOL)animated;
- (void)insertViewController:(UIViewController *)viewController withTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

@end
