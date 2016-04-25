//
//  ArtistDetailViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "SlideViewController.h"
#import "SegmentedControl.h"
#import "SlideView.h"

@interface SlideViewController ()

@property (nonatomic, weak) SlideView *slideView;
@property (nonatomic, weak) SegmentedControl *segmentedControl;

- (void)slideViewIndexDidChange:(SlideView *)sender;
- (void)segmentedControlSelectedIndexDidChange:(SegmentedControl *)sender;

@end

@implementation SlideViewController

- (void)setSlideDisabled:(BOOL)slideDisabled {
    _slideDisabled = slideDisabled;

    self.slideView.slideDisabled = slideDisabled;
}

- (SlideView *)slideView {
    if (!_slideView) {
        SlideView *slideView = [[SlideView alloc] initWithFrame:self.view.bounds];
        self.view.autoresizesSubviews = YES;
        [slideView addTarget:self action:@selector(slideViewIndexDidChange:) forControlEvents:UIControlEventValueChanged];
        slideView.backgroundColor = GlobalGrayColor;
        [self.view addSubview:slideView];
        _slideView = slideView;
    }
    
    return _slideView;
}

- (SegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        SegmentedControl *segmentedControl = [[SegmentedControl alloc] init];
        [self.view addSubview:segmentedControl];
        [segmentedControl addTarget:self action:@selector(segmentedControlSelectedIndexDidChange:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl = segmentedControl;
        _segmentedControl.layer.shadowColor = [UIColor grayColor].CGColor;
        _segmentedControl.layer.shadowOffset = CGSizeMake(0, 1);
        _segmentedControl.layer.shadowRadius = 0.5;
        _segmentedControl.layer.shadowOpacity = 0.5;
    }
    
    return _segmentedControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

static const CGFloat kAnimationDuration = 0.3;
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIViewAnimationOptions options = (UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut);
    
    CGFloat insetTop = 0;
    
    if (![UIApplication sharedApplication].statusBarHidden) {
        insetTop += CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    }
    
    if (!self.navigationController.navigationBarHidden) {
        insetTop += CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    
    CGFloat insetBottom = 0;
    
    if (self.tabBarController.tabBar.translucent && !self.tabBarController.tabBar.hidden) {
        insetBottom += CGRectGetHeight(self.tabBarController.tabBar.frame);
    }
    
    CGRect segmentedControlFrame = CGRectMake(0, insetTop, CGRectGetWidth(self.view.bounds), kSegmentedControlHeight);
    
    void (^animations)() = ^{
        self.segmentedControl.frame = segmentedControlFrame;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {};
    
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration delay:0 options:options animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
}

- (void)appendViewController:(UIViewController *)viewController withTitle:(NSString *)title animated:(BOOL)animated {
    [self insertViewController:viewController withTitle:title atIndex:self.slideView.numOfSlides animated:animated];
}

- (void)insertViewController:(UIViewController *)viewController withTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated {
    CGFloat insetBottom = 0;
    
    if (self.tabBarController.tabBar.translucent && !self.tabBarController.tabBar.hidden) {
        insetBottom += CGRectGetHeight(self.tabBarController.tabBar.frame);
    }
    
    if ([viewController isKindOfClass:[UICollectionViewController class]]) {
        UICollectionViewController *collectionVC = (UICollectionViewController *)viewController;
        collectionVC.collectionView.contentInset = UIEdgeInsetsMake(0, 0, insetBottom, 0);
    } else if ([viewController isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableVC = (UITableViewController *)viewController;
        tableVC.tableView.contentInset = UIEdgeInsetsMake(0, 0, insetBottom, 0);
    }
    
    [self addChildViewController:viewController];
    [self.slideView insertSlide:viewController.view atIndex:index animated:animated];
    [viewController didMoveToParentViewController:self];
    
    [self.segmentedControl insertSegmentWithTitle:title atIndex:index animated:animated];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    _selectedIndex = selectedIndex;
    
    [self.slideView setSelectedIndex:selectedIndex animated:animated];
}

- (void)slideViewIndexDidChange:(SlideView *)sender {
    [self.segmentedControl setSelectedSegmentIndex:sender.selectedIndex animated:YES];
}

- (void)segmentedControlSelectedIndexDidChange:(SegmentedControl *)sender {
    [self.slideView setSelectedIndex:sender.selectedSegmentIndex animated:YES];
}

@end
