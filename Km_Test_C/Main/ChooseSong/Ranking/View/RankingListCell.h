//
//  RankingListCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingListModel.h"
@interface RankingListCell : UITableViewCell

@property (strong, nonatomic) UILabel *album1;
@property (strong, nonatomic) UILabel *album2;
@property (strong, nonatomic) UILabel *album3;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) RankingListModel *model;

+ (RankingListCell *)cellWidthTable:(UITableView *)table;
+ (CGFloat )heightWidthCell;
@end
