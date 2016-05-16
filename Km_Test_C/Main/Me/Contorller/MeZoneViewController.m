//
//  MeZoneViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/11.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "MeZoneViewController.h"
#import "UINavigationBar+expanded.h"
static const CGFloat kBackgroudViewHeigth = 260.0f;
@interface MeZoneViewController ()
@property (nonatomic,strong) UIImageView *backgroundImageView;
@end

@implementation MeZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:kSCREEN_BOUNDS style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [self headerView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setFrame:CGRectMake(20, 0, 40, 40)];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"personal_info_detail_hl"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(navRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem = item;
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

- (UIView *)headerView{
    UIView *headbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kBackgroudViewHeigth)];
    [headbackView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"user_login_bg"]]];
//     headbackView.backgroundColor = [UIColor orangeColor];
    UIView *view = [[[NSBundle mainBundle]loadNibNamed:@"CoustomView" owner:nil options:nil]firstObject];
    [view setFrame:headbackView.bounds];
    [view setBackgroundColor:[UIColor clearColor]];
    //    [headbackView addSubview:self.backgroundImageView];
    [headbackView addSubview:view];
    return headbackView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kBackgroudViewHeigth)];
        [_backgroundImageView setImage:[UIImage imageNamed:@"user_login_bg"]];
//        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
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
    return 20;
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
        cell.imageView.image = [UIImage imageNamed:@"NotType_Update"];
        cell.detailTextLabel.text = @"上传靓照让大家认识吧";
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"动态";
            cell.detailTextLabel.text = @"你还没有发布任何动态哦";
        }else{
            cell.textLabel.text = @"作品";
            cell.detailTextLabel.text = @"你还没有任何作品";
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
