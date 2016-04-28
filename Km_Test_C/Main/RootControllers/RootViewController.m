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
#import "ChatViewController.h"
#import "FirendCircleViewController.h"
#import "DiscoverViewController.h"

#import "UIImage+expanded.h"

@interface RootViewController ()<UINavigationControllerDelegate>

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
    UIImage *image = [UIImage imageNamed:@"ktv_home_shadow"];
//    [self.tabBar setBackgroundImage:image];
//    [self.tabBar setBackgroundColor:RGB(300, 300, 203000)];
    [self.tabBar setShadowImage:image];
//     [[UITabBar appearance] setTintColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
//    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
//    img.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
//    img.contentMode = UIViewContentModeScaleToFill;
//    [[self tabBar] insertSubview:img atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers{
    NSMutableArray *controllers = [NSMutableArray array];
    ChooseSongViewController *chooseSongVC = [[ChooseSongViewController alloc]init];
    MeViewController *meVC = [[MeViewController alloc]init];
    ChatViewController *chatVC = [[ChatViewController alloc]init];
    DiscoverViewController *discoverVC = [[DiscoverViewController alloc]init];
    FirendCircleViewController *firendCircleVC = [[FirendCircleViewController alloc]init];
    
    
    UINavigationController *navVc = [[BaseNavigationController alloc]initWithRootViewController:firendCircleVC];
//    NSString *title =  NSLocalizedString(@"k歌", @"k歌");
//    title = @""; //~
//    navVc.title = title;
//    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:nil selectedImage:nil];
    UITabBarItem *tabBarItem = [UITabBarItem new];
    tabBarItem.image = [self customTabbarimageNamed:@"bottom_tab_nearby_bg_n"];
    tabBarItem.selectedImage = [self customTabbarimageNamed:@"bottom_tab_nearby_bg_hl"];
    navVc.tabBarItem = tabBarItem;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:chatVC];
    tabBarItem = [UITabBarItem new];
    tabBarItem.image = [self customTabbarimageNamed:@"bottom_tab_chat_bg_n"];
    tabBarItem.selectedImage = [self customTabbarimageNamed:@"bottom_tab_chat_bg_hl"];
    navVc.tabBarItem = tabBarItem;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:chooseSongVC];
    tabBarItem = [UITabBarItem new];
    tabBarItem.image = [self customTabbarimageNamed:@"bottom_tab_kge_bg_n"];
    tabBarItem.selectedImage = [self customTabbarimageNamed:@"bottom_tab_kge_bg_hl"];
    navVc.tabBarItem = tabBarItem;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:discoverVC];
    tabBarItem = [UITabBarItem new];
    tabBarItem.image = [self customTabbarimageNamed:@"bottom_tab_discover_bg_n"];
    tabBarItem.selectedImage = [self customTabbarimageNamed:@"bottom_tab_discover_bg_hl"];
    navVc.tabBarItem = tabBarItem;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:meVC];
    //    title = NSLocalizedString(@"我的", @"我的");
    //    navVc.title = title;
    tabBarItem = [UITabBarItem new];
    tabBarItem.image = [self customTabbarimageNamed:@"bottom_tab_mykme_bg_n"];
    tabBarItem.selectedImage = [self customTabbarimageNamed:@"bottom_tab_mykme_bg_hl"];
    navVc.tabBarItem = tabBarItem;
    [controllers addObject:navVc];

    [self setViewControllers:controllers];
    self.selectedIndex = 2;
}

- (UIImage *)customTabbarimageNamed:(NSString *)name{
    return  [[UIImage scaleToSize:[UIImage imageNamed:name] size:CGSizeMake(60, 60)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
