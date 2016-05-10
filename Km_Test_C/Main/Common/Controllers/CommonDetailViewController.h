//
//  CommonDetailViewController.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/10.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseBaseViewController.h"
@interface CommonDetailViewController : ChooseBaseViewController

@property (nonatomic, strong) UITableView                *tableView;
@property (nonatomic, strong) UIImageView                *backgroundImageView;
@property (nonatomic, strong) UIView                     *backgroundView;
@property (nonatomic, strong) UIView                     *backgroundToolBarView;
@property (nonatomic, strong) UIButton                   *likeButton;
@property (nonatomic, strong) NSMutableArray             *dataSource;

@end
