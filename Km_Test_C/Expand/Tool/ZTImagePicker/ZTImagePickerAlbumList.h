//
//  ZTImagePickerAlbumList.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/6/1.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImagePicker.h"
@interface ZTImagePickerAlbumList : UITableViewController
@property (nonatomic, strong) UIViewController *prevc;
@property (nonatomic, strong) NSMutableArray *assetGroups;
@property (nonatomic, strong) NSArray *mediaTypes;
@property (nonatomic, assign) BOOL isOriginal;
@end
