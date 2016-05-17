//
//  RankingListModel.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RankingListModel.h"

@implementation RankingListModel
- (instancetype)initWithDict:(NSDictionary *)dirtyDict{
    if (self = [super initWithDict:dirtyDict]) {
        if(dirtyDict){
            NSArray *keys = @[@"songs"];
            NSString *songs = [dirtyDict stringValueForCandidateKeys:keys];
            if (songs.length>0) {
                self.songs = songs;
            }
            
            keys = @[@"singers"];
            NSString *singers = [dirtyDict stringValueForCandidateKeys:keys];
            if (singers.length>0) {
                self.singers = singers;
            }
        }
    }
    return self;
}
@end
