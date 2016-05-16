//
//  KM_NetAPIManager.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KM_APIRequestAgent.h"
typedef void(^NetAPIRequestCompletion)(id resultAsDictOrArray, NSError *error);
typedef void (^NetAPIRequestListCompletion)(NSArray *results, NSInteger total, NSError *error);
@interface KM_NetAPIManager : NSObject

+ (instancetype)defaultManage;
#pragma mark - Login

- (void)logInWithID:(NSString *)userID password:(NSString *)password;
- (void)logInWithparam:(NSDictionary *)paramDic completion:(NetAPIRequestListCompletion)completion;
//- (void)logInWithID:(NSString *)userID andPassword:(NSString *)password;

#pragma mark - 
- (void)fetchHotSongListWithCompletion:(NetAPIRequestListCompletion)completion;
- (void)fetchRecommendSongListWithCompletion:(NetAPIRequestListCompletion)completion;
@end
