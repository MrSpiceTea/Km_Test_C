//
//  FriendCircleCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleCell.h"

@interface FriendCircleCell()
@property (nonatomic,strong) UIView *lastView;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UIButton *detailLikeikeButton;
@property (nonatomic,strong) UIButton *detailCmtikeButton;



@end

@implementation FriendCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

static const CGFloat FriendCircleCellImageViewHeight = 30.0f;
static const CGFloat FriendCircleCellTopMargin = 15.0f;
- (instancetype)initWithFriendCircleModel:(FriendCircleModel *)friendCircleModel reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor = RGB(246, 246, 246);
        
        UIImageView *headerImageView = [UIImageView new];
        [headerImageView setFrame:CGRectMake(0, 0, FriendCircleCellImageViewHeight, FriendCircleCellImageViewHeight)];
        UIImage *image = [UIImage imageNamed:friendCircleModel.profileImageUrl];
        UIGraphicsBeginImageContextWithOptions(headerImageView.bounds.size, NO, 1.0);
        [[UIBezierPath bezierPathWithRoundedRect:headerImageView.bounds
                                    cornerRadius:10.0] addClip];
        [image drawInRect:headerImageView.bounds];
        headerImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.contentView addSubview:headerImageView];
        
        UILabel *distanceLabel = [UILabel new];
        [distanceLabel setText:friendCircleModel.distan];
        [distanceLabel setFont:[UIFont systemFontOfSize:9]];
        [distanceLabel setTextColor:[UIColor orangeColor]];
        [self.contentView addSubview:distanceLabel];
        
        UILabel *userNameLabel = [UILabel new];
        [userNameLabel setText:friendCircleModel.userName];
        [userNameLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:userNameLabel];
        
        UILabel *dateLabel = [UILabel new];
        [dateLabel setText:friendCircleModel.createdAt];
        [dateLabel setFont:[UIFont systemFontOfSize:10]];
        [dateLabel setTextColor:[UIColor colorWithWhite:0.4 alpha:1]];
        [self.contentView addSubview:dateLabel];
        
        UILabel *locationLabel = [UILabel new];
        [locationLabel setText:friendCircleModel.location];
        [locationLabel setFont:[UIFont systemFontOfSize:9]];
        [locationLabel setTextColor:[UIColor colorWithWhite:0.5 alpha:1]];
        [self.contentView addSubview:locationLabel];
        
        UILabel *detailLabel = [UILabel new];
        [detailLabel setText:friendCircleModel.text];
        [detailLabel setFont:[UIFont systemFontOfSize:13.5]];
        detailLabel.numberOfLines = 0;
        [self.contentView addSubview:detailLabel];
        
        UIButton *detailLikeikeButton = [UIButton new];
        [detailLikeikeButton setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        [detailLikeikeButton.titleLabel setFont:[UIFont systemFontOfSize:9]];
        [detailLikeikeButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
        [detailLikeikeButton setTitle:@"赞" forState:UIControlStateNormal];
        [detailLikeikeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 15)];
        [detailLikeikeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self.contentView addSubview:detailLikeikeButton];
        
        UIButton *detailCmtikeButton = [UIButton new];
        [detailCmtikeButton setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        [detailCmtikeButton.titleLabel setFont:[UIFont systemFontOfSize:9]];
        [detailCmtikeButton setImage:[UIImage imageNamed:@"activity_detail_cmt"] forState:UIControlStateNormal];
        [detailCmtikeButton setTitle:@"评论" forState:UIControlStateNormal];
        [detailCmtikeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 15)];
        [detailCmtikeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self.contentView addSubview:detailCmtikeButton];
        
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(FriendCircleCellTopMargin,FriendCircleCellTopMargin,0,0));
            make.size.mas_equalTo(CGSizeMake(FriendCircleCellImageViewHeight, FriendCircleCellImageViewHeight));
        }];
        [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerImageView);
            make.left.equalTo(headerImageView.mas_right).with.offset(FriendCircleCellTopMargin);
        }];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerImageView);
            make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
        }];
        [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(headerImageView);
            make.left.equalTo(userNameLabel);
        }];
        [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(locationLabel);
            make.left.equalTo(locationLabel.mas_right).with.offset(5);
        }];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(locationLabel.mas_bottom).with.offset(5);
            make.left.equalTo(userNameLabel);
            make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
        }];

        FriendPhotoContainerView * friendPhotoContainerView = [FriendPhotoContainerView new];
        [friendPhotoContainerView setPicUrlStringsArray:friendCircleModel.imagesArray];
        [self.contentView addSubview:friendPhotoContainerView];
        
        [friendPhotoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(detailLabel.mas_bottom).with.offset(5);
            make.left.equalTo(userNameLabel);
        }];

        [detailCmtikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(friendPhotoContainerView.mas_bottom).with.offset(FriendCircleCellTopMargin);
            make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
        }];
        [detailLikeikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(detailCmtikeButton);
            make.right.equalTo(detailCmtikeButton.mas_left).with.offset(-FriendCircleCellTopMargin);
        }];
        
        self.headerImageView = headerImageView;
        self.distanceLabel = distanceLabel;
        self.userNameLabel = userNameLabel;
        self.dateLabel = dateLabel;
        self.locationLabel = locationLabel;
        self.detailLabel = detailLabel;
        self.detailLikeikeButton = detailLikeikeButton;
        self.detailCmtikeButton = detailCmtikeButton;
        self.friendPhotoContainerView = friendPhotoContainerView;

        self.lastView = detailLikeikeButton;
    }
    return self;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView{
    static NSString *identifier = @"FriendCircleCell";
    FriendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[FriendCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor = RGB(246, 246, 246);
        
        UIImageView *headerImageView = [UIImageView new];
        [headerImageView setFrame:CGRectMake(0, 0, FriendCircleCellImageViewHeight, FriendCircleCellImageViewHeight)];
        [self.contentView addSubview:headerImageView];
        
        UILabel *distanceLabel = [UILabel new];
        [distanceLabel setFont:[UIFont systemFontOfSize:9]];
        [distanceLabel setTextColor:[UIColor orangeColor]];
        [self.contentView addSubview:distanceLabel];
        
        UILabel *userNameLabel = [UILabel new];
        [userNameLabel setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:userNameLabel];
        
        UILabel *dateLabel = [UILabel new];
        [dateLabel setFont:[UIFont systemFontOfSize:10]];
        [dateLabel setTextColor:[UIColor colorWithWhite:0.4 alpha:1]];
        [self.contentView addSubview:dateLabel];
        
        UILabel *locationLabel = [UILabel new];
        [locationLabel setFont:[UIFont systemFontOfSize:9]];
        [locationLabel setTextColor:[UIColor colorWithWhite:0.5 alpha:1]];
        [self.contentView addSubview:locationLabel];
        
        UILabel *detailLabel = [UILabel new];
        [detailLabel setFont:[UIFont systemFontOfSize:13.5]];
        detailLabel.numberOfLines = 0;
        [self.contentView addSubview:detailLabel];
        
        UIButton *detailLikeikeButton = [UIButton new];
        [detailLikeikeButton setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        [detailLikeikeButton.titleLabel setFont:[UIFont systemFontOfSize:9]];
        [detailLikeikeButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
        [detailLikeikeButton setTitle:@"赞" forState:UIControlStateNormal];
        [detailLikeikeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 15)];
        [detailLikeikeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self.contentView addSubview:detailLikeikeButton];
        
        UIButton *detailCmtikeButton = [UIButton new];
        [detailCmtikeButton setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        [detailCmtikeButton.titleLabel setFont:[UIFont systemFontOfSize:9]];
        [detailCmtikeButton setImage:[UIImage imageNamed:@"activity_detail_cmt"] forState:UIControlStateNormal];
        [detailCmtikeButton setTitle:@"评论" forState:UIControlStateNormal];
        [detailCmtikeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 15)];
        [detailCmtikeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self.contentView addSubview:detailCmtikeButton];
        
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(FriendCircleCellTopMargin,FriendCircleCellTopMargin,0,0));
            make.size.mas_equalTo(CGSizeMake(FriendCircleCellImageViewHeight, FriendCircleCellImageViewHeight));
        }];
        [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerImageView);
            make.left.equalTo(headerImageView.mas_right).with.offset(FriendCircleCellTopMargin);
        }];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerImageView);
            make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
        }];
        [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(headerImageView);
            make.left.equalTo(userNameLabel);
        }];
        [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(locationLabel);
            make.left.equalTo(locationLabel.mas_right).with.offset(5);
        }];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(locationLabel.mas_bottom).with.offset(5);
            make.left.equalTo(userNameLabel);
            make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
        }];
        
        FriendPhotoContainerView * friendPhotoContainerView = [FriendPhotoContainerView new];
        [self.contentView addSubview:friendPhotoContainerView];
        
        [friendPhotoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(detailLabel.mas_bottom).with.offset(5);
            make.left.equalTo(userNameLabel);
        }];
        
        [detailCmtikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(friendPhotoContainerView.mas_bottom).with.offset(FriendCircleCellTopMargin);
            make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
        }];
        [detailLikeikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(detailCmtikeButton);
            make.right.equalTo(detailCmtikeButton.mas_left).with.offset(-FriendCircleCellTopMargin);
        }];
        
        self.headerImageView = headerImageView;
        self.distanceLabel = distanceLabel;
        self.userNameLabel = userNameLabel;
        self.dateLabel = dateLabel;
        self.locationLabel = locationLabel;
        self.detailLabel = detailLabel;
        self.detailLikeikeButton = detailLikeikeButton;
        self.detailCmtikeButton = detailCmtikeButton;
        self.friendPhotoContainerView = friendPhotoContainerView;
        self.lastView = detailLikeikeButton;
    }
    return self;
}

