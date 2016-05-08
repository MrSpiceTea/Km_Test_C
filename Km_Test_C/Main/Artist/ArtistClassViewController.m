//
//  ArtistClassViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistClassViewController.h"
#import "ArtistListViewController.h"
#import "ArtistSearchView.h"
#import "ArtistClassCell.h"

@interface ArtistClassViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) ArtistSearchView *artistSearchView;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation ArtistClassViewController

#pragma mark Life Cyle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
}

- (void)configUI{
    self.navigationItem.title = @"歌手";
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

-(void)initData{
    
    NSDictionary *dic1 = @{@"title":@"消息",@"imageName":@"icon_message"};
    NSDictionary *dic2 = @{@"title":@"我的作品",@"imageName":@"icon_record"};
    NSDictionary *dic3 = @{@"title":@"我的订单",@"imageName":@"icon_order"};
    NSDictionary *dic4 = @{@"title":@"我的红包",@"imageName":@"icon_red_envelope"};
    NSDictionary *dic5 = @{@"title":@"KTV会员卡",@"imageName":@"icon_ecard"};
    NSDictionary *dic6 = @{@"title":@"K米点歌机",@"imageName":@"icon_connect_kmbox"};
    
    self.dataSource = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,nil];
}

#pragma mark - UITablewViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 25;
        }else{
            return 90;
        }
    }else{
        return 55;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0||section == 1)
        return CGFLOAT_MIN;
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section!=0) {
        ArtistListViewController *artitListVC = [[ArtistListViewController alloc]init];
        [self.navigationController pushViewController:artitListVC animated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    static NSString *headCellIdentifier = @"headCell";
    static NSString *hotArtitsCellIdentifier = @"hotArtitsCell";
    if (indexPath.section == 0) {
        ArtistClassCell *cell = nil;
        if (indexPath.row == 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:headCellIdentifier];
            if (!cell) {
                cell = [[ArtistClassCell alloc]initWithTitle:@"热门歌手" reuseIdentifier:headCellIdentifier];
                cell.userInteractionEnabled = NO;
            }
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[ArtistClassCell alloc]initWithArtists:nil reuseIdentifier:hotArtitsCellIdentifier];
            }
        }
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = @"华语男歌手";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 3;
    }else{
        return 2;
    }
}

#pragma mark - GET/SET
#pragma mark - GET/SET
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kArtistSearchViewHeight + kNavBar_Height , kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}


static const CGFloat kArtistSearchViewHeight = 40;
- (ArtistSearchView *)artistSearchView{
    if (!_artistSearchView) {
        _artistSearchView = [[ArtistSearchView alloc]initWithFrame:CGRectMake(0, kNavBar_Height, kSCREEN_WIDTH, kArtistSearchViewHeight)];
        _artistSearchView.backgroundColor = RGB(240, 240, 240);
    }
    return _artistSearchView;
}
@end
