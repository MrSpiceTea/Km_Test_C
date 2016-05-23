//
//  ChooseSongViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/22.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChooseSongViewController.h"
#import "ChooseAlwaysViewController.h"
#import "RankingListViewController.h"
#import "PhoneSendViewController.h"
#import "ArtistClassViewController.h"
#import "QRCodeViewController.h"
#import "AlbumRecListViewController.h"
#import "SearchViewController.h"

#import "KM_NetAPIManager.h"

#import "ChooseSongCell.h"
#import "ChooseSongHeadView.h"
#import "UINavigationBar+expanded.h"
#import "MJRefresh.h"

@interface ChooseSongViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ChooseSongHeadView *headerView;
@property (nonatomic,strong) UIColor *navColor;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ChooseSongViewController

#pragma mark - LifeCycle
static const CGFloat kTimerInterval = 5.0f;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//状态栏
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar cnSetBackgroundColor:self.navColor];
    self.timer = [[NSTimer alloc]initWithFireDate:[NSDate distantPast] interval:kTimerInterval target:self selector:@selector(connnectButtionTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar cnReset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];//状态栏
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"KTV点歌";
    [self layoutSubViews];
    [self refresh];
}

- (void)refresh{
    KM_NetAPIManager *apiManager = [KM_NetAPIManager defaultManage];
    [apiManager fetchHotSongListWithCompletion:^(NSArray *results, NSInteger total, NSError *error) {
        
    }];
}

#pragma mark - Init
-(void)layoutSubViews{
    [self.view addSubview:self.tableView];
//    _tableView.contentInset = UIEdgeInsetsMake(-35,  0,  0,  0);
}

#pragma mark - Navigation


#pragma mark - UITablewViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [ChooseSongCell heightWithSerachView];
        }
        return [ChooseSongCell heightWithTopGridView];
    }else{
        if (indexPath.row == 0 ||indexPath.row ==7) {
            return [ChooseSongCell heightWithhead];
        }else if (indexPath.row == 8){
            return [ChooseSongCell heightWithGirdView];
        }
        return [ChooseSongCell heightWithCell];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SearchViewController *search = [[SearchViewController alloc]init];
            [self.navigationController pushViewController:search animated:YES];
        }
    }
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseSongCell *cell = nil;
    __weak ChooseSongViewController *weakSelf = self;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [ChooseSongCell cellWithSerachView:tableView];
        }else if (indexPath.row == 1){
            cell = [ChooseSongCell cellWithTopGridView:tableView];
            cell.topGridViewTapBlock = ^(NSUInteger tag){
                if (tag == 101) {
                    ArtistClassViewController *artistClasssVC = [[ArtistClassViewController alloc] init];
                    [weakSelf.navigationController pushViewController:artistClasssVC animated:YES];
                }else if (tag == 102){
                    PhoneSendViewController *phoneSendVC = [[PhoneSendViewController alloc]init];
                    [weakSelf.navigationController pushViewController:phoneSendVC animated:YES];
                }else if (tag == 103){
                    ChooseAlwaysViewController *chooseAlwayVC = [[ChooseAlwaysViewController alloc]init];
                    [weakSelf.navigationController pushViewController:chooseAlwayVC animated:YES];
                }else if (tag == 104){
                    RankingListViewController *rankingListVC = [[RankingListViewController alloc]init];
                    [weakSelf.navigationController pushViewController:rankingListVC animated:YES];
                }
            };
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0 || indexPath.row == 7) {
            cell = [ChooseSongCell cellWithTabelView:tableView];
        }else if (indexPath.row == 8){
            cell = [ChooseSongCell cellWithBottomGirdView:tableView];
            cell.bottomGirdViewBlock = ^(NSUInteger tag){
                AlbumRecListViewController *AlbumRecListVC = [[AlbumRecListViewController alloc]init];
                [weakSelf.navigationController pushViewController:AlbumRecListVC animated:YES];
            };
        }else{
            cell = [ChooseSongCell cellWithHotCell:tableView];
        }
    }
    
    if (indexPath.row == 0 ) {
        cell.titleLabel.text = @"最热新歌";
    } else if (indexPath.row == 7 ) {
        cell.titleLabel.text = @"推荐歌单";
    }else{
        cell.titleLabel.text = @"鲁冰花[我是歌手第四季]";
        cell.detailLabel.text = @"徐佳莹";
    }

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else{
        return 9;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UIColor * color = [UIColor colorWithRed:0/255.0 green:13/255.0 blue:42/255.0 alpha:1];
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > 50) {
            CGFloat alpha = MIN(0.9, 0.9 - ((50 + 64 - offsetY) / 64));
            //~todo runtime
            self.navColor = [color colorWithAlphaComponent:alpha];
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        } else {
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
        }
    }
}

#pragma mark - ActionTarget
- (void)connnectButtionTimer:(NSTimer *)timer{
    [self connnectButtionLoopAnimate];
}

#pragma mark - UITextFieldDelegate
#pragma mark - Private Method
static const CGFloat KAnimateDuration = 0.1;
- (void)connnectButtionLoopAnimate{
    __weak ChooseSongViewController *weakSelf = self;
    [UIView animateWithDuration:KAnimateDuration animations:^{
        weakSelf.headerView.button.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:KAnimateDuration animations:^{
            weakSelf.headerView.button.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
//            [weakSelf connnectButtionLoopAnimate];
            [UIView animateWithDuration:KAnimateDuration animations:^{
                weakSelf.headerView.button.transform = CGAffineTransformMakeScale(0.8, 0.8);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:KAnimateDuration animations:^{
                    weakSelf.headerView.button.transform = CGAffineTransformMakeScale(1, 1);
                }];
            }];
        }];
    }];
}

#pragma mark - Getter/Setter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[ChooseSongHeadView alloc]init];
        __weak ChooseSongViewController *weakSelf = self;
        _headerView.btnActionBlock = ^{
            QRCodeViewController *QRCodeVC = [[QRCodeViewController alloc]init];
            QRCodeVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:QRCodeVC animated:YES];
        };
    }
    return _headerView;
}

@end
