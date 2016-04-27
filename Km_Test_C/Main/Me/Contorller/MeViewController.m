//
//  MeViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/23.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "MeViewController.h"
#import "MeCell.h"
#import "MeHeaderCell.h"

#import "UIImage+expanded.h"

@interface MeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人主页";
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setFrame:CGRectMake(20, 0, 50, 50)];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"title_setting_icon_n"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(navRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    [self initData];
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        tableView.backgroundColor = RGB(240, 240, 240);
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[MeCell class] forCellReuseIdentifier:kCellIdentifier_MeCell];
        [tableView registerClass:[MeHeaderCell class] forCellReuseIdentifier:kCellIdentifier_MeHeaderCell];
        
        [self.view addSubview:tableView];
//        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//        }];
        tableView;
    });
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITablewViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&indexPath.row == 0) {
        return 100;
    }else{
        return 55;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    static NSString *cellIdentifier2 = @"cell2";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_MeHeaderCell forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
             return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
                cell.textLabel.text = @"积分 : 0";
            }
             return cell;
        }
    }else{
//        MeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_MeCell forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = self.dataSource[indexPath.section -1][@"title" ];
            [cell.imageView setImage:[UIImage scaleToSize:[UIImage imageNamed:self.dataSource[indexPath.section -1][@"imageName"]] size:CGSizeMake(30, 30)]];
        }
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0||section == 3) {
        return 2;
    }else{
        return 1;
    }
}

#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
    
}
@end
