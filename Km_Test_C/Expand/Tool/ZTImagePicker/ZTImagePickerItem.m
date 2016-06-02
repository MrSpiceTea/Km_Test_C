//
//  ZTImagePickerItem.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/6/1.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ZTImagePickerItem.h"


@implementation ZTImagePickerItem

- (void)setAssets:(ALAsset *)assets{
    if (_assets!=assets) {
        _assets = assets;
    }
    self.thumbnailImageView.image = [UIImage imageWithCGImage: assets.thumbnail];
}

- (UIImageView *)thumbnailImageView{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self.contentView addSubview:_thumbnailImageView];
        [self.contentView addSubview:self.selectButton];
    }
    return _thumbnailImageView;
}

- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 30, 5, 25, 25)];
        [_selectButton setImage:[UIImage imageNamed:@"ZTImagePickerPhoto_unselected"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"ZTImagePickerPhoto_selected"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (void)selectAction:(UIButton *)btn{
    if (self.selectedBlock) {
        self.selectButton.selected = !self.selectButton.selected;
        self.selectedBlock(btn.selected);
        [self startSelectedAnimation:self.selectButton];
    }
}

- (void)startSelectedAnimation:(UIView *)view {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    ani.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    ani.duration = 0.4;
    [view.layer addAnimation:ani forKey:@"transformAni"];
}

@end
