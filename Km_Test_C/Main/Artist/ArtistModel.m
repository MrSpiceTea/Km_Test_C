//
//  ArtistModel.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistModel.h"

@implementation ArtistModel

- (NSMutableArray *)albumArray{
    if (!_albumArray) {
        _albumArray = [NSMutableArray array];
    }
    return _albumArray;
}

@end
