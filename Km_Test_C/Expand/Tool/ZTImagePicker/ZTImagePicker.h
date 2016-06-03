//
//  ZTImagePicker.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/6/1.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTImagePickerItem.h"

static NSString * kZTImagePickerSelectedPhotosCompletionNotification = @"ZTImagePickerSelectedPhotosCompletionNotification";
static NSString * kZTImagePickerSelectedPhotosCompletionNotificationDicKey = @"ZTImagePickerSelectedPhotosCompletionNotificationDicKey";

@protocol ZTImagePickerDelegate <NSObject>
- (void)fetchImagesWithImagePiceker:(NSMutableArray *)images;
@end

@interface ZTImagePicker : UIViewController
@property (nonatomic, weak) id<ZTImagePickerDelegate> delegate;
@property (nonatomic, strong) ALAssetsGroup *assetGroup;
@property (nonatomic, strong) NSMutableArray *ztAssets;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@end
