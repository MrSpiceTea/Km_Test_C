//
//  ChatFriendAddViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/12.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChatFriendAddViewController.h"
#import "ChatFriendAddAddressViewController.h"

@interface ChatFriendAddViewController ()

@end

@implementation ChatFriendAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加好友";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = kCommonTableViewBavkgroundColor;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
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
       
    }else if (indexPath.row == 1){
        ChatFriendAddAddressViewController * catFriendAddAddressVC = [[ChatFriendAddAddressViewController alloc]init];
        [self.navigationController pushViewController:catFriendAddAddressVC animated:YES];
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
        cell.textLabel.text = @"搜索";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"通讯录好友";
    }else if(indexPath.row == 2){
        cell.textLabel.text = @"可能认识的人";
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.contentView.backgroundColor = RGB(200, 200, 200);
    }else{
        cell.textLabel.text = @"暂无好友";
        
    }
    return cell;
}


@end
