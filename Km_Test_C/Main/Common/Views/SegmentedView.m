//
//  SegmentedView.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/9.
//  Copyright © 2016年 OMG. All rights reserved.
//


#import "SegmentedView.h"

#define SegmentedViewSeparatorBackColorNormal       [UIColor orangeColor]
#define SegmentedViewTitleFont                      [UIFont systemFontOfSize:16]
#define SegmentedViewSeparatorAnimateTime           0.2

@interface SegmentedView ()
@property (nonatomic,strong) NSMutableArray *separatorviews;
@property (nonatomic,assign) CGFloat viewWidth;
@property (nonatomic,assign) CGFloat viewHeight;
@end
@implementation SegmentedView

- (instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles{
    if (self = [super init]) {
        if (titles.count <2) {
            
        }
        [self setTitles:titles];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    _total = titles.count;
    _viewWidth = CGRectGetWidth(self.frame)/_total;
    for (int i =0; i<_total; i++) {
        UIButton *button = [UIButton new];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:SegmentedViewSeparatorBackColorNormal forState:UIControlStateHighlighted];
        [button setTitleColor:SegmentedViewSeparatorBackColorNormal forState:UIControlStateSelected];
        [button.titleLabel setFont:SegmentedViewTitleFont];
        [button setTag:i];
        [button addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(i*_viewWidth, 0, _viewWidth, CGRectGetHeight(self.frame) - 5)];
        if (i == 0) {
            [button setSelected:YES];
            self.separatorLineView.frame = CGRectMake(5, CGRectGetHeight(self.frame) - 5, _viewWidth - 10, 3);
            [self addSubview:self.separatorLineView];
        }
        [self.separatorviews addObject:button];
        [self addSubview:button];
    }
}

- (void)setSelectIndex:(NSUInteger)selectIndex{
    
}

- (void)setupTitlesView:(NSArray *)array{

}

- (void)setupUI{
    _selectIndex = 0;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}


- (UIView *)separatorLineView{
    if (!_separatorLineView) {
        _separatorLineView = [UIView new];
        _separatorLineView.backgroundColor  = SegmentedViewSeparatorBackColorNormal;
    }
    
    return _separatorLineView;
}

- (NSMutableArray *)separatorviews{
    if (!_separatorviews) {
        _separatorviews = [NSMutableArray array];
    }
    return _separatorviews;
}

-(void)selectActionMoveTo:(CGFloat )x{
    
    
    [UIView animateWithDuration:SegmentedViewSeparatorAnimateTime animations:^{
        CGPoint center = _separatorLineView.center;
         center.x = x;
        _separatorLineView.center = center;
    }];
}

-(void)separatorLineViewMoveTO:(CGFloat)x{
    
}

#pragma mark - TargetAction
- (void)buttonSelectAction:(UIButton *)button{
    self.selectIndex = button.tag;
    if (button.selected) {
        return;
    }
    for (UIButton * btn in self.separatorviews) {
        if (btn.tag!=button.tag) {
            btn.selected = NO;
        }
    }
    button.selected = YES;
    [self selectActionMoveTo :button.center.x];
    
    selectBolck block = self.selectbolck;
    if (block) {
        block(button.tag);
    }
    //block
}

- (void)viewSelectAction:(UITapGestureRecognizer *)recognizer{
    self.selectIndex = recognizer.view.tag;
    [self selectActionMoveTo :recognizer.view.center.x];
}


@end
