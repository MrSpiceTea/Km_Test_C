//
//  KMAbstractObject.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Utilities.h"
@interface KMAbstractObject : NSObject
<<<<<<< HEAD
@property (nonatomic, copy) NSString *theID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *fileID;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSURL *imageURL;
=======
@property (nonatomic, strong) NSURL *HDURL;//位置
@property (nonatomic, strong) NSString *theID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, copy) NSString *status;
>>>>>>> master
- (instancetype)initWithDict:(NSDictionary *)dirtyDict;
@end
