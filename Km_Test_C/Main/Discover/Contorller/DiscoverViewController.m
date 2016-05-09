//
//  DiscoverViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "DiscoverViewController.h"
#import "KM_NetAPIClient.h"
#import "SegmentedView.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[KM_NetAPIClient defaultManage] gettest];
    
    NSArray *titlearray = [NSArray arrayWithObjects:@"第一",@"第二", nil];
    SegmentedView *seg = [[SegmentedView alloc]initWithFrame:CGRectMake(20, 100, 120, 30)];
    [seg setTitles:titlearray];
    seg.backgroundColor = [UIColor brownColor];
    [self.view addSubview:seg];
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


@end
