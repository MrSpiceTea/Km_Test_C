//
//  ArtistDetailViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "AlbumListCell.h"
#import "ArtistDetailCell.h"
#import "ArtistModel.h"
#import "UINavigationBar+expanded.h"
#import <UIImageView+WebCache.h>
@interface ArtistDetailViewController ()
@end

@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"张学友";
    [self setupUI];
    [self initData];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:@"http://file.cdn.ktvme.com/jpg/f188888eee31304cca77eeed4c754a7e.jpg"] placeholderImage:[UIImage imageNamed:@"login_username"]];
    
    UIButton *likeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [likeButton setImage:[UIImage imageNamed:@"singer_unfocus"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"singer_focus"] forState:UIControlStateSelected];
    [likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backgroundView addSubview:likeButton];
    
    [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundView.mas_bottom).with.offset(-15);
        make.right.equalTo(self.backgroundView.mas_right).with.offset(-10);
    }];
}

- (void)initData{
    for (int i=0; i<30; i++) {
        AlbumModel *albumModel = [[AlbumModel alloc]init];
        albumModel.serialNumber = [NSString stringWithFormat:@"%d",i];
        albumModel.artistName = @"张学友";
        albumModel.albumName = [NSString stringWithFormat:@"歌曲%d",i];
        [self.dataSource addObject:albumModel];
    }
}

#pragma mark - UITablewViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
<<<<<<< Updated upstream
=======
    
>>>>>>> Stashed changes
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ArtistDetailCell *cell = [[ArtistDetailCell alloc]initWithTitle:@"邓紫棋" Fans:@"65656"];
        return cell;
    }else{
        AlbumListCell *cell = [AlbumListCell cellWithTabelView:tableView];
        cell.albumModel = self.dataSource[indexPath.row -1];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - TargetAction
- (void)likeButtonAction:(UIButton *)button{
    button.selected = !button.selected;
}
@end
