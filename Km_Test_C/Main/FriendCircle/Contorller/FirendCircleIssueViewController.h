//
//  FirendCircleIssueViewController.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/8.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableViewController.h"

@protocol FirendCircleIssueDelegate <NSObject>
- (void)sendIssue:(NSString *)contentText;
@end

@interface FirendCircleIssueViewController : CommonTableViewController
@property (nonatomic,weak) id<FirendCircleIssueDelegate> delegate;
@property (nonatomic, strong) NSMutableArray * selectedPhotos;
@end
