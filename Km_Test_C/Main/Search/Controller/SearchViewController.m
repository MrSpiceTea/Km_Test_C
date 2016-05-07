//
//  SearchViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "SearchViewController.h"

#define kSearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"historyDatas.plist"]

@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *backgroudView;
@property (nonatomic,strong) UITableView *historyTableView;
@property (nonatomic,strong) UITableView *resultTableView;
@property (nonatomic,strong) UITextField *searchTextFiled;
@property (nonatomic,strong) UIView *navSeachView;
@property (nonatomic,strong) NSMutableArray *historyDatas;
@end

@implementation SearchViewController
#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setupUI];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searchTextFiled becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navSeachView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBarSubView];
    UILabel *hintLabel = [UILabel new];
    [hintLabel setText:@"输入搜索内容的首字母即可查询欧"];
    [hintLabel setFont:[UIFont systemFontOfSize:14]];
    [hintLabel setNumberOfLines:0];
    [self.view addSubview:hintLabel];
    
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(150);
        make.width.mas_offset(kSCREEN_WIDTH/2);
    }];
   
    [self.view addSubview:self.historyTableView];
//    [self.view addSubview:self.resultTableView];
    
    
}

- (void)setupBarSubView{
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar addSubview:self.navSeachView];


}
#pragma mark - Action
- (void)cancleButtonTapAction:(UIButton *)btn{
   [self.searchTextFiled resignFirstResponder];
   [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Get/Set
- (UIView *)navSeachView{
    if (!_navSeachView) {
        _navSeachView= [[UIView alloc]initWithFrame:self.navigationController.navigationBar.bounds];
        CGFloat buttonWidth = 50.0f;
        //    UIButton *cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH - 50 -5, 5, buttonWidth, 30)];
        UIButton *cancleButton = [UIButton new];
        [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancleButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [cancleButton addTarget:self action:@selector(cancleButtonTapAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navSeachView addSubview:cancleButton];
        [_navSeachView addSubview:self.searchTextFiled];
        
        [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cancleButton.superview).mas_offset(-5);
            make.centerY.equalTo(_searchTextFiled);
            make.width.mas_offset(buttonWidth);
        }];
        
        [_searchTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_searchTextFiled.superview.mas_left).mas_offset(15);
            make.right.equalTo(cancleButton.mas_left).mas_offset(-5);
            make.bottom.equalTo(_searchTextFiled.superview.mas_bottom).mas_offset(-5);
            make.top.mas_offset(10);
        }];
    }
    return _navSeachView;
}
- (UITextField *)searchTextFiled{
    if (!_searchTextFiled) {
        _searchTextFiled = [UITextField new];
        _searchTextFiled.delegate = self;
        
        UIImageView *leftImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_result_key_icon"]];
        _searchTextFiled.leftView = leftImgView;
        _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
        
        [_searchTextFiled setFont:[UIFont systemFontOfSize:12]];
        [_searchTextFiled setPlaceholder:NSLocalizedString(@"歌星", @"Enter an artist, song or album")];
        [_searchTextFiled setBackgroundColor:RGB(210, 210, 210)];
        [_searchTextFiled setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_searchTextFiled setValue:RGB(240, 240, 240) forKeyPath:@"_placeholderLabel.textColor"];
        [_searchTextFiled setTextColor:[UIColor blackColor]];
        [_searchTextFiled setTintColor:[UIColor blackColor]];
//        [_searchTextFiled.layer setCornerRadius:5];
        
        _searchTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextFiled.returnKeyType = UIReturnKeyGoogle;
        
//        [_searchTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        //        [_textFiled addObserver:self forKeyPath:@"delegate" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _searchTextFiled;
}
//TODO:historyTableViewController resultTableViewController
- (UITableView *)historyTableView{
    if (!_historyTableView) {
        _historyTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _historyTableView.delegate = self;
        _historyTableView.dataSource = self;
    }
    return _historyTableView;
}
- (UITableView *)resultTableView{
    return nil;
}

- (UIView *)backgroudView{
    if (!_backgroudView) {
        UIView *backgroudView = [[UIView alloc]initWithFrame:self.view.bounds];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:backgroudView.bounds];
        imageView.image = [UIImage imageNamed:@"data_empty"];
        imageView.contentMode = UIViewContentModeCenter;
        UILabel *dateLabel = [UILabel new];
        [dateLabel setText:@"页面空空如果也"];
        [dateLabel setFont:[UIFont systemFontOfSize:13]];
        [dateLabel setTextColor:[UIColor colorWithWhite:0.4 alpha:1]];
        [imageView addSubview:dateLabel];
        [backgroudView addSubview:imageView];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view.mas_centerY).with.offset(80);
        }];
        _backgroudView = backgroudView;
    }
    return _backgroudView;
}

- (NSMutableArray *)historyDatas{
    if (!_historyDatas) {
          NSLog(@"kSearchHistoryPath : %@",kSearchHistoryPath);
        _historyDatas = [NSMutableArray arrayWithContentsOfFile:kSearchHistoryPath];
        _historyDatas = [NSMutableArray array];
    }
    return _historyDatas;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"hisorycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    cell.textLabel.text = self.historyDatas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyDatas.count;
}
#pragma mark - UITableViewDelegate

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"ks");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //history
    NSLog(@"%@",textField.text);
    if (textField.text.length) {
        for (NSString *text in self.historyDatas) {
            if ([text isEqualToString:textField.text]) {
                return YES;
            }
        }
      
        [self.historyDatas insertObject:textField.text atIndex:0];
        [self.historyDatas writeToFile:kSearchHistoryPath atomically:YES];
    }
//    [self.searchTextFiled resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    //displayhistory
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string{
    //updataresule
//    NSLog(@"%@",string);
    return YES;
}

@end
