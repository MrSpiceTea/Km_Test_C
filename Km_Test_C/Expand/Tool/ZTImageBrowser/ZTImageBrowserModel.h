//
//  ZTImageBrowserModel.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTImageBrowserModel : NSObject

@property (nonatomic,strong) NSURL *HDurl;
@property (nonatomic,strong) UIImage *placeholder;
@property (nonatomic,strong) UIImage *thumbnailImage;
@property (nonatomic,copy) NSString *contentDescription;
@property (nonatomic,assign) CGRect originPosition;
@end
