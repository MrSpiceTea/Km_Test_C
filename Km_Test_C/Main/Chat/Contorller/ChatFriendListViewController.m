//
//  ChatFriendListViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/12.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChatFriendListViewController.h"
#import "ChatFriendAddViewController.h"
#import "ChatFriendApplyViewController.h"
#import "UIImage+expanded.h"

@interface ChatFriendListViewController ()

@end

@implementation ChatFriendListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hidesTabBar:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hidesTabBar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的好友";
    
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加好友"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(navRightBtnAction)];
    [navRightBtn setTintColor:RGB(255, 140, 0)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = kCommonTableViewBavkgroundColor;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 20;
    }else{
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ChatFriendApplyViewController *chatFriendApplyVC = [[ChatFriendApplyViewController alloc]init];
        [self.navigationController pushViewController:chatFriendApplyVC animated:YES];
    }
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友申请";
        cell.imageView.image = [UIImage imageNamed:@"newly_friends_avatar"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"我的好友（0）";
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.contentView.backgroundColor = RGB(200, 200, 200);
    }else{
        cell.imageView.image = [UIImage imageOfRoundRectWithImage:[UIImage imageNamed:@"zhangxueyou"] size:CGSizeMake(50, 50) radius:50];
        cell.textLabel.text = @"K米克服";
    }
    return cell;
}

- (void)navRightBtnAction{
    ChatFriendAddViewController *chatFriendaddVC = [[ChatFriendAddViewController alloc]init];
    [self.navigationController pushViewController:chatFriendaddVC animated:YES];
}
@end
