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

- (void)gettest{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:@"http://mobile.ktvme.com:8100/?body=%7B%22cmdid%22%3A%22D332%22%2C%22tid%22%3A%229%22%2C%22supportfullsongdb%22%3A%220%22%2C%22startpos%22%3A%221%22%2C%22requestnum%22%3A%2220%22%7D" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
         NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
  
}
@end
