//
//  AlbumListCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumModel.h"

@interface AlbumListCell : UITableViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) AlbumModel *albumModel;
- (instancetype)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;
+ (instancetype)cellWithTabelView:(UITableView *)tableView AlbumModel:(AlbumModel *)albumModel;
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@end
