//
//  FriendCircleCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCircleCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;

- (instancetype)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                       detail:(NSString *)imageName
              reuseIdentifier:(NSString *)reuseIdentifier;
@end
