//
//  RemoteControlView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "RemoteControlView.h"

@implementation RemoteControlView

- (instancetype)init{
    if (self = [super init]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    [self setFrame:kSCREEN_BOUNDS];
    UIButton *servicesBtn = [[UIButton alloc]init];
    [servicesBtn setImage:[UIImage imageNamed:@"btn_service_normal"] forState:UIControlStateNormal];
    [servicesBtn setImage:[UIImage imageNamed:@"btn_service_hl"] forState:UIControlStateNormal];
    [servicesBtn.imageView setContentMode:UIViewContentModeScaleToFill];
    

    [self addSubview:servicesBtn];
    
    [servicesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 80));
        make.right.equalTo(self.mas_right).with.offset(-50);
        make.top.equalTo(self.mas_top).with.offset(100);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"没有绑定包厢啦，快点去绑定吧"];
    
}

@end
