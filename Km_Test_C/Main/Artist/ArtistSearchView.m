//
//  ArtistSearchView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/27.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistSearchView.h"

@implementation ArtistSearchView

- (instancetype)init{
    if (self = [super init]) {
        [self configSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configSubView];
    }
    return self;
}


- (void)configSubView{
        UIView *view = [UIView new];
        view.backgroundColor = RGB(220, 220, 220);
        view.layer.cornerRadius = 5;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_result_key_icon"]];
        UILabel *label = [UILabel new];
        [label setText:@"歌曲，歌星，简拼"];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextColor:RGB(160, 160, 160)];
        
        [self addSubview:view];
        [view addSubview:imageView];
        [view addSubview:label];
    
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(25, 25));
            make.centerY.equalTo(view);
            make.left.equalTo(view).with.offset(10);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(120, 20));
            make.centerY.equalTo(view);
            make.left.equalTo(imageView.mas_right).with.offset(10);
        }];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(kSCREEN_WIDTH - 20, kSearchViewHeight));
            make.center.equalTo(view.superview);
        }];
    }

@end
