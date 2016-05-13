//
//  ChooseSongHeadView.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChooseSongHeadView.h"

@implementation ChooseSongHeadView
- (instancetype)init{
    if (self == [super init]) {
//        self.backgroundColor = [UIColor clearColor];
        [self setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 300)];
         self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_login_bg"]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"picksonghome_scan_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"picksonghome_scan_hl"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(150, 150));
            make.centerX.equalTo(btn.superview);
            make.bottom.equalTo(btn.superview).with.offset(-40);
        }];
        self.button = btn;
    }
    return self;
}

- (void)btnAction{
    self.btnActionBlock();
}
@end
