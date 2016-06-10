//
//  MessageModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/13.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KMAbstractObject.h"
typedef NS_ENUM(NSUInteger, MessageModelType) {
    MessageModelTypeReceiver = 0,
    MessageModelTypeSender,
};

@interface MessageModel : KMAbstractObject

@property (nonatomic,copy) NSString *message;
@property (nonatomic,assign,getter =isHideTime) BOOL hideTime;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) MessageModelType messageType;
@property (nonatomic,strong) NSString *time;

//+ (instancetype )MessageWithDict:(NSDictionary *)dict;

@end
