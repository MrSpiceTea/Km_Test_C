//
//  KMAbstractObject.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KMAbstractObject.h"

@implementation KMAbstractObject
- (instancetype)initWithDict:(NSDictionary *)dirtyDict{
    if (self = [super init]) {
        if (dirtyDict) {
            NSArray *keys = @[@"id", @"contentid"];
            self.theID = [dirtyDict stringValueForCandidateKeys:keys];
        }
    }
    return self;
}
@end
