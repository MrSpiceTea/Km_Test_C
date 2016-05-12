//
//  PeopleInformationViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/10.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "PeopleInformationViewController.h"
#import "FriendCircleDetailBottomView.h"
#import "UINavigationBar+expanded.h"
static const CGFloat kBackgroudViewHeigth = 260.0f;
@interface PeopleInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headerView;
@end

@implementation PeopleInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    CGFloat bottomViewHeight = 60.0f;
    FriendCircleDetailBottomView *bottomView = [[FriendCircleDetailBottomView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT- bottomViewHeight , kSCREEN_WIDTH, bottomViewHeight)];
    //    bottomView.backgroundColor = [UIColor blueColor];
    [bottomView.leftButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
    [bottomView.leftButton setTitle:@"聊天" forState:UIControlStateNormal];
    [bottomView.rightButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
    [bottomView.rightButton setTitle:@"添加好友" forState:UIControlStateNormal];
    [self.view addSubview:bottomView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:RGB(240, 240, 240)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar cnReset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];//状态栏
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter/Setter

- (UIView *)headerView{
    UIView *headbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kBackgroudViewHeigth)];
    [headbackView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"user_login_bg"]]];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"CoustomView" owner:nil options:nil]firstObject];
    [view setFrame:headbackView.bounds];
    [view setBackgroundColor:[UIColor clearColor]];
    [headbackView addSubview:view];
    return headbackView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}
#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //TODO: cell model
    static NSString *cellIdentifier1 = @"cell1";
    static NSString *cellIdentifier2 = @"cell2";
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier1];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier2];
        }
    }
    
    if (indexPath.section == 0) {
//        cell.detailTextLabel.text = @"上传靓照让大家认识吧";
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"动态";
            cell.detailTextLabel.text = @"他还没有发布任何动态哦";
        }else{
            cell.textLabel.text = @"作品";
            cell.detailTextLabel.text = @"他还没有任何作品";
        }
        
    }
    cell.detailTextLabel.textColor = kCommonCellDetailTextLabelColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
    
}

@end
