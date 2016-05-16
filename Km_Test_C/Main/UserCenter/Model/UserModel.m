//
//  UserModel.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/15.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "UserModel.h"

#define kLoginStatus @"login_status"
#define kLoginUserDict @"user_dict"

@implementation UserModel

+ (void)loginOut{
    
}

+ (BOOL)isLogin{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    
    return 0;
}
@end
