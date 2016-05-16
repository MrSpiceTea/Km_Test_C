//
//  ChooseSongGirdView.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/16.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChooseSongGirdView.h"
CGFloat kGirdViewHeight = 480.0f;
@implementation GridView
- (instancetype)init{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    CGFloat gridViewHeight = 130;
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 20, 0));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).with.offset(5);
        make.width.mas_offset(gridViewHeight);
        make.left.equalTo(self.titleLabel.superview.mas_left).with.offset(5);
    }];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 8;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
@end


@implementation ChooseSongGirdView

- (instancetype)init{
    if (self = [super init]) {
        [self setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kGirdViewHeight - 30)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setupViews:(NSUInteger)count{
    self.backgroundColor = [UIColor whiteColor];
    if (kDevice_Is_iPhone6Plus) {
        kGirdViewHeight = 520;
    }
    CGFloat gridViewHeight = 130;
    int intes = 10;
    int num = 3;
    if(kDevice_Is_iPhone6Plus){
        gridViewHeight = 150;
        intes = 12;
    }
    
    __block UIView *lastView = nil;
    for (int i = 0; i < count; i++) {
        UIView *view ;
        if (self.fetchViewAtTag) {
            view = self.fetchViewAtTag(i);
        }else{
            view = [UIView new];
        }
        [view setTag:i];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)];
        [view addGestureRecognizer:singleTap];

        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(gridViewHeight);
            if (lastView) {
                make.width.equalTo(lastView);
            } else {
                if (i % num != 0) {
                    make.width.mas_equalTo((view.superview.frame.size.width - (num + 1)* intes)/4);
                }
            }
            // 2. 判断是否是第一列
            if (i % num == 0) {
                // 一：是第一列时 添加左侧与父视图左侧约束
                make.left.mas_equalTo(view.superview).offset(intes);
            } else {
                // 二： 不是第一列时 添加左侧与上个view左侧约束
                make.left.mas_equalTo(lastView.mas_right).offset(intes);
            }
            // 3. 判断是否是最后一列 给最后一列添加与父视图右边约束
            if (i % num == (num - 1)) {
                make.right.mas_equalTo(view.superview).offset(-intes);
            }
            // 4. 判断是否为第一列
            if (i / num == 0) {
                // 第一列添加顶部约束
                make.top.mas_equalTo(view.superview).offset(intes);
            } else {
                // 其余添加顶部约束 intes*10 是我留出的距顶部高度
                make.top.mas_equalTo(intes + ( i / num )* (100 + intes*5));
            }
            
        }];
        // 每次循环结束 此次的View为下次约束的基准
        lastView = view;
    }
}

- (void)setGridViewCount:(NSUInteger)gridViewCount{
    _gridViewCount = gridViewCount;
    [self setupViews:gridViewCount];
}

- (void)viewTapAction:(UITapGestureRecognizer *)tap{
    if (self.viewTapBlock) {
        self.viewTapBlock(tap.view.tag);
    }
}

@end

