//
//  FirendCircleCommentViewController.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/12.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "BaseViewController.h"

@protocol FirendCircleCommentDelegate <NSObject>
- (void)textViewtext:(NSString *)text;
@end

@interface FirendCircleCommentViewController : BaseViewController
@property(weak,nonatomic)id<FirendCircleCommentDelegate> delegate;
@end
