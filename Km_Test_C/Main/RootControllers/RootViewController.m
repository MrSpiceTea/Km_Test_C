//
//  RootViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/22.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RootViewController.h"
#import "BaseNavigationController.h"
#import "ChooseSongViewController.h"
#import "MeViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

#pragma mark - Life Clycle
- (instancetype)init{
    if (self = [super init]) {
        [self setupViewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers{
    NSMutableArray *controllers = [NSMutableArray array];
    ChooseSongViewController *chooseSongVC = [[ChooseSongViewController alloc]init];
    MeViewController *meVC = [[MeViewController alloc]init];
    
    
    UINavigationController *navVc = [[BaseNavigationController alloc]initWithRootViewController:chooseSongVC];
    NSString *title =  NSLocalizedString(@"k歌", @"k歌");
    navVc.title = title;
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:nil selectedImage:nil];
    navVc.tabBarItem = tabBarItem;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:meVC];
    title = NSLocalizedString(@"我的", @"我的");
    navVc.title = title;
    tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:nil selectedImage:nil];
    navVc.tabBarItem = tabBarItem;
    [controllers addObject:navVc];
    [self setViewControllers:controllers];
}

@end
