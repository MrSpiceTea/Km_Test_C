//
//  FriendPhotoContainerView.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/5.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendCircleModel.h"

@protocol FriendPhotoContainerViewDelegate <NSObject>
- (void)imageTapAtIndex:(NSUInteger )index;
@end

@interface FriendPhotoContainerView : UIView
@property (nonatomic, strong) NSArray *picUrlStringsArray;
@property (nonatomic, weak) id<FriendPhotoContainerViewDelegate> delegate;
- (CGFloat)heightWidthImages:(NSArray *)images;
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array;
- (NSInteger)rowCountForImagesArray:(NSArray *)array;
@end
