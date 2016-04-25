//
//  MeCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_MeCell @"MeCell"

@interface MeCell : UITableViewCell

@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *titleLabel;

@end
