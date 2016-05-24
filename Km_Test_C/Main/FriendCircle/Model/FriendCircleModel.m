//
//  FriendCircleModel.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleModel.h"

@implementation FriendCircleModel

-(FriendCircleModel *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        self.Id = [dic[@"Id"] longLongValue];
        self.profileImageUrl = dic[@"profileImageUrl"];
        self.userName = dic[@"userName"];
        self.mbtype = dic[@"mbtype"];
        self.createdAt = dic[@"createdAt"];
        self.source = dic[@"source"];
        self.text = dic[@"text"];
    }
    return self;
}

- (NSMutableArray *)content{
    if (!_content) {
        _content = [NSMutableArray array];
    }
    return _content;
}

- (NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray array];
    }
    return _imagesArray;
}

- (NSMutableArray *)likeArray{
    if (!_likeArray) {
        _likeArray = [NSMutableArray array];
    }
    return _likeArray;
}

- (NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

+ (FriendCircleModel *)statusWithDictionary:(NSDictionary *)dic{
    FriendCircleModel *status = [[FriendCircleModel alloc]initWithDictionary:dic];
    return status;
}

- (NSString *)source{
    return [NSString stringWithFormat:@"来自 %@",_source];
}

static const CGFloat FriendCircleCellImageViewHeight = 30.0f;
static const CGFloat FriendCircleCellTopMargin = 15.0f;
static const CGFloat kFriendPhotoContainerViewPicMargin = 5.0f;

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        CGFloat textW= kSCREEN_WIDTH - FriendCircleCellImageViewHeight - FriendCircleCellTopMargin*3;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.5]}
                                                context:nil].size.height;
        
        
        _cellHeight = textH + FriendCircleCellImageViewHeight + FriendCircleCellTopMargin*5;
        if (self.imagesArray.count>0) {
            CGFloat itemW = [self itemWidthForPicPathArray:self.imagesArray];
            long perRowItemCount = [self rowCountForImagesArray:self.imagesArray];
            CGFloat itemH = 0;
            if (self.imagesArray.count == 1) {
                UIImage *image = [UIImage imageNamed:self.imagesArray.firstObject];
                if (image.size.width) {
                    itemH = image.size.height / image.size.width * itemW;
                }
            } else {
                itemH = itemW;
            }
            long
            int columnCount = ceilf(self.imagesArray.count * 1.0 / perRowItemCount);
            CGFloat height = columnCount * itemH + (columnCount - 1) * kFriendPhotoContainerViewPicMargin;
            _cellHeight += height;
        }
        
    }
    return _cellHeight;
}


- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat width = kSCREEN_WIDTH > 320 ? 90 : 70;
        return width;
    }
}

- (NSInteger)rowCountForImagesArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}
@end
