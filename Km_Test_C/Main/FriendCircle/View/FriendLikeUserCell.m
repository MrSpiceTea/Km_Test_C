//
//  FriendLikeUserCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/19.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendLikeUserCell.h"
#import "UIImage+expanded.h"
#define kCellWidhCollectionViewIdentifier @"FriendLikeUserCell"
#define kCellWidhCollectionCellWidth  25
@interface FriendLikeUserCell ()

@property (strong, nonatomic) UILabel *likesLabel;
@end

@implementation FriendLikeUserCell

//+ (FriendLikeUserCell *)cellWidhCollectionView:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath{
//    FriendLikeUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellWidhCollectionViewIdentifier forIndexPath:indexPath];
//    if (!cell) {
//        cell = [UICollectionViewCell alloc]
//    }
//    
//    return cell;
//}

- (void)setUserModel:(UserModel *)userModel{
    if (userModel) {
        _userModel = userModel;
        //test image todo net
        [self.imgView setImage:[UIImage imageNamed:userModel.profileImageUrl]];
    }else{
        [self.imgView setImage:[UIImage imageWithColor:[UIColor blackColor]]];
    }
 
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kCellWidhCollectionCellWidth, kCellWidhCollectionCellWidth)];
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = kCellWidhCollectionCellWidth/2;
        [self.contentView addSubview:self.imgView];
    }
    return _imgView;
}



@end
