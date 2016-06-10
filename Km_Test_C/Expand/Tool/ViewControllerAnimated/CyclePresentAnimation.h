//
//  CyclePresentAnimation.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/21.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CyclePresentTransitionType) {
    CyclePresentTransitionTypePresent = 1,
    CyclePresentTransitionTypeDismiss,
};


@interface CyclePresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CyclePresentTransitionType type;
+ (instancetype)transitionWithTransitionType:(CyclePresentTransitionType)type;
@end
