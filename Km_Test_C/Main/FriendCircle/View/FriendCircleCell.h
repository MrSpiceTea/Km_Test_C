//
//  FriendCircleCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendCircleModel.h"
#import "FriendPhotoContainerView.h"

@interface FriendCircleCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIButton *detailLikeikeButton;
@property (nonatomic,strong) UIButton *detailCmtikeButton;
@property (nonatomic,strong) FriendCircleModel *model;
@property (nonatomic,strong) FriendPhotoContainerView *friendPhotoContainerView;


- (instancetype)initWithFriendCircleModel:(FriendCircleModel *)friendCircleModel reuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)heightWithModel:(FriendCircleModel *)model;
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@end
