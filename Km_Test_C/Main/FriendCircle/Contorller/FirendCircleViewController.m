//
//  FirendCircleViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FirendCircleViewController.h"
#import "FirendCircleIssueViewController.h"
#import "FirendCircleDetailViewController.h"
#import "FriendCircleModel.h"
#import "FriendCircleCell.h"
#import "SegmentedView.h"
#import "MJRefresh.h"

@interface FirendCircleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FirendCircleViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set NavigationBar 背景颜色&title 颜色
//    self.navigationItem.title = @"动态";
    [self.navigationController.navigationBar setBarTintColor:RGB(230, 230, 230)];
    NSArray *titlearray = [NSArray arrayWithObjects:@"动态",@"人", nil];
    SegmentedView *seg = [[SegmentedView alloc]initWithFrame:CGRectMake(0, 20, 120, 40)];
    [seg setTitles:titlearray];
    [self.navigationItem setTitleView:seg];
    
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc]initWithTitle:@"发布"
    style:UIBarButtonItemStyleBordered
    target:self
    action:@selector(navRightBtnAction:)];
    [navRightBtn setTintColor:RGB(255, 140, 0)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    [self.view addSubview:self.tableView];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self initData];
            [self.tableView.mj_header endRefreshing];
        });
    }];
    // 马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
}

- (void)initData{
//    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FriendCircleList" ofType:@"plist"]];
    self.dataSource = nil;
    NSMutableArray *array  = [NSMutableArray arrayWithContentsOfFile:kFriendCircleListPath];
    if (array.count == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"FriendCircleList" ofType:@"plist"];
        NSMutableArray *plistarray = [NSMutableArray arrayWithContentsOfFile:path];
        array = plistarray;
        [array writeToFile:kFriendCircleListPath atomically:YES];
    }
    
    for (NSDictionary *dic in array) {
        FriendCircleModel *model1 = [[FriendCircleModel alloc] init];
        model1.profileImageUrl = dic[@"profileImageUrl"];
        model1.userName = dic[@"userName"];
        model1.location = dic[@"location"];
        model1.text = dic[@"text"];
        model1.distan = dic[@"distan"];
        model1.createdAt = dic[@"createdAt"];
        model1.imagesArray = dic[@"images"];
        [self.dataSource addObject:model1];
    }
//    NSMutableArray *imagesArray1 = [NSMutableArray arrayWithObjects:@"zhangxueyou", @"zhangxueyou", @"angelababy", @"angelababy", @"zhangxueyou", @"zhangxueyou", @"zhangxueyou", @"zhangxueyou", @"zhangxueyou",nil];
//    NSMutableArray *imagesArray2 = [NSMutableArray arrayWithObjects:@"angelababy", @"angelababy", @"angelababy", @"angelababy", @"angelababy",nil];
//
//    FriendCircleModel *model1 = [[FriendCircleModel alloc] init];
//    model1.profileImageUrl = @"angelababy";
//    model1.userName = @"陈奕迅 史蒂夫111111";
//    model1.location = @"阿富汗欢乐ktv";
//    model1.text = @"???";
//    model1.distan = @"6000KM";
//    model1.createdAt = @"6小时前";
//    model1.imagesArray = imagesArray1;
//    [self.dataSource addObject:model1];
//    FriendCircleModel *model2 = [[FriendCircleModel alloc] init];
//    model2.profileImageUrl = @"angelababy";
//    model2.userName = @"asdfasdf  史蒂夫222222";
//    model2.location = @"阿富汗欢";
//    model2.text = @"今天天气很好啊啊都发生的路啊啊都发生的路口附近阿拉山口大家福利卡圣诞节啊啊都发生的路口附近阿拉山口大家福利卡圣诞节口附近阿拉山口大家福利卡圣诞节";
//    model2.distan = @"6000KM";
//    model2.createdAt = @"6小时前";
//    [self.dataSource addObject:model2];
//    
//    FriendCircleModel *model4 = [[FriendCircleModel alloc] init];
//    model4.profileImageUrl = @"zhangxueyou";
//    model4.userName = @"史蒂夫33333333";
//    model4.location = @"欢乐ktv";
//    model4.text = @"model4model4model4model4model4mo333333333";
//    model4.distan = @"6000KM";
//    model4.createdAt = @"6小前";
//    [self.dataSource addObject:model4];
//    
//    FriendCircleModel *model5 = [[FriendCircleModel alloc] init];
//    model5.profileImageUrl = @"jay";
//    model5.userName = @"史蒂夫444444";
//    model5.location = @"欢乐ktv";
//    model5.text = @"555555天";
//
//    model5.imagesArray = imagesArray2;
//    model5.distan = @"6000KM";
//    model5.createdAt = @"6小前";
//    [self.dataSource addObject:model5];
//    [self.dataSource addObject:model5];
//    [self.dataSource addObject:model5];
//    [self.dataSource addObject:model5];
//    [self.dataSource addObject:model5];
//    [self.dataSource addObject:model5];
//    [self.dataSource addObject:model5];
    
    [self.tableView reloadData];
}

- (void)loadNewData{
    
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 250;
    }else{
        FriendCircleModel *model = self.dataSource[indexPath.row - 1];
        return model.cellHeight;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCircleCell * cell = nil;
    if (indexPath.row == 0) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FriendCircleHeaderView" owner:nil options:nil]firstObject];
        return cell;
    }else{
        cell = [FriendCircleCell cellWithTabelView:tableView];
        FriendCircleModel *model = self.dataSource[indexPath.row - 1];
        [cell setModel:model];
    }
    NSLog(@"%ld",indexPath.row - 1);

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FirendCircleDetailViewController *firendCircleDetailVC = [[FirendCircleDetailViewController alloc] init];
    [self.navigationController pushViewController:firendCircleDetailVC animated:YES];
}

#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
    FirendCircleIssueViewController *firendCircleIssueVC = [[FirendCircleIssueViewController alloc]init];
    [self.navigationController pushViewController:firendCircleIssueVC animated:YES];
}

#pragma mark - Getter/Setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}

@end
