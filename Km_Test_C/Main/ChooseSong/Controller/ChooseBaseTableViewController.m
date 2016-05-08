//
//  ChooseBaseTableViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/8.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChooseBaseTableViewController.h"
#import "RemoteControlViewController.h"
@interface ChooseBaseTableViewController ()
@property (nonatomic,strong) UIButton *hoverButton;
@end

@implementation ChooseBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    remoteControVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:remoteControVC animated:NO];
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

@end
