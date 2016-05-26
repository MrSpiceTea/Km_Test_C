//
//  ZTImageBrowser.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageBrowserModel.h"
#import "ZTImageBrowserCell.h"
@interface ZTImageBrowser : UIViewController
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSMutableArray *imageModels;
@property (nonatomic,strong) ZTImageBrowserImageItem* currentImageItem;
@end
