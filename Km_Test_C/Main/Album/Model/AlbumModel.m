//
//  AlbumModel.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "AlbumModel.h"

@implementation AlbumModel


- (instancetype)initWithDict:(NSDictionary *)dirtyDict{
    if (self = [super initWithDict:dirtyDict]) {
        if(dirtyDict){
            NSArray *keys = @[@"g"];
            NSString *albumName = [dirtyDict stringValueForCandidateKeys:keys];
            if (albumName.length>0) {
                self.albumName = albumName;
            }
            
            keys = @[@"s"];
            NSString *artisName = [dirtyDict stringValueForCandidateKeys:keys];
            if (artisName.length>0) {
                self.artistName = artisName;
            }
        }
    }
    return self;
}
@end
