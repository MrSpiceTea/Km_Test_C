//
//  SegmentedView.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/9.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedView : UIView
@property (nonatomic,strong) UIView *separatorLineView;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,assign) NSUInteger selectIndex;
@property (nonatomic,assign) NSUInteger total;
@property (nonatomic,assign) CGFloat separatorViewWidth;

- (instancetype)initWithTitles:(NSArray *)titles;
- (void)setupTitlesView:(NSArray *)array;
- (void)selectBolck:(void (^)(NSUInteger selectIndex))block;

//TODO: customView
@end
