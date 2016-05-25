//
//  ZTimageBrowserSheetView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ZTimageBrowserSheetView.h"
#import "UIView+Frame.h"
const CGFloat kSheetViewHeight = 160.f;

@interface ZTimageBrowserSheetView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) BOOL showsSheetView;
@end
@implementation ZTimageBrowserSheetView

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:self.tableView];
}

#pragma mark - Helper
- (void)show:(BOOL)isshow{
    __weak typeof(self) weakSelf = self;
    if (isshow && !_showsSheetView) {
        [UIView animateWithDuration:0.3 animations:^{
            UIWindow* window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:weakSelf];
            [weakSelf.tableView setY:kSCREEN_HEIGHT - kSheetViewHeight];
        } completion:^(BOOL finished) {
            _showsSheetView = YES;
        }];
    }else if(!isshow && _showsSheetView){
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf.tableView setY:kSCREEN_HEIGHT];
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            _showsSheetView = NO;
        }];
    }
}

#pragma mark - Getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT, kSCREEN_WIDTH, kSheetViewHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

#pragma mark - TableViewDelegate,DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *cellid = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = @"取消";
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"发送给朋友";
        }else{
            cell.textLabel.text = @"保存图片";
        }
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self show:NO];
    }
}
@end
