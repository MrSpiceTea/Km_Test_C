//
//  ZTImageBrowserImageItem.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImageBrowserModel.h"
@protocol ZTImageBrowserImageItemDelegate <NSObject>

- (void)disMissBrowser;

@end

@interface ZTImageBrowserImageItem : UIScrollView
@property (nonatomic,strong) UIImageView* imageView;
@property (nonatomic,strong) ZTImageBrowserModel *imageModel;
@property (nonatomic,weak) id<ZTImageBrowserImageItemDelegate> imageItemDelegate;
@property (nonatomic,assign,getter=isFirstShow) BOOL firstShow;
@end
