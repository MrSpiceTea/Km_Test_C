//
//  ChatViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会话";
    UIButton *navButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [navButton setTitle:@"好友" forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    self.navigationItem.rightBarButtonItem = item;
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:kSCREEN_BOUNDS];
    imageView.image = [UIImage imageNamed:@"data_empty"];
    imageView.contentMode = UIViewContentModeCenter;
    
    UILabel *dateLabel = [UILabel new];
    [dateLabel setText:@"这里空空的，好像找人说话"];
    [dateLabel setFont:[UIFont systemFontOfSize:13]];
    [dateLabel setTextColor:[UIColor colorWithWhite:0.4 alpha:1]];
    [imageView addSubview:dateLabel];
    [self.view addSubview:imageView];
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY).with.offset(80);
    }];
    // Do any additional setup after loading the view.
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
