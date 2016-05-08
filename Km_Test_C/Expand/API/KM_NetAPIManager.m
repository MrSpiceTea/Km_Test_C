//
//  KM_NetAPIManager.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KM_NetAPIManager.h"
#import "KM_NetAPIClient.h"

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
- (void)fetchHotSongListWithCompletion:(NetAPIRequestListCompletion)completion{
    NSString *url = [self.requestAgen apiRequestOfHotSongListUrl];
    [[KM_NetAPIClient defaultManage] requestJsonDicWithPath:url withParams:nil withMethodType:Get completionBolck:^(id jsonResponseObject, NSError *error) {
        if ([jsonResponseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *rs = ((NSDictionary *)jsonResponseObject)[@"rs"];
            NSArray *rsArray = rs[@"r"];
            if (rsArray.count>0) {
                NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:rsArray.count];
                for (NSDictionary *dirtyDict in rsArray) {
                     NSLog(@"%@",dirtyDict);
                }
            }
        }
    }];
}

@end
