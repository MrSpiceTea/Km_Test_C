//
//  ZTImageBrowserCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ZTImageBrowserCell.h"
@interface ZTImageBrowserCell()
@property(nonatomic,weak)UIImageView *imageView;
@end

@implementation ZTImageBrowserCell

- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView = imageView;

        [self.contentView addSubview:imageView];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

@end
