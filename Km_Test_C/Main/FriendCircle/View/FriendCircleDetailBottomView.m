//
//  FriendCircleDetailBottomView.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/11.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FriendCircleDetailBottomView.h"
static const CGFloat separatorViewWidth = 1.0f;
@implementation FriendCircleDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.topseparatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(CGRectGetWidth(self.frame), 1));
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(0);
    }];
    
    [self.centerseparatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(1, CGRectGetHeight(self.frame)/2));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(_centerseparatorView.mas_left).with.offset(0);
        make.centerY.equalTo(self);
        make.height.mas_offset(CGRectGetHeight(self.frame)-separatorViewWidth);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_centerseparatorView.mas_right).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.centerY.equalTo(self);
        make.height.mas_offset(CGRectGetHeight(self.frame)-separatorViewWidth);
    }];
}

- (UIView *)topseparatorView{
    if (!_topseparatorView) {
        _topseparatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), separatorViewWidth)];
        [_topseparatorView setBackgroundColor:RGB(200, 200, 200)];
        [self addSubview:_topseparatorView];
    }
    return _topseparatorView;
}

- (UIView *)centerseparatorView{
    if (!_centerseparatorView) {
       _centerseparatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, separatorViewWidth, 5)];
        [_centerseparatorView setBackgroundColor:RGB(200, 200, 200)];
        [self addSubview:_centerseparatorView];
    }
    return _centerseparatorView;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton new];
        [_leftButton setTitleColor:kCommonCellDetailTextLabelColor forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [_leftButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_leftButton setTag:0];
        [_leftButton addTarget:self action:@selector(buttonTargetAcion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
         _rightButton = [UIButton new];
        [_rightButton setTitleColor:kCommonCellDetailTextLabelColor forState:UIControlStateNormal];
        [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_rightButton setTag:1];
        [_rightButton addTarget:self action:@selector(buttonTargetAcion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}

- (void)buttonTargetAcion:(UIButton *)button{
    if (self.tapblock) {
        self.tapblock(button);
    }
}
@end
