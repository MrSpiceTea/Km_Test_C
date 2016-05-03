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

- (instancetype)initWithRankingListModel:(RankingListModel *)rankingListCell reuseIdentifier:(NSString *)reuseIdentifier;
@end
