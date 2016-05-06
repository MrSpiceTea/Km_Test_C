//
//  KM_NetAPIManager.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KM_NetAPIManager.h"

@interface KM_NetAPIManager ()
@property (nonatomic,strong) KM_APIRequestAgent *requestAgen;
@end
@implementation KM_NetAPIManager
+ (instancetype)defaultManage {
    static dispatch_once_t onceToken;
    static KM_NetAPIManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[KM_NetAPIManager alloc]init];
    });
    return _instance;
}
- (instancetype)init{
    if (self = [super init]) {
        self.requestAgen = [[KM_APIRequestAgent alloc]init];
    }
    return self;
}

#pragma mark -
- (void)fetchHotSongListWithCompletion:(NetAPIRequestCompletion)completion{
    
}

@end
