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


+ (FriendCircleModel *)statusWithDictionary:(NSDictionary *)dic{
    FriendCircleModel *status = [[FriendCircleModel alloc]initWithDictionary:dic];
    return status;
}

- (NSString *)source{
    return [NSString stringWithFormat:@"来自 %@",_source];
}

@end
