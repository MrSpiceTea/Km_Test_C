//
//  FriendLikeUserCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/19.
//  Copyright © 2016年 OMG. All rights reserved.
//
#define kCellWidhCollectionViewIdentifier @"FriendLikeUserCell"
#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface FriendLikeUserCell : UICollectionViewCell
@property (nonatomic,strong) UserModel *userModel;
@property (strong, nonatomic) UIImageView *imgView;
//+ (FriendLikeUserCell *)cellWidhCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath;
@end
