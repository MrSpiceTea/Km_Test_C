//
//  ZTImageBrowserModel.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ZTImageBrowserModel.h"

@implementation ZTImageBrowserModel
- (UIImage *)capture:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)setSrcImageView:(UIImageView *)srcImageView
{
    _srcImageView = srcImageView;
    NSLog(@"%@,img = %@",self,_srcImageView);
    _placeholder = srcImageView.image;
    _srcImageViewRect = [srcImageView convertRect:srcImageView.bounds toView:nil];
    if (srcImageView.clipsToBounds) {
        _thumbnailImage = [self capture:srcImageView];
    }
}
@end
