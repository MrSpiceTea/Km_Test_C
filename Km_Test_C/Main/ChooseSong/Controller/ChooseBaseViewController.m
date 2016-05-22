//
//  ChooseBaseViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/8.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChooseBaseViewController.h"
#import "RemoteControlViewController.h"
#import "CyclePresentAnimation.h"

@interface ChooseBaseViewController ()<UIViewControllerTransitioningDelegate,RemoteControlViewControllerDelegate>
@property (nonatomic,strong) UIButton *hoverButton;
@end

@implementation ChooseBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[[UIApplication sharedApplication].delegate window] addSubview:self.hoverButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.hoverButton removeFromSuperview];
}


- (void)remoteControl:(UIButton *)btn{
    RemoteControlViewController *remoteControVC = [[RemoteControlViewController alloc]init];
    remoteControVC.transitioningDelegate = self;
    
    [self presentViewController:remoteControVC animated:YES completion:nil];
}

-(UIButton *)hoverButton{
    if (!_hoverButton) {
        _hoverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _hoverButton.frame = CGRectMake(10, kSCREEN_HEIGHT - 104, 42, 42);
        [_hoverButton setBackgroundImage:[UIImage imageNamed:@"btn_remote_control_n"] forState:UIControlStateNormal];
        [_hoverButton addTarget:self action:@selector(remoteControl:) forControlEvents:UIControlEventTouchDown];
    }
    return _hoverButton;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    return self.cyclePresentAnimation;
    return [CyclePresentAnimation transitionWithTransitionType:CyclePresentTransitionTypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [CyclePresentAnimation transitionWithTransitionType:CyclePresentTransitionTypeDismiss];
}

//- (void)dismissViewController:(UIViewController *)viewController{
//    [viewController dismissViewControllerAnimated:YES completion:nil];
//    
//}
@end
