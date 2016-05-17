//
//  RankingListCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RankingListCell.h"
#import <UIImageView+WebCache.h>
#import "KM_APIRequestAgent.h"
#define kRankingListCellIdentifier  @"RankingListCellIdentifier"

@implementation RankingListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}


+ (RankingListCell *)cellWidthTable:(UITableView *)table{
    RankingListCell *cell = [table dequeueReusableCellWithIdentifier:kRankingListCellIdentifier];
    if (!cell) {
        cell = [[RankingListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRankingListCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        CGFloat labelSize = 11.0f;
        
        UILabel *album1 = [[UILabel alloc] init];
        [album1 setBackgroundColor:[UIColor clearColor]];
        [album1 setFont:[UIFont systemFontOfSize:labelSize]];
        [album1 setTextColor:RGB(2, 2, 2)];
        [cell.contentView addSubview:album1];
        cell.album1 = album1;
        
        UILabel *album2 = [[UILabel alloc] init];
        [album2 setBackgroundColor:[UIColor clearColor]];
        [album2 setFont:[UIFont systemFontOfSize:labelSize]];
        [album2 setTextColor:RGB(2, 2, 2)];
        [cell.contentView addSubview:album2];
        cell.album2 = album2;
        
        UILabel *album3 = [[UILabel alloc] init];
        [album3 setBackgroundColor:[UIColor clearColor]];
        [album3 setFont:[UIFont systemFontOfSize:labelSize]];
        [album3 setTextColor:RGB(2, 2, 2)];
        [cell.contentView addSubview:album3];
        cell.album3 = album3;
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [cell.contentView addSubview:imageView];
        cell.headImageView = imageView;
        
        UIView *bottomSeparator = [UIView new];
        bottomSeparator.backgroundColor = RGB(235, 235, 235);
        [cell.contentView addSubview:bottomSeparator];
        
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
    return cell;
}

- (void)setModel:(RankingListModel *)model{
    _model = model;
    //TODO: if null
    NSArray *albums = [model.songs componentsSeparatedByString:@";"];
    NSArray *artists = [model.singers componentsSeparatedByString:@";"];
    self.album1.text = [NSString stringWithFormat:@"1  %@-%@",albums[0],artists[0]];
    self.album2.text = [NSString stringWithFormat:@"2  %@-%@",albums[1],artists[1]];
    self.album3.text = [NSString stringWithFormat:@"3  %@-%@",albums[2],artists[2]];
    [self.headImageView sd_setImageWithURL:[KM_APIRequestAgent imageurlWidthPicurlhead:model.fileID] placeholderImage:[UIImage imageNamed:@"login_username"]];
}

+ (CGFloat )heightWidthCell{
    return 100;
}

@end
