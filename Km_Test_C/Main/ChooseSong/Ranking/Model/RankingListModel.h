//
//  RankingListModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//
#import "CommonAbstractObject.h"
#import "AlbumModel.h"
#import <Foundation/Foundation.h>

@interface RankingListModel : AlbumModel
- (instancetype)initWithDict:(NSDictionary *)dirtyDict;
@property (nonatomic, assign) NSUInteger trackNumber;
@property (nonatomic, assign) NSUInteger discNumber;
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, copy) NSString *songs;
@property (nonatomic, copy) NSString *singers;
@end
