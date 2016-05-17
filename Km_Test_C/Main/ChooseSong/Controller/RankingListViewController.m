//
//  RankingListViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RankingListViewController.h"
#import "RankingListHeaderView.h"
#import "RankingListCell.h"
#import "RankingListModel.h"
#import "RankingDetailViewController.h"
#import "KM_NetAPIManager.h"

@interface RankingListViewController ()

@end

@implementation RankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self refreshData];
}

- (void)refreshData{
    KM_NetAPIManager *apiManage = [KM_NetAPIManager defaultManage];
    [apiManage fetchRankingListWithCompletion:^(NSArray *results, NSInteger total, NSError *error) {
        if (results) {
            self.dataSource = [NSMutableArray arrayWithArray:results];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [RankingListCell heightWidthCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RankingDetailViewController *rankingDetailVC = [[RankingDetailViewController alloc]init];
    [self.navigationController pushViewController:rankingDetailVC animated:YES];
}

#pragma mark - TableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RankingListModel *model = self.dataSource[section];
    RankingListHeaderView *rankingListHeaderView = [[RankingListHeaderView alloc]init];
    [rankingListHeaderView setModel:model];
    return rankingListHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankingListCell *cell = [RankingListCell cellWidthTable:tableView];
    RankingListModel * model = self.dataSource[indexPath.section];
    [cell setModel:model];
    return cell;
}
@end
