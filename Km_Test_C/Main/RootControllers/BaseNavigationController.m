//
//  BaseNavigationController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/23.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ChooseSongViewController.h"
#import "TopPresentAnimation.h"
#import "LoginViewController.h"

@interface BaseNavigationController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIButton *hoverButton;
@property (nonatomic,strong) TopPresentAnimation *topPresentAnimation;
@end

@implementation BaseNavigationController
- (instancetype)init{
    if (self = [super init]) {
        _topPresentAnimation = [TopPresentAnimation new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
     self.transitioningDelegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - UIViewControllerTransitioningDelegate methods
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.topPresentAnimation;
}


#pragma mark - ButtonAction
- (void)rightBarButtonItemAction{
}

@end
