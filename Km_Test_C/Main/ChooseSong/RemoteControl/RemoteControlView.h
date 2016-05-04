//
//  RemoteControlView.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemoteControlDelegate
- (void)RemoteControlButtonAction:(UIButton *)button;
@end

@interface RemoteControlView : UIView{
    id<RemoteControlDelegate> delegate;
}
@property(assign,nonatomic)id<RemoteControlDelegate> delegate;
@end
