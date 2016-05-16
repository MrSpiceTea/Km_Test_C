//
//  FriendCircleDetailBottomView.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/11.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^tapBlock)(UIButton *button);
@interface FriendCircleDetailBottomView : UIView
@property (nonatomic,copy) tapBlock tapblock;
@property (nonatomic,strong) UIView *topseparatorView;
@property (nonatomic,strong) UIView *centerseparatorView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@end
