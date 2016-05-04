//
//  FriendCircleCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleCell.h"

@implementation FriendCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                       detail:(NSString *)imageName
              reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIView *iconView = [UIView new];
        iconView.backgroundColor = RGB(255, 110, 0);
        iconView.layer.cornerRadius = 3;
        [self.contentView addSubview:iconView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setTextColor:RGB(2, 2, 2)];
        [self.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        [detailLabel setText:detail];
        [detailLabel setFont:[UIFont systemFontOfSize:12]];
        [detailLabel setTextColor:RGB(150, 150, 150)];
        [self.contentView addSubview:detailLabel];
        
        UIView *bottomSeparator = [UIView new];
        bottomSeparator.backgroundColor = RGB(235, 235, 235);
        [self.contentView addSubview:bottomSeparator];
        
        UIButton *button = [UIButton new];
        button.titleLabel.text = @"立即参加";
        button.backgroundColor = RGB(225, 127, 80);
        
//        UIImageView *avatarImageView = [UIImageView alloc]initWithImage:[UIImage imageNamed:""];
        
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iconView.superview);
            make.left.equalTo(iconView.superview.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(6, 28));
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iconView.superview);
            make.left.equalTo(iconView.mas_right).with.offset(6);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomSeparator.superview.mas_left).with.offset(0);
            make.bottom.equalTo(bottomSeparator.superview.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH, 1));
        }];
        
        self.titleLabel = titleLabel;
        self.detailLabel = detailLabel;
    }
    return self;
}

- (instancetype)initWithFriendCircleModel:(FriendCircleModel *)friendCircleModel reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIImageView *headerImageView = [UIImageView new];
        UILabel *detailLabel = [UILabel new];
        UILabel *distanceLabel = [UILabel new];
        UILabel *dateLabel = [UILabel new];
        UILabel *locationLabel = [UILabel new];
        [self.contentView addSubview:headerImageView];
        [self.contentView addSubview:detailLabel];
        [self.contentView addSubview:distanceLabel];
        [self.contentView addSubview:dateLabel];
        [self.contentView addSubview:locationLabel];
        
        [headerImageView setImage:[UIImage imageNamed:friendCircleModel.profileImageUrl]];
        
    }
    return self;
}
@end
