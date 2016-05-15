//
//  LoginViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/4.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "LoginViewController.h"
#import "UINavigationBar+expanded.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@property (nonatomic,strong) UITextField *atTextField;
@property (nonatomic,strong) UITextField *pwTextField;
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

- (void)configUI{
//    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingBtn setFrame:CGRectMake(20, 0, 50, 50)];
//    [settingBtn setTitle:@"返回" forState:UIControlStateNormal];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
//    self.navigationItem.leftBarButtonItem = item;
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBI = [[UIBarButtonItem alloc]initWithCustomView:registerButton];
    self.navigationItem.rightBarButtonItem = rightBI;
    
    
    
    
    [self.view addSubview:self.atTextField];
    [self.view addSubview:self.pwTextField];
    
    [_atTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(@100);
        make.height.equalTo(@50);
    }];
    
    [_pwTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.top.equalTo(_atTextField.mas_bottom).with.offset(20);
        make.height.equalTo(_atTextField);
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
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:forgetButton];
    [self.view addSubview:phoneButton];
    [self.view addSubview:loginButton];
    
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwTextField.mas_bottom).with.offset(5);
        make.left.equalTo(_pwTextField);
    }];
    
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwTextField.mas_bottom).with.offset(5);
        make.right.equalTo(_pwTextField);
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pwTextField.mas_bottom).with.offset(80);
        make.centerX.equalTo(_atTextField);
        make.size.equalTo(_atTextField);
    }];
}

#pragma mark - TargetAction
- (void)loginButtonAction:(UIButton *)btn{
    NSString *username = self.atTextField.text;
    NSString *password = self.pwTextField.text;
    
    NSLog(@"%@:%@",username,password);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerButtonAction:(UIButton *)btn{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (UITextField *)atTextField{
    if (!_atTextField) {
        UIImageView *atImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 20)];
        [atImageView setImage:[UIImage imageNamed:@"login_username"]];
        atImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _atTextField = [[UITextField alloc]init];
        _atTextField.backgroundColor = [UIColor clearColor];
        [_atTextField setLeftView:atImageView];
        _atTextField.leftViewMode = UITextFieldViewModeAlways;
        _atTextField.layer.borderWidth = 1.0f;
        _atTextField.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.6].CGColor;
        _atTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"帐号／手机号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithWhite:0.8 alpha:0.6]}];
    }
    return _atTextField;
}

- (UITextField *)pwTextField{
    if (!_pwTextField) {
        UIImageView *pwImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 50, 20)];
        [pwImageView setImage:[UIImage imageNamed:@"login_password"]];
        pwImageView.contentMode = UIViewContentModeScaleAspectFit;
        _pwTextField = [[UITextField alloc]init];
        [_pwTextField setLeftView:pwImageView];
        _pwTextField.leftViewMode = UITextFieldViewModeAlways;
        _pwTextField.layer.borderWidth = 1.0f;
        _pwTextField.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.6].CGColor;
        _pwTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithWhite:0.8 alpha:0.6]}];
        _pwTextField.secureTextEntry = YES; //密码
    }
    return _pwTextField;
}


@end
