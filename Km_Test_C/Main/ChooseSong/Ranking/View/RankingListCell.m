//
//  RankingListCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RankingListCell.h"

@implementation RankingListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        
    }
    return self;
}

- (instancetype)initWithRankingListModel:(RankingListModel *)rankingListModel reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
        CGFloat labelSize = 10.0f;
        
        UILabel *album1 = [[UILabel alloc] init];
        [album1 setBackgroundColor:[UIColor clearColor]];
        [album1 setText:rankingListModel.title];
        [album1 setFont:[UIFont systemFontOfSize:labelSize]];
        [album1 setTextColor:RGB(2, 2, 2)];
        [self.contentView addSubview:album1];
        
        UILabel *album2 = [[UILabel alloc] init];
        [album2 setBackgroundColor:[UIColor clearColor]];
        [album2 setText:rankingListModel.title];
        [album2 setFont:[UIFont systemFontOfSize:labelSize]];
        [album2 setTextColor:RGB(2, 2, 2)];
        [self.contentView addSubview:album2];
        
        UILabel *album3 = [[UILabel alloc] init];
        [album3 setBackgroundColor:[UIColor clearColor]];
        [album3 setText:rankingListModel.title];
        [album3 setFont:[UIFont systemFontOfSize:labelSize]];
        [album3 setTextColor:RGB(2, 2, 2)];
        [self.contentView addSubview:album3];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImage:[UIImage imageNamed:rankingListModel.imageUrl]];
        [self.contentView addSubview:imageView];
        
        UIView *bottomSeparator = [UIView new];
        bottomSeparator.backgroundColor = RGB(235, 235, 235);
        [self.contentView addSubview:bottomSeparator];
        
        [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomSeparator.superview.mas_left).with.offset(0);
            make.bottom.equalTo(bottomSeparator.superview.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH, 1));
        }];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.left.mas_equalTo(10);
            make.centerY.equalTo(imageView.superview);
        }];
        
        [album2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 25));
            make.left.equalTo(imageView.mas_right).with.offset(15);
            make.centerY.equalTo(imageView.superview);
        }];
        
        [album3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 25));
            make.left.equalTo(imageView.mas_right).with.offset(15);
            make.top.equalTo(album2.mas_bottom).with.offset(2);
        }];
        
        [album1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 25));
            make.left.equalTo(imageView.mas_right).with.offset(15);
            make.bottom.equalTo(album2.mas_top).with.offset(-2);
        }];
    }
    return self;
}
@end
