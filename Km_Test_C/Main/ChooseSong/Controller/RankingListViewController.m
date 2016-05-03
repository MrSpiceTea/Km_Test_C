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

@interface RankingListViewController ()

@end

@implementation RankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RankingDetailViewController *rankingDetailVC = [[RankingDetailViewController alloc]init];
    [self.navigationController pushViewController:rankingDetailVC animated:YES];
}

#pragma mark - TableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RankingListHeaderView *rankingListHeaderView = [[RankingListHeaderView alloc]init];
    rankingListHeaderView.titleLabel.text = @"网络音乐榜";
    rankingListHeaderView.dateLabel.text = @"3月2日更新";
    return rankingListHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    RankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        RankingListModel *model = [[RankingListModel alloc]init];
        model.title = @"1 十年－陈奕迅";
        model.imageUrl = @"angelababy";
        cell = [[RankingListCell alloc]initWithRankingListModel:model reuseIdentifier:cellIdentifier];
    }
    return cell;
}
@end
