//
//  ArtistDetailViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "AlbumListCell.h"
#import "ArtistDetailCell.h"
#import "ArtistModel.h"
#import "UINavigationBar+expanded.h"
@interface ArtistDetailViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView                *tableView;
@property (nonatomic, strong) UIImageView                *backgroundImageView;
@property (nonatomic, strong) UIView                     *backgroundView;
@property (nonatomic, strong) UIView                     *backgroundToolBarView;
@property (nonatomic, strong) UIButton                   *likeButton;
@property (nonatomic, strong) NSMutableArray             *dataSource;

@end
static const CGFloat kBackgroundImageHeight = 180;
@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"张学友";
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
//
    [self setupUI];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:RGB(240, 240, 240)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil]];
    [self.navigationController.navigationBar cnReset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];//状态栏
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
 
    //将view的自动添加scroll的内容偏移关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.tableView];
    [self initData];
    
}
- (void)initData{
//    ArtistModel *model = [[ArtistModel alloc]init];
//    model.artistName = @"张学友";
//    model.fansNum = @"53611";

 
    for (int i=0; i<30; i++) {
        AlbumModel *albumModel = [[AlbumModel alloc]init];
        albumModel.serialNumber = [NSString stringWithFormat:@"%d",i];
        albumModel.artistName = @"张学友";
        albumModel.albumName = [NSString stringWithFormat:@"歌曲%d",i];
        [self.dataSource addObject:albumModel];
    }
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UIButton *)likeButton{
    if (_likeButton) {
        _likeButton = [UIButton new];
    }
    return _likeButton;
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        
    }
    return _backgroundView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.frame = CGRectMake(0, kNavBar_Height, kSCREEN_WIDTH, kBackgroundImageHeight);
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_backgroundImageView setImage:[UIImage imageNamed:@"jay"]];
    }
    
    return _backgroundImageView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:kSCREEN_BOUNDS];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(kBackgroundImageHeight + kNavBar_Height, 0, 0, 0);
        _tableView.rowHeight = 60;
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        UIColor * color = [UIColor whiteColor];
        CGFloat offsetY = scrollView.contentOffset.y + kNavBar_Height;
        CGFloat chy =  kBackgroundImageHeight + kNavBar_Height;
        if (offsetY > - chy + kNavBar_Height) {
            CGFloat alpha = MIN(1, 1 - (-offsetY/chy));
            self.navigationController.navigationBar.tintColor = [UIColor blackColor];
            [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, nil]];
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:alpha]];
        } else {
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
            [self.navigationController.navigationBar cnSetBackgroundColor:[color colorWithAlphaComponent:0]];
        }
//        CGFloat insetTop = scrollView.contentInset.top;

        CGFloat scaleTopView = 1 - (offsetY + kBackgroundImageHeight)/ 300;
//        CGRect frame = self.backgroundImageView.frame;
//        frame.origin.y = kBackgroundImageHeight/2;
//        self.backgroundImageView.frame = frame;
        scaleTopView = scaleTopView > 1 ? scaleTopView : 1;
        CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView);
        CGFloat ty = (scaleTopView - 1) * kBackgroundImageHeight ;
        self.backgroundImageView.transform = CGAffineTransformTranslate(transform, 0, ty*0.5);
    }
}

#pragma mark - UITablewViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ArtistDetailCell *cell = [[ArtistDetailCell alloc]initWithTitle:@"邓紫棋" Fans:@"65656"];
        return cell;
    }else{
        AlbumListCell *cell = [AlbumListCell cellWithTabelView:tableView];
        cell.albumModel = self.dataSource[indexPath.row -1];
        return cell;
    }
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

@end
