//
//  FriendCircleCommentModel.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/12.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleCommentModel.h"

@implementation FriendCircleCommentModel

- (FriendCircleModel *)initWithDictionary:(NSDictionary *)dic{
    if (self = [super initWithDictionary:dic]) {
        self.content = dic[@"content"];
    }
    return self;
}

- (CGFloat)cellHeight{
    CGFloat textH = [self.content boundingRectWithSize:CGSizeMake(kSCREEN_WIDTH - 60 - 80, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.5]}
                                            context:nil].size.height;
    textH = textH + 55;
    return textH;
}

@end
