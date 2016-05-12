//
//  GlobalDefines.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//

#ifndef GlobalDefines_h
#define GlobalDefines_h

//ptah
#define kSearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"historyDatas.plist"]
#define kFriendCircleListPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"IssueDatas.plist"]

//color
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define kCommonBottomText RGB(100, 100, 100)
#define kCommonCellDetailTextLabelColor RGB(150, 150, 150)
#define kCommonBavkgroundViewColor RGB(240, 240, 240)
#define kCommonTableViewBavkgroundColor RGB(246, 246, 246)
#define kCommonTableViewSeparatorBavkgroundColor RGB(246, 246, 246)
#endif /* GlobalDefines_h */
