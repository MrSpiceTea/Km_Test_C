//
//  FriendPhotoContainerView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/5.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendPhotoContainerView.h"

@interface FriendPhotoContainerView()
@property (nonatomic, strong) NSArray *imageViewsArray;
@end

@implementation FriendPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewsArray = [temp copy];
}

static const CGFloat kFriendPhotoContainerViewPicMargin = 5.0f;
- (void)setPicUrlStringsArray:(NSArray *)picUrlStringsArray{
    _picUrlStringsArray = picUrlStringsArray;
    
    for (UIImageView *view in [self subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.image = nil;
        }
    }
    CGFloat itemW = [self itemWidthForPicPathArray:_imageViewsArray];
    CGFloat itemH = 0;
    if (_picUrlStringsArray.count == 1) {
        UIImage *image = [UIImage imageNamed:_picUrlStringsArray.firstObject];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self rowCountForImagesArray:_picUrlStringsArray];
    
    [_picUrlStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:obj];
        imageView.frame = CGRectMake(columnIndex * (itemW + kFriendPhotoContainerViewPicMargin), rowIndex * (itemH + kFriendPhotoContainerViewPicMargin), itemW, itemH);
    }];
    
    CGFloat width = perRowItemCount * itemW + (perRowItemCount - 1) * kFriendPhotoContainerViewPicMargin;
    int columnCount = ceilf(_picUrlStringsArray.count * 1.0 / perRowItemCount);
    CGFloat height = columnCount * itemH + (columnCount - 1) * kFriendPhotoContainerViewPicMargin;
    CGRect frame = self.frame;
    frame.size = CGSizeMake(width, height);
    self.frame = frame;
    self.backgroundColor = [UIColor redColor];
}

#pragma mark - private actions
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat width = kSCREEN_WIDTH > 320 ? 80 : 70;
        return width;
    }
}

- (NSInteger)rowCountForImagesArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}
@end
