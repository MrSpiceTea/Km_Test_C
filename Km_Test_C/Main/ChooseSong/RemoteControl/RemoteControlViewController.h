//
//  RemoteControlViewController.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol RemoteControlViewControllerDelegate <NSObject>
- (void)dismissViewController:(UIViewController*)viewController;
@end


@interface RemoteControlViewController : BaseViewController
@property (nonatomic,weak) id<RemoteControlViewControllerDelegate> delegate;
//- (void)hideTabBar:(UITabBarController *) tabbarcontroller;
@end
