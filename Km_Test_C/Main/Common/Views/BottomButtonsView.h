//
//  BottomButtonsView.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/11.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BottomButtonsView : UIView
@property(nonatomic,copy) UIButton *(^fetchButtonAtIndex)(NSUInteger index);
@end
