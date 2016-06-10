//
//  ImageScrollView.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/27.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageSelectedBlock)(NSUInteger index);

@interface ImageScrollView : UIView
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,assign) NSUInteger currentIndex;
@property (nonatomic,assign) NSTimeInterval delay;
@property (nonatomic,weak) ImageSelectedBlock imageSelectedBlock;
@end
