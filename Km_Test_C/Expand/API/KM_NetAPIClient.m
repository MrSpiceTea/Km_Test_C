//
//  KM_NetAPIClient.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KM_NetAPIClient.h"
#import "AFNetworking.h"

@interface KM_NetAPIClient()
    
@end

@implementation KM_NetAPIClient



+ (instancetype)defaultManage {
    static dispatch_once_t onceToken;
    static KM_NetAPIClient *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[KM_NetAPIClient alloc]init];
    });
    return _instance;
}

+ (AFHTTPSessionManager *)shareSessionManage {
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [AFHTTPSessionManager manager];
    });
    return _instance;
}

- (void)gettest{
  
}

- (void)requestJsonDicWithPathGet:(NSString *)aPath
                    withParams:(NSDictionary*)params
                withMethodType:(NetworkMethod)method
               completionBolck:(void (^)(id jsonResponseObject, NSError *error))completion{
    AFHTTPSessionManager *manager = [KM_NetAPIClient shareSessionManage];
    [manager GET:aPath parameters:nil progress:nil
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestJsonDicWithPathPost:(NSString *)aPath
                        withParams:(NSDictionary*)params
                    withMethodType:(NetworkMethod)method
                   completionBolck:(void (^)(id jsonResponseObject, NSError *error))completion{
    AFHTTPSessionManager *manager = [KM_NetAPIClient shareSessionManage];
    [manager POST:aPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}



@end
