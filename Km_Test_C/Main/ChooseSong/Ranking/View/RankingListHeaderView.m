//
//  RankingListHeaderView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RankingListHeaderView.h"

@implementation RankingListHeaderView

- (instancetype)init{
    if (self == [super init]) {
        [self setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:titleLabel];

        UILabel *dateLabel = [[UILabel alloc]init];
        [dateLabel setFont:[UIFont systemFontOfSize:10]];
        [dateLabel setTextColor:RGB(150, 150, 150)];
        [self addSubview:dateLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(80, 20));
            make.bottom.equalTo(titleLabel.superview.mas_bottom).with.offset(0);
            make.left.mas_equalTo(10);
        }];
        
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(80, 15));
            make.bottom.equalTo(dateLabel.superview.mas_bottom).with.offset(0);
            make.left.equalTo(titleLabel.mas_right).with.offset(10);
        }];
        
        self.titleLabel = titleLabel;
        self.dateLabel = dateLabel;
    }
    return self;
}

- (void)setModel:(RankingListModel *)model{
    _model = model;
    
    self.titleLabel.text = model.artistName;
    self.dateLabel.text = model.time;
}


@end
