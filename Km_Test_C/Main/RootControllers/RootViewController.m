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
#import "LoginViewController.h"

#import "TopPresentAnimation.h"
#import "UIImage+expanded.h"

@interface RootViewController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) TopPresentAnimation *topPresentAnimation;
@end

@implementation RootViewController

#pragma mark - Life Clycle
- (instancetype)init{
    if (self = [super init]) {
          _topPresentAnimation = [TopPresentAnimation new];
        [self setupViewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImage *image = [UIImage imageNamed:@"ktv_home_shadow"];
//    [self.tabBar setShadowImage:image];
    
//    [self.tabBar setBackgroundImage:image];
//    [self.tabBar setBackgroundColor:RGB(300, 300, 203000)];
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
    tabBarItem.image = [[UIImage imageNamed:@"bottomview_near"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:@"bottomview_near_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    navVc.tabBarItem = tabBarItem;
    navVc.delegate = self;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:chatVC];
    tabBarItem = [UITabBarItem new];
    tabBarItem.image = [[UIImage imageNamed:@"bottomview_chat"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:@"bottomview_chat_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    navVc.tabBarItem = tabBarItem;
    navVc.delegate = self;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:chooseSongVC];
    tabBarItem = [UITabBarItem new];
    tabBarItem.image = [[UIImage imageNamed:@"bottomview_k"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:@"bottomview_k_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVc.tabBarItem = tabBarItem;
    navVc.delegate = self;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:discoverVC];
    tabBarItem = [UITabBarItem new];
    tabBarItem.image = [[UIImage imageNamed:@"bottomview_safari"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:@"bottomview_safari_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    navVc.tabBarItem = tabBarItem;
    navVc.delegate = self;
    [controllers addObject:navVc];
    
    navVc = [[BaseNavigationController alloc]initWithRootViewController:meVC];
    //    title = NSLocalizedString(@"我的", @"我的");
    //    navVc.title = title;
    tabBarItem = [UITabBarItem new];
    tabBarItem.image = [[UIImage imageNamed:@"bottomview_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:@"bottomview_me_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    navVc.tabBarItem = tabBarItem;
    navVc.delegate = self;
    [controllers addObject:navVc];

    [self setViewControllers:controllers];
    self.selectedIndex = 2;
}

- (UIImage *)customTabbarimageNamed:(NSString *)name{
    return  [[UIImage scaleToSize:[UIImage imageNamed:name] size:CGSizeMake(60, 60)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}



- (void)configRightNavBtn:(UINavigationController *)navigationController {
    if (!navigationController.navigationItem.rightBarButtonItem) {
        //???: no add
        [navigationController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"selected_tip"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)] animated:NO];
    }
}

#pragma mark - UINavigationControllerDelegate methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([navigationController.viewControllers[0] isKindOfClass:[ChooseSongViewController class]]) {
        if (navigationController.viewControllers.count >=2) {//todo 判断已点页面不用加按钮，
            [self configRightNavBtn:navigationController];
        }
    }
    
    if ([viewController isKindOfClass:[LoginViewController class]]) {
        
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
//        return self.topPresentAnimation;
    }else if (operation == UINavigationControllerOperationPop){
        
    }
    return nil;
}


#pragma mark - ButtonAction
- (void)rightBarButtonItemAction{
}


@end
