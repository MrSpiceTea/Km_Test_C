//
//  ChooseSongCell.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseSongCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
/**
 *  初始化
 *
 *  @param title           标题
 *  @param reuseIdentifier 标识符
 *
 *  @return self
 */
- (instancetype)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail reuseIdentifier:(NSString *)reuseIdentifier;
/**
 *  初始化
 *
 *  @param gridView        网状布局
 *  @param reuseIdentifier 标识符
 *
 *  @return self
 */
- (instancetype)initWithCustomView:(UIView *)customview reuseIdentifier:(NSString *)reuseIdentifier;



@end
