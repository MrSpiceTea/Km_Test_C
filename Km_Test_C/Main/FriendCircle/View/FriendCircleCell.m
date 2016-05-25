//
//  FriendCircleCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleCell.h"
#import "FriendCircleMediaCell.h"
#import "ZTImageBrowserModel.h"
#import "NSString+expanded.h"
#import "UILabel+expanded.h"
#import "UIView+Frame.h"
#import <UIImageView+WebCache.h>

#define kFriendCircleCell_PadingLeft 15
#define kFriendCircleCell_PadingRight 15
#define kFriendCircleCell_PadingTop  15.0
#define kFriendCircleCell_HeadImageViewHeight   30.0f
#define kFriendCircleCell_ContentMaxHeight 200.0
#define kFriendCircleCell_ContentX kFriendCircleCell_PadingLeft*2 +kFriendCircleCell_HeadImageViewHeight
#define kFriendCircleCell_ContentWidth kSCREEN_WIDTH - kFriendCircleCell_ContentX - kFriendCircleCell_PadingRight*6
#define kFriendCircleCell_MediaImageViewHeight  (kFriendCircleCell_ContentWidth - 6)/3


@interface FriendCircleCell()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
//@property (nonatomic,strong) UIView *lastView;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *distanceLabel;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *locationLabel;

