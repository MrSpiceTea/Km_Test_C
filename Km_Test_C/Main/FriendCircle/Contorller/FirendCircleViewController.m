//
//  FirendCircleViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FirendCircleViewController.h"

@interface FirendCircleViewController ()

@end

@implementation FirendCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:RGB(230, 230, 230)];
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc]initWithTitle:@"发布"
    style:UIBarButtonItemStyleBordered
    target:self
    action:@selector(navRightBtnAction:)];
    [navRightBtn setTintColor:RGB(255, 140, 0)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    
    UIProgressView *myProgress;
    myProgress =[[UIProgressView alloc] initWithFrame:CGRectMake(80.0f, 28.0f, 150.0f, 8.0f)];
    [self.navigationController.navigationBar addSubview: myProgress];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
    
}
@end
