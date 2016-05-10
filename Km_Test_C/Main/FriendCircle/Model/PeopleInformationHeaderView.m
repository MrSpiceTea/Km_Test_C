//
//  PeopleInformationHeaderView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/10.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "PeopleInformationHeaderView.h"

@implementation PeopleInformationHeaderView

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    UIImageView *backImageView = [[UIImageView alloc]init];
    [self addSubview:backImageView];
    self.backgroundImageView = backImageView;
    
    UIImageView *headImageView = [[UIImageView alloc]init];
    [self addSubview:headImageView];
    self.headImageView = headImageView;
    
    UILabel *nameLabel = [[UILabel alloc]init];
    [nameLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *goldLabel = [[UILabel alloc]init];
    [goldLabel setText:@"金币 0  ｜  经验  0"];
    [self addSubview:goldLabel];
    self.goldLabel = goldLabel;
    
    UILabel *locationLabel = [[UILabel alloc]init];
    [locationLabel setText:@"广东省 － 广州 50米以内 ｜1分钟前"];
    [locationLabel setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.2]];
    [self addSubview:locationLabel];
    self.locationLabel = locationLabel;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
