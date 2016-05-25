//
//  ZTImageBrowserCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ZTImageBrowserCell.h"
@interface ZTImageBrowserCell()

@end

@implementation ZTImageBrowserCell

- (ZTImageBrowserImageItem *)imageItem{
    if (!_imageItem) {
        ZTImageBrowserImageItem *imageItem = [[ZTImageBrowserImageItem alloc] initWithFrame:self.bounds];
        _imageItem = imageItem;
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imageItem];
    }
    return _imageItem;
}

- (void)setModel:(ZTImageBrowserModel *)model{
    if (_model != model) {
        _model = model;
    }
    _model = model;
//    [self.imageItem.imageView setImage:model.thumbnailImage];
    self.imageItem.imageModel = model;
    
}



@end
