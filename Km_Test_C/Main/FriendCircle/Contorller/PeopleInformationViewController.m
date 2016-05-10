//
//  PeopleInformationViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/10.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "PeopleInformationViewController.h"

@interface PeopleInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headerView;
@end

@implementation PeopleInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIScrollViewDelegate Methods
#pragma mark - UITextFieldDelegate Methods
#pragma mark - UITextViewDelegate Methods
#pragma mark - Getter/Setter
//TODO: customheaderView
static const CGFloat headerViewHeight = 180.0f;
-  (UIView *)headerView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, headerViewHeight)];
    UIImageView *backImageView = [[UIImageView alloc]init];
    [headerView addSubview:backImageView];
    
    UIImageView *headImageView = [[UIImageView alloc]init];
    UILabel *nameLabel = [[UILabel alloc]init];
    [nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    
    UILabel *goldLabel = [[UILabel alloc]init];
    [goldLabel setText:@"金币 0  ｜  经验  0"];
    
    UILabel *locationLabel = [[UILabel alloc]init];
    [locationLabel setText:@"广东省 － 广州 50米以内 ｜1分钟前"];
    [locationLabel setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];

    return nil;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}

@end
