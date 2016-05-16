//
//  ArtistClassCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/27.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtistClassCell : UITableViewCell
typedef void (^TapBolck)(NSUInteger tag);
@property (strong, nonatomic) UILabel *titleLabel;
@property (nonatomic,copy) TapBolck tapbolck;
- (instancetype)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithArtists:(NSArray *)artists reuseIdentifier:(NSString *)reuseIdentifier;
@end
