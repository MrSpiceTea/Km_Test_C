//
//  ArtistModel.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistModel.h"

@implementation ArtistModel

- (instancetype)initWithDict:(NSDictionary *)dirtyDict{
    if (self = [super initWithDict:dirtyDict]) {
        if(dirtyDict){
            NSArray  *keys = @[@"s"];
            NSString *artisName = [dirtyDict stringValueForCandidateKeys:keys];
            if (artisName.length>0) {
                self.artistName = artisName;
            }
        }
    }
    return self;
}
@end
