//
//  ZTImagePickerItem.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/6/1.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#define ZTImagePickerItemID @"ZTImagePickerItem"
#define kZTImagePickerItemCell_Height  (kSCREEN_WIDTH - 3*5)/4
@interface ZTImagePickerItem : UICollectionViewCell
@property (nonatomic, strong) ALAsset *assets;
@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, copy) void(^selectedBlock)(BOOL isSelected);
- (void)startSelectedAnimation;
@end
