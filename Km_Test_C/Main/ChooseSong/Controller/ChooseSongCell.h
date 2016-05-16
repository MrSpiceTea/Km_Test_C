//
//  ChooseSongCell.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TopGridViewTapBlock)(NSUInteger tag);

@interface ChooseSongCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (nonatomic,weak) TopGridViewTapBlock topGridViewTapBlock;

- (instancetype)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail reuseIdentifier:(NSString *)reuseIdentifier;

- (instancetype)initWithCustomView:(UIView *)customview reuseIdentifier:(NSString *)reuseIdentifier;


+ (instancetype)cellWithTabelView:(UITableView *)tableView;
+ (instancetype)cellWithSerachView:(UITableView *)tableView;
+ (instancetype)cellWithHotCell:(UITableView *)tableView;
+ (instancetype)cellWithTopGridView:(UITableView *)tableView;


+ (CGFloat)heightWithSerachView;
+ (CGFloat)heightWithTopGridView;

- (UIView *)serachBarView;
@end
