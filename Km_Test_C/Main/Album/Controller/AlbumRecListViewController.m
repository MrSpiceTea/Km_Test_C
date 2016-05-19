//
//  AlbumRecListViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "AlbumRecListViewController.h"
#import "AlbumListCell.h"

@interface AlbumRecListViewController ()<AlbumListCellMentViewDelegate>
@property (nonatomic,strong) AlbumListCell *openCell;
@property (strong, nonatomic) NSIndexPath *openedMenuCellIndex;
@end

@implementation AlbumRecListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐歌单";
//    [self configRightNavBtn];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView setTableHeaderView:[self tablewHeadView]];
}

- (void)configRightNavBtn{
    if (!self.navigationItem.rightBarButtonItem) {
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"selected_tip"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)] animated:NO];
    }
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
    if (self.openCell.isOpenMenu&&self.openedMenuCellIndex == indexPath) {
        return 120;
    }
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AlbumListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.openCell.isOpenMenu&&self.openedMenuCellIndex == indexPath) {
        self.openedMenuCellIndex = nil;
        self.openCell = nil;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    self.openedMenuCellIndex = indexPath;
    self.openCell = cell;
    self.openCell.isOpenMenu = YES;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumListCell *cell = [AlbumListCell cellWithTabelView:tableView];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.titleLabel.text = @"我爱恶人";
    cell.detailLabel.text = @"林宥嘉";
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
}

#pragma mark - AlbumListCellMentViewDelegate
- (void)albumListCell:(AlbumListCell *)albumListCell didSeletedMentItemAtIndex:(NSInteger)menuItemIndex{
    NSLog(@"%ld,%ld",(long)albumListCell.indexPath.row,(long)menuItemIndex);
}

#pragma mark - ButtonAction
- (void)rightBarButtonItemAction{
}

@end
