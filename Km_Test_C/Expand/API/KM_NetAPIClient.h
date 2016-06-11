//
//  KM_NetAPIClient.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KM_NetAPIClient : NSObject
typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

+ (instancetype)defaultManage;


- (void)requestJsonDicWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       completionBolck:(void (^)(id jsonResponseObject, NSError *error))completion;

//GET
- (void)requestJsonDicWithPathGet:(NSString *)aPath
                    withParams:(NSDictionary*)params
                withMethodType:(NetworkMethod)method
               completionBolck:(void (^)(id jsonResponseObject, NSError *error))completion;
//POST
- (void)requestJsonDicWithPathPost:(NSString *)aPath
                       withParams:(NSDictionary*)params
                   withMethodType:(NetworkMethod)method
                  completionBolck:(void (^)(id jsonResponseObject, NSError *error))completion;


//DOWNLOAD

//UPLOAD
@end
