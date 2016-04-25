//
//  ArtistDetailViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedControl : UIControl

@property (nonatomic, assign) NSUInteger selectedSegmentIndex;
@property (nonatomic, assign, readonly) NSUInteger numberOfSegments;
@property (nonatomic, assign) CGFloat minSegmentWidth;

- (void)appendTitle:(NSString *)title animated:(BOOL)animated;
- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated;

- (void)removeAllSegments;
- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated;

- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex animated:(BOOL)animated;

@end
