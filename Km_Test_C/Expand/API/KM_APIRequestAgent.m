//
//  KM_APIRequestAgent.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "KM_APIRequestAgent.h"

@implementation KM_APIRequestAgent
#pragma mark - Requests
- (NSURLRequest *)apiRequestOfHotSongList{
    //TODO: Parameters/enchance
    return [NSURLRequest requestWithURL:[NSURL URLWithString:kKMHotSongListPath]];
}

- (NSString *)apiRequestOfHotSongListUrl{
    //TODO: Parameters/enchance
    return @"http://mobile.ktvme.com:8100/?body=%7B%22cmdid%22%3A%22D332%22%2C%22tid%22%3A%229%22%2C%22supportfullsongdb%22%3A%220%22%2C%22startpos%22%3A%221%22%2C%22requestnum%22%3A%2220%22%7D";
}
@end
