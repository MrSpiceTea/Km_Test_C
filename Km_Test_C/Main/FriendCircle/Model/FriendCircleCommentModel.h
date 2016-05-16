//
//  FriendCircleCommentModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/12.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleModel.h"

@interface FriendCircleCommentModel : FriendCircleModel

@property (nonatomic,copy) NSString *content;//内容

- (FriendCircleModel *)initWithDictionary:(NSDictionary *)dic;

@end
