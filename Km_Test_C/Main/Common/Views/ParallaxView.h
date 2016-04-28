//
//  ParallaxView.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParallaxView : UIView
@property (nonatomic, assign) CGFloat backgroundHeight;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *foregroundView;
@property (nonatomic, strong) UIView *toolbarView;
@property (nonatomic, assign) CGPoint contentOffset;
@end
