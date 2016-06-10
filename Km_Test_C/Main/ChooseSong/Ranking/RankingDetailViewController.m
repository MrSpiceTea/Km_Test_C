//
//  RankingDetailViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/27.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RankingDetailViewController.h"
#import "ArtistDetailCell.h"
#import "AlbumListCell.h"
#import "ArtistModel.h"
@interface RankingDetailViewController ()<AlbumListCellMentViewDelegate>
@property (nonatomic,strong) AlbumListCell *openCell;
@property (strong, nonatomic) NSIndexPath *openedMenuCellIndex;

@end

@implementation RankingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网络音乐榜";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData{
    for (int i=0; i<30; i++) {
        AlbumModel *albumModel = [[AlbumModel alloc]init];
        albumModel.serialNumber = [NSString stringWithFormat:@"%d",i];
        albumModel.artistName = @"张学友";
        albumModel.albumName = [NSString stringWithFormat:@"歌曲%d",i];
        [self.dataSource addObject:albumModel];
    }
    [self.tableView reloadData];
}

#pragma mark - UITablewViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.openCell.isOpenMenu&&self.openedMenuCellIndex == indexPath) {
        return 55 + 60;
    }
    return 55;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ArtistDetailCell *cell = [[ArtistDetailCell alloc]initWithTitle:@"邓紫棋" Fans:@"65656"];
        return cell;
    }else{
        AlbumListCell *cell = [AlbumListCell cellWithTabelView:tableView];
        cell.indexPath = indexPath;
        cell.delegate = self;
        cell.albumModel = self.dataSource[indexPath.row -1];
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row!=0) {
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
}

#pragma mark - AlbumListCellMentViewDelegate
- (void)albumListCell:(AlbumListCell *)albumListCell didSeletedMentItemAtIndex:(NSInteger)menuItemIndex{
    NSLog(@"%ld,%ld",(long)albumListCell.indexPath.row,(long)menuItemIndex);
}


@end
