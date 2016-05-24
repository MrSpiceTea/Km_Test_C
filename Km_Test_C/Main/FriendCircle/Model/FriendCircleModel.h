//
//  FriendCircleModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMAbstractObject.h"
typedef NS_ENUM(NSUInteger, FriendCircleModelMessageType) {
    FriendCircleModelMessageTypeNone,
    FriendCircleModelMessageTypeImage,
    FriendCircleModelMessageTypeVideo,
    FriendCircleModelMessageTypeAudio,
};

@interface FriendCircleModel : KMAbstractObject

@property (nonatomic,assign) long long Id;//id
//TODO: UserModel
@property (nonatomic,copy) NSString *profileImageUrl;//头像
@property (nonatomic,copy) NSString *userName;//发送用户
@property (nonatomic,copy) NSString *mbtype;//会员类型
@property (nonatomic,copy) NSString *location;//位置
@property (nonatomic,copy) NSString *createdAt;//创建时间
@property (nonatomic,copy) NSString *source;//设备来源
@property (nonatomic,copy) NSString *text;//内容
@property (nonatomic,copy) NSString *distan;//距离
@property (nonatomic,copy) NSString *praise;//赞数
@property (nonatomic,assign) FriendCircleModelMessageType messageType;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (nonatomic,strong) NSMutableArray *commentArray;//评论
@property (nonatomic,strong) NSMutableArray *likeArray;//赞
@property (nonatomic,strong) NSDictionary *content;
@property (nonatomic,assign) CGFloat cellHeight;

- (FriendCircleModel *)initWithDictionary:(NSDictionary *)dic;
+ (FriendCircleModel *)statusWithDictionary:(NSDictionary *)dic;
@end
