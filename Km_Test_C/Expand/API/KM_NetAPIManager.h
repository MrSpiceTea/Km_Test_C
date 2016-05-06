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

@interface KM_NetAPIManager : NSObject

+ (instancetype)defaultManage;
#pragma mark - Login


#pragma mark - 
- (void)fetchHotSongListWithCompletion:(NetAPIRequestCompletion)completion;

@end
