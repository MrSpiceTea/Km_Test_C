//
//  FriendCircleModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMAbstractObject.h"
typedef NS_ENUM(NSUInteger, MessageType) {
    MessageTypeNone,
    MessageTypeImage,
    MessageTypeVideo,
    MessageTypeAudio,
};

@interface FriendCircleModel : KMAbstractObject

@property (nonatomic,assign) long long Id;//id
@property (nonatomic,copy) NSString *profileImageUrl;//头像
@property (nonatomic,copy) NSString *userName;//发送用户
@property (nonatomic,copy) NSString *mbtype;//会员类型
@property (nonatomic,copy) NSString *location;//位置
@property (nonatomic,copy) NSString *createdAt;//创建时间
@property (nonatomic,copy) NSString *source;//设备来源
@property (nonatomic,copy) NSString *text;//内容


- (FriendCircleModel *)initWithDictionary:(NSDictionary *)dic;
+ (FriendCircleModel *)statusWithDictionary:(NSDictionary *)dic;
@end
