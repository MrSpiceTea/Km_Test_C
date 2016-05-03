//
//  AlbumRecListViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "AlbumRecListViewController.h"
#import "AlbumListCell.h"

@interface AlbumRecListViewController ()

@end

@implementation AlbumRecListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐歌单";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView setTableHeaderView:[self tablewHeadView]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - Helper
- (UIView *)tablewHeadView{
    CGFloat headViewHeight = 200.0f;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, headViewHeight)];
    [imageView setImage:[UIImage imageNamed:@"zhangxueyou"]];
    return imageView;
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    AlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[AlbumListCell alloc]initWithTitle:@"我带的人" reuseIdentifier:cellIdentifier];
    }
    cell.detailLabel.text = @"林宥嘉";
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
}

@end
