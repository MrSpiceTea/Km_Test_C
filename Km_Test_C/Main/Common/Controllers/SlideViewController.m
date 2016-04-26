//
//  SlideViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "SlideViewController.h"
#import "SegemtedControl.h"
#import "SlideView.h"

@interface SlideViewController ()

@property(nonatomic,strong) SlideView *slideView;
@property(nonatomic,strong) SegemtedControl *segemtedControl;

@end

@implementation SlideViewController


static const CGFloat kSegemtedControlHeight = 40.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat insetTop = 0;
    if (![UIApplication sharedApplication].statusBarHidden) {
        insetTop += CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    }
    if (!self.navigationController.navigationBar.hidden) {
        insetTop += CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    CGFloat originy = insetTop + kSegemtedControlHeight;
    [self.slideView setFrame:CGRectMake(0, originy, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-insetTop)];
}
static const CGFloat kSegmentedControlHeight = 40.0f;

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat insetTop = 0;
    
    if (![UIApplication sharedApplication].statusBarHidden) {
        insetTop += CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    }
    
    if (!self.navigationController.navigationBarHidden) {
        insetTop += CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    
    CGFloat originY = kSegmentedControlHeight + insetTop;
    self.slideView.frame = CGRectMake(0, originY, width, height - originY);
    [self.slideView layoutSubviews];
}

- (void)appendViewController:(UIViewController *)viewController withTitle:(NSString *)title animated:(BOOL)animated{
    [self insertViewController:viewController withTitle:title atIndex:self.slideView.numOfSlides animated:animated];
}

- (void)insertViewController:(UIViewController *)viewController withTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated{
    [self addChildViewController:viewController];
    [self.slideView insertSlide:viewController.view atIndex:index animated:animated];
    [viewController didMoveToParentViewController:self];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GET/SET
- (SegemtedControl *)segemtedControl{
    if (!_segemtedControl) {
        _segemtedControl = [[SegemtedControl alloc]init];
        
    }
    return _segemtedControl;
}

- (SlideView *)slideView{
    if (!_slideView) {
        _slideView = [[SlideView alloc]initWithFrame:self.view.bounds];
        _slideView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_slideView];

    }
    return _slideView;
    
}
@end
