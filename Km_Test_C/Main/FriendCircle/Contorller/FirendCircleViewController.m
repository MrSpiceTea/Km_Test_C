//
//  FirendCircleViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FirendCircleViewController.h"
#import "FirendCircleDetailViewController.h"
#import "BaseNavigationController.h"
#import "PeopleInformationViewController.h"
#import "FriendCircleModel.h"
#import "FriendCircleCommentModel.h"
#import "FriendCircleCell.h"
#import "PeoPleListCell.h"

#import "ZTImageBrowser.h"
#import "SegmentedView.h" 
#import "UserModel.h"
#import "MJRefresh.h"


@interface FirendCircleViewController ()<UITableViewDataSource,UITableViewDelegate,FirendCircleIssueDelegate,FriendPhotoContainerViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *peopleTablewView;
@property (nonatomic,strong) UIScrollView *scrollView;;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation FirendCircleViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self initData];
            [self.tableView.mj_header endRefreshing];
        });
    }];
    self.peopleTablewView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         
        });
    }];
    // 马上进入刷新状态
    //    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupUI{
    [self.navigationController.navigationBar setBarTintColor:RGB(230, 230, 230)];
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc]initWithTitle:@"发布"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(navRightBtnAction:)];
    [navRightBtn setTintColor:RGB(255, 140, 0)];
    self.navigationItem.rightBarButtonItem = navRightBtn;
    
    //    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.peopleTablewView];
    self.peopleTablewView.hidden = YES;
    
    __weak FirendCircleViewController *weakSelf = self;
    NSArray *titlearray = [NSArray arrayWithObjects:@"动态",@"人", nil];
    SegmentedView *seg = [[SegmentedView alloc]initWithFrame:CGRectMake(0, 20, 120, 40)];
    [seg setTitles:titlearray];
    seg.selectbolck = ^(NSUInteger selectindex){
        weakSelf.tableView.hidden = selectindex;
        weakSelf.peopleTablewView.hidden = !selectindex;
    };
    [self.navigationItem setTitleView:seg];
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
    
    NSMutableArray *mediaModels = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        MediaModel *media = [MediaModel new];
        media.HDURL = [NSURL URLWithString:@"http://a.hiphotos.baidu.com/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=64dc8a4d1bd8bc3ed2050e98e3e2cd7b/8ad4b31c8701a18b8f8b2d389c2f07082838fe60.jpg"];
        media.thumbnailImageURL = [NSURL URLWithString:@"http://ww1.sinaimg.cn/crop.0.0.1242.1242.1024/006boC82jw8eulzgtza8uj30yi0yi0tn.jpg"];
        [mediaModels addObject:media];
    }
    
    for (int i=0; i<6; i++) {
        MediaModel *media = [MediaModel new];
        media.HDURL = [NSURL URLWithString:@"http://imgsrc.baidu.com/forum/w%3D580/sign=53952d5bc91b9d168ac79a69c3dfb4eb/d7da7b899e510fb32a77c813de33c895d0430cda.jpg"];
        media.thumbnailImageURL = [NSURL URLWithString:@"http://ww1.sinaimg.cn/crop.0.0.1242.1242.1024/006boC82jw8eulzgtza8uj30yi0yi0tn.jpg"];
        [mediaModels addObject:media];
    }

    UserModel *user = [[UserModel alloc]init];
    user.profileImageUrl = @"http://ww1.sinaimg.cn/crop.0.0.1242.1242.1024/006boC82jw8eulzgtza8uj30yi0yi0tn.jpg";
    for (NSDictionary *dic in array) {
        FriendCircleModel *model1 = [[FriendCircleModel alloc] init];
        model1.profileImageUrl = dic[@"profileImageUrl"];
        model1.userName = dic[@"userName"];
        model1.location = dic[@"location"];
        model1.text = dic[@"text"];
        model1.distan = dic[@"distan"];
        model1.createdAt = dic[@"createdAt"];
//        model1.imagesArray = dic[@"images"];
        [model1.likeArray addObject:user];
        model1.mediaArray = mediaModels;
//        model1.commentArray = commentModelArray;

        [self.dataSource addObject:model1];
    }

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
    if (tableView == self.tableView) {
        if (indexPath.row == 0) {
            return 250;
        }else{
            FriendCircleModel *model = self.dataSource[indexPath.row - 1];
            return model.cellHeight;
        }
    }else if (tableView == self.peopleTablewView){
        return 80;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableView]) {
          return self.dataSource.count+1;
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView]) {
        FriendCircleCell * cell = nil;
        if (indexPath.row == 0) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"FriendCircleHeaderView" owner:nil options:nil]firstObject];
            return cell;
        }else{
            cell = [FriendCircleCell cellWithTabelView:tableView];
            FriendCircleModel *model = self.dataSource[indexPath.row - 1];
            [cell setModel:model];
            cell.friendPhotoContainerView.delegate = self;
            __weak FirendCircleViewController *selfWeak = self;
            cell.mediaClickedBlock = ^(FriendCircleModel *model,NSMutableArray *imageViews,NSUInteger index){
                NSMutableArray *photoArray = [[NSMutableArray alloc] init];
                for (int i = 0;i< model.mediaArray.count; i ++) {
                    ZTImageBrowserModel *imageModel = [[ZTImageBrowserModel alloc]init];
                    MediaModel *mediaModel = model.mediaArray[i];
                    imageModel.HDURL = mediaModel.HDURL;
                    imageModel.srcImageView = imageViews[i];
                    [photoArray addObject:imageModel];
                }
                ZTImageBrowser *imageBrowser = [[ZTImageBrowser alloc]init];
                imageBrowser.currentIndex = index;
                [imageBrowser setImageModels:photoArray];
                [selfWeak presentViewController:imageBrowser animated:NO completion:^{}];
            };
        }
        return cell;
    }else if([tableView isEqual:self.peopleTablewView]){
        //TODO: peoplemodel
        PeoPleListCell *peoplecell = [PeoPleListCell cellWidthTable:tableView];
        peoplecell.nameLabel.text = @"张学友";
        peoplecell.timeLabel.text = @"1小时前";
        peoplecell.distanLabel.text = @"10km";
        peoplecell.locationLabel.text = @"堂会";
        peoplecell.levelLabel.text = @"21";
        return peoplecell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:self.tableView]) {
        if (indexPath.row!=0 ) {
            FirendCircleDetailViewController *firendCircleDetailVC = [[FirendCircleDetailViewController alloc] init];
            firendCircleDetailVC.model = self.dataSource[indexPath.row - 1];
            firendCircleDetailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:firendCircleDetailVC animated:YES];
            firendCircleDetailVC.hidesBottomBarWhenPushed = NO;
        }
    }else if([tableView isEqual:self.peopleTablewView]){
        PeopleInformationViewController *peopleInformationVC = [[PeopleInformationViewController alloc]init];
        peopleInformationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:peopleInformationVC animated:YES];
        peopleInformationVC.hidesBottomBarWhenPushed = NO;
    }
}
#pragma mark - FriendPhotoContainerViewDelegate
- (void)imageTapAtIndex:(NSUInteger)index{
    
}

