//
//  RankingListModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingListModel : NSObject

@property (nonatomic, assign) NSUInteger trackNumber;
@property (nonatomic, assign) NSUInteger discNumber;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *dateString;
@end
