//
//  NSDictionary+Utilities.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/9.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "NSDictionary+Utilities.h"

@implementation NSDictionary (Utilities)
- (instancetype)valueButNotNullForKey:(NSString *)key {
    id candidate = [self valueForKey:key];
    
    if ([candidate isKindOfClass:[NSNull class]]) {
        return nil;
    } else {
        return candidate;
    }
}

- (NSString *)stringValueForKey:(NSString *)key {
    id candidate = [self valueButNotNullForKey:key];
    
    if (candidate) {
        if ([candidate isKindOfClass:[NSString class]]) {
            return candidate;
        } else {
            return [NSString stringWithFormat:@"%@", candidate];
        }
    } else {
        return nil;
    }
}

- (NSString *)stringValueForCandidateKeys:(NSArray *)keys {
    return [self stringValueForCandidateKeys:keys hasPrefix:nil];
}

- (NSString *)stringValueForCandidateKeys:(NSArray *)keys hasPrefix:(NSString *)prefix {
    if (keys.count == 0) {
        return nil;
    }
    
    NSString *txt = nil;
    for (NSString *key in keys) {
        NSString *candidateTxt = [self stringValueForKey:key];
        
        if (candidateTxt.length > 0) {
            if (prefix) {
                if ([candidateTxt hasPrefix:prefix]) {
                    txt = candidateTxt;
                    break;
                }
            } else {
                txt = candidateTxt;
                break;
            }
        }
    }
    
    return txt;
}
@end
