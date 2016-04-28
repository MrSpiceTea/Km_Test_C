//
//  ArtistListViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistListViewController.h"
#import "ArtistSearchView.h"
#import "ArtistDetailViewController.h"

#import "UIImage+expanded.h"

@interface ArtistListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) ArtistSearchView *artistSearchView;

@end

@implementation ArtistListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}

- (void)configUI{
    self.navigationItem.title = @"热门";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setFrame:CGRectMake(20, 0, 50, 50)];
    [settingBtn setImage:[UIImage imageNamed:@"title_setting_icon_n"] forState:UIControlStateNormal];
    //    [ addTarget:self action:@selector(navRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem = item;
    [self.view addSubview:self.artistSearchView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section!=0) {
        ArtistDetailViewController *artitDetailVC = [[ArtistDetailViewController alloc]init];
        [self.navigationController pushViewController:artitDetailVC animated:YES];
    }
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.imageView.image = [UIImage scaleToSize:[UIImage imageNamed:@"zhangxueyou"] size:CGSizeMake(50, 50)];
    cell.textLabel.text = @"张学友";
    return cell;
}

#pragma mark - GET/SET
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBar_Height + kArtistSearchViewHeight + 20, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}


static const CGFloat kArtistSearchViewHeight = 40;
- (ArtistSearchView *)artistSearchView{
    if (!_artistSearchView) {
        _artistSearchView = [[ArtistSearchView alloc]initWithFrame:CGRectMake(0, kNavBar_Height + 10, kSCREEN_WIDTH, kArtistSearchViewHeight)];
    }
    return _artistSearchView;
}


@end
