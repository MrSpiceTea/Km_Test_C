//
//  FirendCircleViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FirendCircleViewController.h"
#import "FriendCircleModel.h"
#import "FriendCircleCell.h"
#import "MJRefresh.h"

@interface FirendCircleViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FirendCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:RGB(230, 230, 230)];
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc]initWithTitle:@"发布"
    style:UIBarButtonItemStyleBordered
    target:self
    action:@selector(navRightBtnAction:)];
    [navRightBtn setTintColor:RGB(255, 140, 0)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    [self.view addSubview:self.tableView];
    [self initData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        NSLog(@"123");
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        });
    }];
    // 马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
}

- (void)initData{
    FriendCircleModel *model1 = [[FriendCircleModel alloc] init];
    model1.profileImageUrl = @"angelababy";
    model1.userName = @"陈奕迅 史蒂夫";
    model1.location = @"阿富汗欢乐ktv";
    model1.text = @"今天天气很好啊啊都发生的路口附近阿拉山口大家福利卡圣诞节";
    model1.distan = @"6000KM";
    model1.createdAt = @"6小时前";
    NSMutableArray *imagesArray1 = [NSMutableArray arrayWithObjects:@"angelababy", @"angelababy", @"angelababy", @"angelababy", @"angelababy",nil];
    model1.imagesArray = imagesArray1;
    [self.dataSource addObject:model1];
    [self.dataSource addObject:model1];
    FriendCircleModel *model2 = [[FriendCircleModel alloc] init];
    model2.profileImageUrl = @"angelababy";
    model2.userName = @"asdfasdf  史蒂夫";
    model2.location = @"阿富汗欢";
    model2.text = @"今天天气很好啊啊都发生的路啊啊都发生的路口附近阿拉山口大家福利卡圣诞节啊啊都发生的路口附近阿拉山口大家福利卡圣诞节口附近阿拉山口大家福利卡圣诞节";
    model2.distan = @"6000KM";
    model2.createdAt = @"6小时前";
    [self.dataSource addObject:model2];
    
    FriendCircleModel *model4 = [[FriendCircleModel alloc] init];
    model4.profileImageUrl = @"angelababy";
    model4.userName = @"史蒂夫";
    model4.location = @"欢乐ktv";
    model4.text = @"model4model4model4model4model4model4model4天";
    model4.distan = @"6000KM";
    model4.createdAt = @"6小前";
    [self.dataSource addObject:model4];
    
    FriendCircleModel *model5 = [[FriendCircleModel alloc] init];
    model5.profileImageUrl = @"angelababy";
    model5.userName = @"史蒂夫";
    model5.location = @"欢乐ktv";
    model5.text = @"555555天";
    model5.distan = @"6000KM";
    model5.createdAt = @"6小前";
    [self.dataSource addObject:model5];
    
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 250;
    }else{
        FriendCircleModel *model = self.dataSource[indexPath.row - 1];
        return [FriendCircleCell heightWithModel:model];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *friendCircleHeaderdentifier = @"FriendCircleHeaderdentifier";
    static NSString *friendCircledentifier = @"FriendCircledentifier";
    FriendCircleCell * cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:friendCircleHeaderdentifier];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:friendCircledentifier];
        [cell setModel:self.dataSource[indexPath.row-1]];
    }
    
    
    if (cell == nil) {
        if (indexPath.row == 0) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"FriendCircleHeaderView" owner:nil options:nil]firstObject];
        }else{
            cell = [[FriendCircleCell alloc]initWithFriendCircleModel:self.dataSource[indexPath.row-1] reuseIdentifier:friendCircledentifier];
        }
    }
    
    return cell;
}
#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
    
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
