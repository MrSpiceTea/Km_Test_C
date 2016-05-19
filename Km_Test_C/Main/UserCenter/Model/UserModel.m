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

- (instancetype)initWithDict:(NSDictionary *)dirtyDict{
    if (self = [super initWithDict:dirtyDict]) {
        if(dirtyDict){
            NSArray *keys = @[@"profileImageUrl"];
            NSString *profileImageUrl = [dirtyDict stringValueForCandidateKeys:keys];
            if (profileImageUrl.length>0) {
                self.profileImageUrl = profileImageUrl;
            }
        }
    }
    return self;
}

+ (UserModel *)shareUser{
    static dispatch_once_t onceToken;
    static UserModel *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[UserModel alloc]init];
    });
    return _instance;
}

+ (void)loginOut{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    loginStatus = 0;
    [[NSUserDefaults standardUserDefaults]setObject:loginStatus forKey:kLoginStatus];
    
    //removeuserdata
}

+ (void)loginin:(NSDictionary *)userData{
    //save userdata
}

+ (BOOL)isLogin{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    return loginStatus;
}
@end