#pragma mark - FirendCircleIssueDelegate
- (void)sendIssue:(NSString *)contentText{
    if (contentText.length>0) {
        [self initData];
    }
}

#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
    FirendCircleIssueViewController *firendCircleIssueVC = [[FirendCircleIssueViewController alloc]init];
    BaseNavigationController *firendCircleIssueVCnav = [[BaseNavigationController alloc]initWithRootViewController:firendCircleIssueVC];
    firendCircleIssueVC.delegate = self;
    [self presentViewController:firendCircleIssueVCnav animated:YES completion:nil];
}

#pragma mark - Getter/Setter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        [_scrollView setContentSize:CGSizeMake(kSCREEN_WIDTH*2, kSCREEN_HEIGHT)];
        [_scrollView setAlwaysBounceHorizontal:YES];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView addSubview:self.tableView];
        [_scrollView addSubview:self.peopleTablewView];
    }
    return _scrollView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTabBar_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.tableHeaderView = self.headerView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = RGB(246, 246, 246);
    }
    return _tableView;
}

- (UITableView *)peopleTablewView{
    if (!_peopleTablewView) {
        //???: why y is kNavBar_Height
        _peopleTablewView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBar_Height, kSCREEN_WIDTH, kSCREEN_HEIGHT - kNavBar_Height - 44) style:UITableViewStylePlain];
        _peopleTablewView.delegate = self;
        _peopleTablewView.dataSource = self;
        _peopleTablewView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _peopleTablewView.rowHeight = 80.0f;
        _peopleTablewView.backgroundColor = RGB(246, 246, 246);
    }
    return _peopleTablewView;
}

@end
