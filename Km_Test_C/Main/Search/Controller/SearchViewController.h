//
//  SearchViewController.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, SearchState) {
    DSearchStateUnknown,
    SearchStateStandby,
    SearchStateTyping,
    SearchStateLoading,
    SearchStateShowingResult,
    SearchStateNoResult
};


@interface SearchViewController : BaseViewController

@end
