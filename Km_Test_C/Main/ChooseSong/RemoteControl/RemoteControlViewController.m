//
//  RemoteControlViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RemoteControlViewController.h"
#import "RemoteControlView.h"

@interface RemoteControlViewController ()<RemoteControlDelegate>

@end

@implementation RemoteControlViewController

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
    [self.navigationController popViewControllerAnimated:NO];
}

@end
