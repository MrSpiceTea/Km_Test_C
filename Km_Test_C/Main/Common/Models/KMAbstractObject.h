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
@property (nonatomic, strong) NSString *theID;
@property (nonatomic, strong) NSString *name;
- (instancetype)initWithDict:(NSDictionary *)dirtyDict;
@end
