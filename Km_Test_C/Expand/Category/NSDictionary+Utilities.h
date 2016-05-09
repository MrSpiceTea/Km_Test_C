//
//  NSDictionary+Utilities.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/9.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Utilities)
- (NSString *)stringValueForKey:(NSString *)key;
- (NSString *)stringValueForCandidateKeys:(NSArray *)keys;
- (NSString *)stringValueForCandidateKeys:(NSArray *)keys hasPrefix:(NSString *)prefix;

@end
