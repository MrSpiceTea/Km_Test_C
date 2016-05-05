//
//  ArtistDetailViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistDetailViewController.h"
#import "ChooseSongCell.h"
#import "UINavigationBar+expanded.h"
@interface ArtistDetailViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

/** 记录scrollView上次偏移的Y距离 */
@property (nonatomic, assign) CGFloat                    scrollY;
/** 记录scrollView上次偏移X的距离 */
@property (nonatomic, assign) CGFloat                    scrollX;
/** 最底部的scrollView，用来掌控所有控件的滚动 */
@property (nonatomic, strong) UIScrollView               *backgroundScrollView;
/** 推荐tableView */
@property (nonatomic, strong) UITableView                *tableView;
@property (nonatomic, strong) UIImageView                *backgroundImageView;
@property (nonatomic, strong) UIView                     *backgroundView;
@property (nonatomic, strong) UIButton *likeButton;

@end
static const CGFloat kBackgroundImageHeight = 180;
@implementation ArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"张学友";
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
//    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    [self setupUI];

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
//    //初始化最底部的scrollView,装tableView用
//    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:self.backgroundScrollView];
//    self.backgroundScrollView.backgroundColor = [UIColor blackColor];
//    self.backgroundScrollView.pagingEnabled = YES;
//    self.backgroundScrollView.bounces = NO;
//    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
//    self.backgroundScrollView.delegate = self;
//    self.backgroundScrollView.contentSize = CGSizeMake(kSCREEN_HEIGHT, 0);
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.tableView];
    
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
        CGFloat insetTop = scrollView.contentInset.top;

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
    static NSString *cellIdentifier = @"cell";
    ChooseSongCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ChooseSongCell alloc]initWithTitle:@"" detail:@"" reuseIdentifier:cellIdentifier];
        cell.titleLabel.text = @"每天爱你多一些";
        cell.detailLabel.text = @"张学友";
    }
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
