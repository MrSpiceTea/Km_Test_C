//
//  FirendCircleCommentViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/12.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FirendCircleCommentViewController.h"

@interface FirendCircleCommentViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIBarButtonItem *navRightBtn;
@end

@implementation FirendCircleCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _navRightBtn = [[UIBarButtonItem alloc]initWithTitle:@"发送"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(navRightBtnAction:)];
    _navRightBtn.enabled = NO;
    [_navRightBtn setTintColor:RGB(255, 140, 0)];
    self.navigationItem.rightBarButtonItem = _navRightBtn;
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setFrame:CGRectMake(20, 0, 50, 50)];
    [settingBtn setTitle:@"返回" forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    [item setTintColor:RGB(255, 140, 0)];
    self.navigationItem.leftBarButtonItem = item;
    
    [self.view addSubview:self.textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        _navRightBtn.enabled = YES;
    }
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 500)];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        _textView.delegate = self;
    }
    return _textView;
}
#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
    if (self.textView.text.length) {
        [self.delegate textViewtext:self.textView.text];
    }
    [self dismissSelf];
}

- (void)cancelBtnClicked:(id)sender{
    [self dismissSelf];
}

- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
