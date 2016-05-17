//
//  KM_APIRequestAgent.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KM_NetAPManagerDefine.h"

@interface KM_APIRequestAgent : NSObject

//url
- (NSURLRequest *)apiRequestOfHotSongList;
- (NSString *)apiRequestOfHotSongListUrl;
- (NSString *)apiRequestOfRecommendSongListUrl;
- (NSString *)apiRequestOfRankingSongListUrl;
- (NSString *)apiRequestOfArtistListUrl;
+ (NSURL *)imageurlWidthPicurlhead:(NSString *)filid;
@end
