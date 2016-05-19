//
//  FriendCircleCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleCell.h"
#import "NSString+expanded.h"

#define kFriendCircleCell_PadingLeft 30
#define kFriendCircleCell_PadingRight 15
#define kFriendCircleCell_PadingTop  15.0
#define kFriendCircleCell_ContentWidth (kSCREEN_WIDTH - kFriendCircleCell_PadingLeft - kFriendCircleCell_PadingRight)
#define kFriendCircleCell_ImageViewHeight   30.0f
#define kFriendCircleCell_ContentMaxHeight 200.0

@interface FriendCircleCell()
@property (nonatomic,strong) UIView *lastView;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *locationLabel;



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

static const CGFloat FriendCircleCellTopMargin = 15.0f;
+ (instancetype)cellWithTabelView:(UITableView *)tableView{
    static NSString *identifier = @"FriendCircleCell";
    FriendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FriendCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor = kCommonTableViewBavkgroundColor;
        
        UIImageView *headerImageView = [UIImageView new];
        [headerImageView setFrame:CGRectMake(0, 0, kFriendCircleCell_ImageViewHeight, kFriendCircleCell_ImageViewHeight)];
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
        
        FriendPhotoContainerView * friendPhotoContainerView = [FriendPhotoContainerView new];
        [self.contentView addSubview:friendPhotoContainerView];
        
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


- (void)setModel:(FriendCircleModel *)model{
    _model = model;
    self.distanceLabel.text = model.distan;
    self.userNameLabel.text = model.userName;
    self.dateLabel.text = model.createdAt;
    self.locationLabel.text = model.location;
    self.detailLabel.text = model.text;
    
    UIImage *image = [UIImage imageNamed:model.profileImageUrl];
    UIGraphicsBeginImageContextWithOptions(self.headerImageView .bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:self.headerImageView .bounds
                                cornerRadius:10.0] addClip];
    [image drawInRect:self.headerImageView.bounds];
    self.headerImageView .image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.friendPhotoContainerView.picUrlStringsArray = model.imagesArray;
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(FriendCircleCellTopMargin,FriendCircleCellTopMargin,0,0));
        make.size.mas_equalTo(CGSizeMake(kFriendCircleCell_ImageViewHeight, kFriendCircleCell_ImageViewHeight ));
    }];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView);
        make.left.equalTo(self.headerImageView.mas_right).with.offset(FriendCircleCellTopMargin);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerImageView);
        make.left.equalTo(self.userNameLabel);
    }];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.locationLabel);
        make.left.equalTo(self.locationLabel.mas_right).with.offset(5);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.userNameLabel);
        make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
    }];
    [self.friendPhotoContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.userNameLabel);
    }];
    
    [self.detailCmtikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-FriendCircleCellTopMargin);
        make.right.equalTo(self.contentView.mas_right).with.offset(-FriendCircleCellTopMargin);
    }];
    [self.detailLikeikeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailCmtikeButton);
        make.right.equalTo(self.detailCmtikeButton.mas_left).with.offset(-FriendCircleCellTopMargin);
    }];
    
}


+ (CGFloat)heightWithModel:(FriendCircleModel *)model {
    CGFloat cellHeight = 0;
    cellHeight += FriendCircleCellTopMargin;
    cellHeight += 10;
    cellHeight += [self contentHeightWithModel:model];
    cellHeight += [self mediatHeightWithModel:model];
    cellHeight += 50;
    return ceilf(cellHeight);
}

+ (CGFloat)contentHeightWithModel:(FriendCircleModel *)model{
    CGFloat height = 0;
    if (model.userName.length > 0) {
        height += MIN(kFriendCircleCell_ContentMaxHeight, [model.userName getHeightWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(kFriendCircleCell_ContentWidth, CGFLOAT_MAX)]);
        height += 15;
    }
    return height;
}

+ (CGFloat)mediatHeightWithModel:(FriendCircleModel *)model{
    if (model.imagesArray.count>0) {
        FriendPhotoContainerView * friendPhotoContainerView = [FriendPhotoContainerView new];
        return   [friendPhotoContainerView heightWidthImages:model.imagesArray];
    }
    return 0;
}

@end
