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
@interface BaseNavigationController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) TopPresentAnimation *topPresentAnimation;
@end

@implementation BaseNavigationController
- (instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        _topPresentAnimation = [TopPresentAnimation new];
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


#pragma mark - UIViewControllerTransitioningDelegate methods
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.topPresentAnimation;
}

@end
