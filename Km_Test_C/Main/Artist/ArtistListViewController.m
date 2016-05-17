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
#import "SearchViewController.h"
#import "UIImage+expanded.h"
#import "KM_NetAPIManager.h"
#import <UIImageView+WebCache.h>
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
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setFrame:CGRectMake(20, 0, 50, 50)];
    [settingBtn setImage:[UIImage imageNamed:@"title_setting_icon_n"] forState:UIControlStateNormal];
    //    [ addTarget:self action:@selector(navRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem = item;
    [self.view addSubview:self.artistSearchView];
    [self refreshData];
   
}

- (void)refreshData{
    KM_NetAPIManager *apiManage = [KM_NetAPIManager defaultManage];
    NSString *letterindex = @"热门";
    NSDictionary *dic = @{@"cmdid":@"D324",@"letterindex":letterindex,@"songstertypeid":self.songstertypeid,@"requestnum":@"40",@"startpos":@"1"};
    NSDictionary *Params = @{@"body":[self DataTOjsonString:dic]};
    [apiManage fetchArtistListWithParams:Params completion:^(NSArray *results, NSInteger total, NSError *error) {
        if (results) {
            self.dataSource = [NSMutableArray arrayWithArray:results];
            [self.tableView reloadData];
        }
    }];
}

//test
- (NSString *)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
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
//    if (indexPath.section!=0) {
        ArtistDetailViewController *artitDetailVC = [[ArtistDetailViewController alloc]init];
        [self.navigationController pushViewController:artitDetailVC animated:YES];
//    }
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    ArtistModel *modle = self.dataSource[indexPath.row];
    [cell.imageView sd_setImageWithURL: [KM_APIRequestAgent imageurlWidthPicurlhead:modle.fileID] placeholderImage:[UIImage imageNamed:@"login_username"]];
//    = [UIImage scaleToSize:size:CGSizeMake(50, 50)];
    cell.textLabel.text = modle.name;
    return cell;
}

- (void)artistSearchViewTap:(UIGestureRecognizer *)recongnizer{
    SearchViewController *search = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}


#pragma mark - GET/SET
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kArtistSearchViewHeight + kNavBar_Height , kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(246, 246, 246);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


static const CGFloat kArtistSearchViewHeight = 40;
- (ArtistSearchView *)artistSearchView{
    if (!_artistSearchView) {
        _artistSearchView = [[ArtistSearchView alloc]initWithFrame:CGRectMake(0, kNavBar_Height, kSCREEN_WIDTH, kArtistSearchViewHeight)];
        _artistSearchView.backgroundColor = RGB(240, 240, 240);
        UITapGestureRecognizer *tapRcongnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(artistSearchViewTap:)];
        [_artistSearchView addGestureRecognizer:tapRcongnizer];
    }
    return _artistSearchView;
}


@end
