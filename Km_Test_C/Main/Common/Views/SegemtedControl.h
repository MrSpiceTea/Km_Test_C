//
//  SegemtedControl.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/26.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegemtedControl : UIControl

@property (nonatomic,assign) NSUInteger numberOfSegments;
@property (nonatomic, assign) NSUInteger selectedSegmentIndex;

- (void)appendTitle:(NSString *)title animated:(BOOL)animated;
- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated;
- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex animated:(BOOL)animated;
@end
