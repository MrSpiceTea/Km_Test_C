//
//  MediaModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KMAbstractObject.h"

@interface MediaModel : KMAbstractObject
@property (nonatomic, strong) NSURL *thumbnailImageURL;
@property (nonatomic, strong) NSURL *HDImageURL;
@property (nonatomic, strong) NSURL *videoURL;

@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) UIImage *HDImage;
@end
