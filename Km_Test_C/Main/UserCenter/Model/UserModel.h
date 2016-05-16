//
//  UserModel.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/15.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KMAbstractObject.h"

@interface UserModel : KMAbstractObject
@property (nonatomic,copy) NSString *profileImageUrl;//头像
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *userName;//发送用户
@property (nonatomic,copy) NSString *mbtype;//会员类型
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *job;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *birthday;

+ (UserModel *)share;
+ (BOOL)isLogin;
+ (void)saveLoginData;
+ (void)loginOut;
@end
