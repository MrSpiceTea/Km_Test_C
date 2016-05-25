//
//  FriendCircleMediaCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/23.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleMediaCell.h"

@implementation FriendCircleMediaCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}

@end
