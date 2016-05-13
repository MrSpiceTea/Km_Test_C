//
//  CommonTableViewController.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
- (void)hidesTabBar:(BOOL)hidden;
@end
