//
//  ArtistListViewController.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseBaseViewController.h"

@interface ArtistListViewController : ChooseBaseViewController
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,copy) NSString *songstertypeid;
@end
