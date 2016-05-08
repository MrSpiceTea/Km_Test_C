//
//  LoginViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/4.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "LoginViewController.h"
#import "UINavigationBar+expanded.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_login_bg"]];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [self configUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configUI{
//    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingBtn setFrame:CGRectMake(20, 0, 50, 50)];
//    [settingBtn setTitle:@"返回" forState:UIControlStateNormal];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
//    self.navigationItem.leftBarButtonItem = item;

    UIImageView *atImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 20)];
    [atImageView setImage:[UIImage imageNamed:@"login_username"]];
    atImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITextField *atTextField = [[UITextField alloc]init];
    atTextField.backgroundColor = [UIColor clearColor];
    [atTextField setLeftView:atImageView];
    atTextField.leftViewMode = UITextFieldViewModeAlways;
    atTextField.layer.borderWidth = 1.0f;
    atTextField.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.6].CGColor;
    atTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"帐号／手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithWhite:0.8 alpha:0.6]}];
    
    UIImageView *pwImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 20)];
    [pwImageView setImage:[UIImage imageNamed:@"login_password"]];
    pwImageView.contentMode = UIViewContentModeScaleAspectFit;
    UITextField *pwTextField = [[UITextField alloc]init];
    [pwTextField setLeftView:pwImageView];
    pwTextField.leftViewMode = UITextFieldViewModeAlways;
    pwTextField.layer.borderWidth = 1.0f;
    pwTextField.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.6].CGColor;
    pwTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithWhite:0.8 alpha:0.6]}];
    pwTextField.secureTextEntry = YES; //密码
    
    [self.view addSubview:atTextField];
    [self.view addSubview:pwTextField];
    
    [atTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@100);
        make.height.equalTo(@50);
    }];
    
    [pwTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(atTextField.mas_bottom).with.offset(20);
        make.height.equalTo(atTextField);
    }];
    
    UIButton *forgetButton = [UIButton new];
    [forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    UIButton *phoneButton = [UIButton new];
    [phoneButton setTitle:@"手机快捷登陆" forState:UIControlStateNormal];
    [phoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    UIButton *loginButton = [UIButton new];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor orangeColor]];
    loginButton.layer.cornerRadius = 5;
    
    [self.view addSubview:forgetButton];
    [self.view addSubview:phoneButton];
    [self.view addSubview:loginButton];
    
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwTextField.mas_bottom).with.offset(5);
        make.left.equalTo(pwTextField);
    }];
    
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwTextField.mas_bottom).with.offset(5);
        make.right.equalTo(pwTextField);
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwTextField.mas_bottom).with.offset(80);
        make.centerX.equalTo(atTextField);
        make.size.equalTo(atTextField);
    }];
}

@end
