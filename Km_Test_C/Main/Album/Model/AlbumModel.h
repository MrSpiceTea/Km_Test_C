//
//  AlbumModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KMAbstractObject.h"

@interface AlbumModel : KMAbstractObject
@property (nonatomic,copy) NSString *albumName;
@property (nonatomic,copy) NSString *serialNumber;
@property (nonatomic,copy) NSString *artistName;

- (instancetype)initWithDict:(NSDictionary *)dirtyDict;
@end
