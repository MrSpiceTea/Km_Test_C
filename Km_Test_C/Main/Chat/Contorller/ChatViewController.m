//
//  ChatViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatSessionViewController.h"
#import "ChatFriendListViewController.h"
@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tablewView;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会话";
    UIButton *navButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [navButton setTitle:@"好友" forState:UIControlStateNormal];
    [navButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(navRightButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    self.navigationItem.rightBarButtonItem = item;
    
    BOOL hasDataSource = 0;
    if (hasDataSource) {
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
    }else{
        [self.view addSubview:self.tablewView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ChatSessionViewController *chatSessionVC = [[ChatSessionViewController alloc]init];
        chatSessionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatSessionVC animated:YES];
        chatSessionVC.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark - UITableViewDataSource 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"evchat_kefu_icon"];
    cell.textLabel.text = @"K米克服";
    cell.detailTextLabel.text = @"傻姑娘一次的信息";
    cell.detailTextLabel.textColor = kCommonCellDetailTextLabelColor;
    return cell;
}

#pragma mark - TargatAction
- (void)navRightButton{
    ChatFriendListViewController *chatFriendListVC = [[ChatFriendListViewController alloc]init];
    [self.navigationController pushViewController:chatFriendListVC animated:YES];
}

#pragma mark - Get
- (UITableView *)tablewView{
    if (!_tablewView) {
        _tablewView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tablewView.backgroundColor = kCommonTableViewBavkgroundColor;
        _tablewView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tablewView.dataSource = self;
        _tablewView.delegate = self;
    }
    return _tablewView;
}

@end
