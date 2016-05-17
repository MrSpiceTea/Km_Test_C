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
            NSString *theid = [dirtyDict stringValueForCandidateKeys:keys];
            if (theid.length>0) {
                self.theID = theid;
            }

            keys = @[@"des"];
            NSString *des = [dirtyDict stringValueForCandidateKeys:keys];
            if (des.length>0) {
                self.des = des;
            }
            
            keys = @[@"fid"];
            NSString *fid = [dirtyDict stringValueForCandidateKeys:keys];
            if (fid.length>0) {
                self.fileID = fid;
            }
            
            keys = @[@"t"];
            NSString *time = [dirtyDict stringValueForCandidateKeys:keys];
            if (time.length>0) {
                self.time = time;
            }
        }
    }
    return self;
}
@end