@property (nonatomic,strong) UICollectionView *mediaView;
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
        if (!_headerImageView) {
            _headerImageView = [UIImageView new];
            [_headerImageView setFrame:CGRectMake(kFriendCircleCell_PadingLeft, kFriendCircleCell_PadingTop, kFriendCircleCell_HeadImageViewHeight, kFriendCircleCell_HeadImageViewHeight)];
            [self.contentView addSubview:_headerImageView];
        }
        
        if (!_userNameLabel) {
            _userNameLabel = [UILabel new];
            [_userNameLabel setFrame:CGRectMake(kFriendCircleCell_ContentX, kFriendCircleCell_PadingTop, 50, 20)];
            [_userNameLabel setFont:[UIFont systemFontOfSize:13]];
            [self.contentView addSubview:_userNameLabel];
        }
        
        
        if (!_distanceLabel) {
            _distanceLabel = [UILabel new];
            [_distanceLabel setFrame:CGRectMake(kFriendCircleCell_ContentX,CGRectGetMaxY(_userNameLabel.frame), 50, 20)];
            [_distanceLabel setFont:[UIFont systemFontOfSize:9]];
            [_distanceLabel setTextColor:[UIColor orangeColor]];
            [self.contentView addSubview:_distanceLabel];
        }
        
        if (!_locationLabel) {
            _locationLabel = [UILabel new];
            [_locationLabel setFrame:CGRectMake(CGRectGetMaxX(_distanceLabel.frame) + 10,CGRectGetMaxY(_userNameLabel.frame), 50, 20)];
            [_locationLabel setFont:[UIFont systemFontOfSize:9]];
            [_locationLabel setTextColor:[UIColor colorWithWhite:0.5 alpha:1]];
            [self.contentView addSubview:_locationLabel];
        }
        
        if (!_dateLabel) {
            _dateLabel = [UILabel new];
            [_dateLabel setFont:[UIFont systemFontOfSize:10]];
            [_dateLabel setFrame:CGRectMake(kSCREEN_WIDTH - 50 - kFriendCircleCell_PadingTop, kFriendCircleCell_PadingTop, 50, 20)];
            [_dateLabel setTextColor:[UIColor colorWithWhite:0.4 alpha:1]];
            [self.contentView addSubview:_dateLabel];
        }
        
        if (!_detailLabel) {
            _detailLabel = [UILabel new];
            [_detailLabel setFrame:CGRectMake(kFriendCircleCell_ContentX, CGRectGetMaxY(_distanceLabel.frame), kFriendCircleCell_ContentWidth, 20)];
            [_detailLabel setFont:[UIFont systemFontOfSize:13.5]];
            _detailLabel.numberOfLines = 0;
            [self.contentView addSubview:_detailLabel];
        }
        
        if (!_detailLikeikeButton) {
            _detailLikeikeButton = [UIButton new];
            [_detailLikeikeButton setFrame:CGRectMake(kSCREEN_WIDTH - 40*2 - kFriendCircleCell_PadingRight*2, 0, 40, 20)];
            [_detailLikeikeButton setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
            [_detailLikeikeButton.titleLabel setFont:[UIFont systemFontOfSize:9]];
            [_detailLikeikeButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
            [_detailLikeikeButton setTitle:@"赞" forState:UIControlStateNormal];
            [_detailLikeikeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            [_detailLikeikeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            [self.contentView addSubview:_detailLikeikeButton];
        }
        
        if (!_detailCmtikeButton) {
            _detailCmtikeButton= [UIButton new];
            [_detailCmtikeButton setFrame:CGRectMake(CGRectGetMaxX(_detailLikeikeButton.frame) + kFriendCircleCell_PadingLeft, 0, 40, 20)];
            [_detailCmtikeButton setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
            [_detailCmtikeButton.titleLabel setFont:[UIFont systemFontOfSize:9]];
            [_detailCmtikeButton setImage:[UIImage imageNamed:@"activity_detail_cmt"] forState:UIControlStateNormal];
            [_detailCmtikeButton setTitle:@"评论" forState:UIControlStateNormal];
            [_detailCmtikeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            [_detailCmtikeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
            [self.contentView addSubview:_detailCmtikeButton];
        }
        
        if (!self.mediaView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.mediaView = [[UICollectionView alloc] initWithFrame:CGRectMake(kFriendCircleCell_ContentX, 0, kFriendCircleCell_ContentWidth, 80) collectionViewLayout:layout];
            self.mediaView.scrollEnabled = NO;
            [self.mediaView setBackgroundView:nil];
            [self.mediaView setBackgroundColor:[UIColor clearColor]];
            [self.mediaView registerClass:[FriendCircleMediaCell class] forCellWithReuseIdentifier:kCCellIdentifier_FriendCircleMediaCell];
            self.mediaView.dataSource = self;
            self.mediaView.delegate = self;
            [self.contentView addSubview:self.mediaView];
        }
        
        
    }
    return self;
}


- (void)setModel:(FriendCircleModel *)model{
    _model = model;
    if (!_model) {
        return;
    }
    
    //    UIImage *image = [UIImage imageNamed:model.profileImageUrl];
    //    UIGraphicsBeginImageContextWithOptions(self.headerImageView .bounds.size, NO, 1.0);
    //    [[UIBezierPath bezierPathWithRoundedRect:self.headerImageView .bounds
    //                                cornerRadius:10.0] addClip];
    //    [image drawInRect:self.headerImageView.bounds];
    //    self.headerImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.profileImageUrl] placeholderImage:[UIImage imageNamed:@"myhome_default_head"]];
    self.userNameLabel.text = model.userName;
    self.distanceLabel.text = model.distan;
    self.dateLabel.text = model.createdAt;
    self.locationLabel.text = model.location;
    [self.detailLabel setLongString:model.text withFitWidth:kFriendCircleCell_ContentWidth maxHeight:kFriendCircleCell_ContentMaxHeight];
    
    CGFloat curBottomY = CGRectGetMaxY(self.detailLabel.frame);
    if (model.imagesArray.count>0) {
        CGFloat mediaHeight = [[self class] contentMediaHeightWithTweet:model];
        [self.mediaView setFrame:CGRectMake(kFriendCircleCell_ContentX, curBottomY, kFriendCircleCell_ContentWidth, mediaHeight)];
        [self.mediaView reloadData];
        self.mediaView.hidden = NO;
        curBottomY += mediaHeight;
    }else{
        self.mediaView.hidden = YES;
    }
    
    curBottomY += kFriendCircleCell_PadingTop;
    [self.detailLikeikeButton setY:curBottomY];
    [self.detailCmtikeButton setY:curBottomY];
}

+ (CGFloat)contentMediaHeightWithTweet:(FriendCircleModel *)model{
    CGFloat contentMediaHeight = 0;
    NSInteger mediaCount = model.imagesArray.count;
    if (mediaCount > 0) {
        if (mediaCount == 1) {
            
        }else{
            return ceilf((float)mediaCount/3)*kFriendCircleCell_MediaImageViewHeight;
        }
    }
    return contentMediaHeight;
    return 0;
}

+ (CGFloat)heightWithModel:(FriendCircleModel *)model {
    CGFloat cellHeight = 0;
    cellHeight += kFriendCircleCell_PadingTop;
    cellHeight += 40;
    cellHeight += 300; //[self contentHeightWithModel:model];
    cellHeight += [self mediatHeightWithModel:model];
    cellHeight += kFriendCircleCell_PadingTop;
    cellHeight += 20;
    cellHeight += kFriendCircleCell_PadingTop;
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

#pragma mark UICollection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger row = 0;
    if (collectionView == _mediaView) {
        row = _model.imagesArray.count;
    }else{
        return 0;
    }
    return row;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _mediaView) {
        FriendCircleMediaCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:kCCellIdentifier_FriendCircleMediaCell forIndexPath:indexPath];
        [ccell.imageView setFrame:CGRectMake(0, 0, kFriendCircleCell_MediaImageViewHeight, kFriendCircleCell_MediaImageViewHeight)];
        [ccell.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.imagesArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"myhome_default_head"]];
        return ccell;
    }else{
        
    }
    return nil;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView == _mediaView) {
        return 3.0;
    }else{
        return kFriendCircleCell_PadingLeft;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView == _mediaView) {
        return 2.0;
    }else{
        return kFriendCircleCell_PadingLeft/2;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kFriendCircleCell_MediaImageViewHeight, kFriendCircleCell_MediaImageViewHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.mediaClickedBlock) {
        FriendCircleMediaCell *cell = (FriendCircleMediaCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        self.mediaClickedBlock(self.model,cell.imageView,indexPath.row);
    }
}


@end