+ (CGFloat)heightWithModel:(FriendCircleModel *)model {
//    FriendCircleCell *cell = [[FriendCircleCell
//                                alloc] initWithFriendCircleModel:model reuseIdentifier:@"FriendCircleCell"];
//    [cell layoutIfNeeded];
//    CGRect frame =  cell.lastView.frame;
//    return frame.origin.y + frame.size.height + FriendCircleCellTopMargin;
    return 200;
}

- (void)setModel:(FriendCircleModel *)model{
    _model = model;
    self.distanceLabel.text = model.distan;
    self.userNameLabel.text = model.userName;
    self.dateLabel.text = model.createdAt;
    self.locationLabel.text = model.location;
    self.detailLabel.text = model.text;

    self.friendPhotoContainerView.picUrlStringsArray = model.imagesArray;
    
    [self.headerImageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(FriendCircleCellTopMargin,FriendCircleCellTopMargin,0,0));
        make.size.mas_equalTo(CGSizeMake(FriendCircleCellImageViewHeight, FriendCircleCellImageViewHeight));
    }];
    UIImage *image = [UIImage imageNamed:model.profileImageUrl];
    UIGraphicsBeginImageContextWithOptions(self.headerImageView .bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:self.headerImageView .bounds
                                cornerRadius:10.0] addClip];
    [image drawInRect:self.headerImageView.bounds];
    self.headerImageView .image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
