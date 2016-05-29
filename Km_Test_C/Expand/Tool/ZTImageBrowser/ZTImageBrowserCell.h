//
//  ZTImageBrowserCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageBrowserModel.h"
#import "ZTImageBrowserImageItem.h"
@interface ZTImageBrowserCell : UICollectionViewCell
@property(nonatomic,strong)ZTImageBrowserModel *model;
@property(nonatomic,weak)ZTImageBrowserImageItem *imageItem;
@end
