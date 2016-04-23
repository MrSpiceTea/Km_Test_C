//
//  ChooseSongViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/22.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChooseSongViewController.h"
#import "UINavigationBar+expanded.h"

#define kCellIdentifier_TitleDisclosure @"TitleDisclosureCell"

@interface ChooseSongViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UISearchBar *serachBar;
@end

@implementation ChooseSongViewController

#pragma mark - LifeCycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
//    self.timer = [[NSTimer alloc]initWithFireDate:[NSDate distantPast] interval:kTimerInterval target:self selector:@selector(connnectButtionTimer:) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"k歌";
    self.view.backgroundColor = [UIColor brownColor];


    [self layoutSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init
-(void)layoutSubViews{
    [self.view addSubview:self.tableView];
//    _tableView.contentInset = UIEdgeInsetsMake(-35,  0,  0,  0);
}
#pragma mark - Navigation


#pragma mark - UITablewViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    [button setTitle:@"最新歌曲" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.1]];
    return button;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 50;
    }
    return 50;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"wer";
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UIColor * color = [UIColor colorWithRed:0/255.0 green:13/255.0 blue:42/255.0 alpha:1];
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > 50) {
            CGFloat alpha = MIN(0.9, 0.9 - ((50 + 64 - offsetY) / 64));
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        } else {
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
        }
    }
}
#pragma mark - ActionTarget
#pragma mark - UITextFieldDelegate
#pragma mark - Private Method
#pragma mark - Getter/Setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView registerClass:[ChooseSongViewController class] forCellReuseIdentifier:kCellIdentifier_TitleDisclosure];
//        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
@end
