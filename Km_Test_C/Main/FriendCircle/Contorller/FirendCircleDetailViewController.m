//
//  FirendCircleDetailViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FirendCircleDetailViewController.h"
#import "FriendCircleCell.h"
#import "FriendCircleDetailBottomView.h"

@interface FirendCircleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation FirendCircleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if (!self.tabBarController.tabBar.hidden) {
//        [self hideTabBar:self.tabBarController];
//    }
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self showTabBar:self.tabBarController];
//}
#pragma mark Healper
- (void)setupUI{
    self.title  = @"详情";
    [self.navigationController.navigationBar setBarTintColor:RGB(230, 230, 230)];
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc]initWithTitle:@"更多"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(navRightBtnAction:)];
    [navRightBtn setTintColor:RGB(255, 140, 0)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    [self.view addSubview:self.tableView];
    
    CGFloat bottomViewHeight = 60.0f;
    FriendCircleDetailBottomView *bottomView = [[FriendCircleDetailBottomView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT- bottomViewHeight - 39 , kSCREEN_WIDTH, bottomViewHeight)];
//    bottomView.backgroundColor = [UIColor blueColor];
    [bottomView.leftButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
    [bottomView.leftButton setTitle:@"赞" forState:UIControlStateNormal];
    [bottomView.rightButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
    [bottomView.rightButton setTitle:@"评论" forState:UIControlStateNormal];
    [self.view addSubview:bottomView];
}

- (UIView *)bottomView{
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.model.cellHeight;
    }
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCircleCell * cell = nil;
    if (indexPath.section == 0) {
        cell = [FriendCircleCell cellWithTabelView:tableView];
        [cell setModel:self.model];
    }else{
        cell = [[FriendCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headcell"];
        
        if (indexPath.row == 0) {
            cell.textLabel.text = 0;
            cell.imageView.image = [UIImage imageNamed:@"activity_detail_like"];
        }else{
            cell.textLabel.text = @"暂无评论，快来抢沙发吧";
            cell.textLabel.textColor = kCommonCellDetailTextLabelColor;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - Getting/Setting
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


#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
  
}

@end
