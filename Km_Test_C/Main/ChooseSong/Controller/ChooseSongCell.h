//
//  ChooseSongCell.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TopGridViewTapBlock)(NSUInteger tag);
typedef void(^BottomGirdViewBlock)(NSUInteger tag);
@interface ChooseSongCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (nonatomic,copy) TopGridViewTapBlock topGridViewTapBlock;
//@property (nonatomic,copy) BottomGirdViewBlock bottomGirdViewBlock;
- (instancetype)initWithCustomView:(UIView *)customView tableView:(UITableView *)tableView;

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
+ (instancetype)cellWithSerachView:(UITableView *)tableView;
+ (instancetype)cellWithHotCell:(UITableView *)tableView;
+ (instancetype)cellWithTopGridView:(UITableView *)tableView;
+ (instancetype)cellWithBottomGirdView:(UITableView *)tableView;

+ (CGFloat)heightWithSerachView;
+ (CGFloat)heightWithTopGridView;
+ (CGFloat)heightWithGirdView;
+ (CGFloat)heightWithCell;
+ (CGFloat)heightWithhead;
@end
