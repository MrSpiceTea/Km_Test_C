//
//  ArtistClassViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistClassViewController.h"

@interface ArtistClassViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ArtistClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [[UITableView appearance] setSectionIndexBackgroundColor:[UIColor clearColor]];
//    [[UITableView appearance] setSectionIndexTrackingBackgroundColor:[UIColor lightGrayColor]];
//    [[UITableView appearance] setSectionIndexColor:[UIColor darkGrayColor]];
    [self.view addSubview:[self searchView]];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSearchViewHeight, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}
static const CGFloat kSearchViewHeight = 35;
- (UIView *)searchView{
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(10, 10, kSCREEN_WIDTH - 20, kSearchViewHeight)];
    view.backgroundColor = RGB(240, 240, 240);
    view.layer.cornerRadius = 5;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_result_key_icon"]];
    UILabel *label = [UILabel new];
    [label setText:@"歌曲，歌星，简拼"];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setTextColor:RGB(160, 160, 160)];
    
    [view addSubview:imageView];
    [view addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(15, 15));
        make.centerY.equalTo(view);
        make.left.equalTo(view).with.offset(10);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(50, 20));
        make.centerY.equalTo(view);
        make.left.equalTo(imageView.mas_right).with.offset(10);
    }];
    return view;
}

@end
