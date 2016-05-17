//
//  Header.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#ifndef Header_h
#define Header_h

#pragma mark - TESTURL
#import "AlbumModel.h"
#import "RankingListModel.h"
//url
#pragma mark - Protocol Info
#pragma mark - Request Enchances
static NSString * const kKMHost                             = @"http://mobile.ktvme.com:8100/";
static NSString * const kKMFileHost                         = @"http://filedownload.ktvme.com:8080/";

#pragma mark - HTTP Parameters
static NSString * const kKMBaseURLDevelopment               = @"sdf";
static NSString * const kKMFileId                           = @"fileid";
static NSString * const kKMImagePicurlhead                  = @"http://filedownload.ktvme.com:8080/FileService/downloadstorefile.do";




//test
static NSString * const kKMHotSongListPath                  = @"http://mobile.ktvme.com:8100/?body=%7B%22cmdid%22%3A%22D332%22%2C%22tid%22%3A%229%22%2C%22supportfullsongdb%22%3A%220%22%2C%22startpos%22%3A%221%22%2C%22requestnum%22%3A%2220%22%7D";
static NSString * const kKMRecommendSongListPath            = @"http://mobile.ktvme.com:8100/?body=%7B%22cmdid%22%3A%22D330%22%7D";
static NSString * const kKMRankingSongListPath              = @"http://mobile.ktvme.com:8100/?body=%7B%22cmdid%22%3A%22D328%22%2C%22supportfullsongdb%22%3A%220%22%2C%22requestnum%22%3A%22-1%22%2C%22startpos%22%3A%221%22%7D";


#endif /* Header_h */
