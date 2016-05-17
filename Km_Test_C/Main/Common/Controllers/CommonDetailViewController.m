//
//  CommonDetailViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/10.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "CommonDetailViewController.h"
#import "UINavigationBar+expanded.h"
@interface CommonDetailViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@end
static const CGFloat kBackgroundImageHeight = 180;
@implementation CommonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //将view的自动添加scroll的内容偏移关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.backgroundHeadView];
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.tableView];
    
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


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark Get/Set
- (UIView *)backgroundHeadView{
    if (!_backgroundHeadView) {
        _backgroundHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kNavBar_Height)];
        [_backgroundHeadView setImage:[UIImage imageNamed:@"singersongpage_topviewmask"]];
    }
    return _backgroundHeadView;
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kBackgroundImageHeight + kNavBar_Height)];
    }
    return _backgroundView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kBackgroundImageHeight+kNavBar_Height);
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_backgroundImageView setImage:[UIImage imageNamed:@"record_cover_def"]];
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
//        _tableView.userInteractionEnabled = NO;
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
        
        CGFloat scaleTopView = 1 - (offsetY + kBackgroundImageHeight)/ 300;
        scaleTopView = scaleTopView > 1 ? scaleTopView : 1;
        CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView);
        CGFloat ty = (scaleTopView - 1) * kBackgroundImageHeight ;
        self.backgroundImageView.transform = CGAffineTransformTranslate(transform, 0, ty*0.5);
        
        //backView toolbarview
        if (-scrollView.contentOffset.y>chy) {
            CGFloat topoffsetY = -scrollView.contentOffset.y - chy;
            CGFloat backViewCenterY = CGRectGetHeight(self.backgroundView.frame)/2;
            CGPoint centerpoint = self.backgroundView.center;
            centerpoint.y = backViewCenterY + topoffsetY;
            self.backgroundView.center = centerpoint;
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}
@end
