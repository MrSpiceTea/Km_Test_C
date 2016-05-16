//
//  ChooseSongGirdView.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/16.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridView : UIView
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@end

@interface ChooseSongGirdView : UIView
@property (nonatomic,assign) NSUInteger gridViewCount;
@property (nonatomic,strong) UIView *(^fetchViewAtTag)(NSUInteger tag);
@property (nonatomic,strong) void (^viewTapBlock)(NSUInteger tag);


@end
