//
//  RemoteControlViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RemoteControlViewController.h"
#import "RemoteControlView.h"
#import "CyclePresentAnimation.h"
@interface RemoteControlViewController ()<RemoteControlDelegate,UIViewControllerTransitioningDelegate>

@end

@implementation RemoteControlViewController

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.transitioningDelegate = self;
//        self.modalPresentationStyle = UIModalPresentationCustom;
//    }
//    return self;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    RemoteControlView *remoteView = [[RemoteControlView alloc]init];
    remoteView.delegate = self;
    [self.view addSubview:remoteView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)RemoteControlButtonAction:(UIButton *)button{
//    [self.navigationController popViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.delegate dismissViewController:self];
}


//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    //    return self.cyclePresentAnimation;
//    return [CyclePresentAnimation transitionWithTransitionType:CyclePresentTransitionTypePresent];
//}
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    return [CyclePresentAnimation transitionWithTransitionType:CyclePresentTransitionTypeDismiss];
//}



@end
