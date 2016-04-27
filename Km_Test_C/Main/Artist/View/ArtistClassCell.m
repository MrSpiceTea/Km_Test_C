//
//  ArtistClassCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/27.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistClassCell.h"

@implementation ArtistClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
static const CGFloat kImageMargin = 10;
static const CGFloat kImageWidth = 60;
static const CGFloat kImageCount = 9;
- (instancetype)initWithArtists:(NSArray *)artists reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        CGSize scrollViewContentSize = CGSizeMake(kImageMargin*9+kImageMargin+kImageWidth*9, CGRectGetHeight(self.contentView.bounds));
        self.contentView.backgroundColor =  RGB(246, 246, 246);
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        [scrollView setContentSize:scrollViewContentSize];
        scrollView.userInteractionEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        
         __block UIButton *lastView = nil;
        for (int i = 0; i<kImageCount; i++) {
            UIButton *button = [UIButton new];
            [button setTag:i];
//            button.backgroundColor = [UIColor brownColor];
            [button setBackgroundImage:[UIImage imageNamed:@"jay"] forState:UIControlStateNormal];
            
            UILabel *iconLabel = [[UILabel alloc]init];
            iconLabel.text = @"周杰伦";
            iconLabel.font = [UIFont systemFontOfSize:12];
            iconLabel.textColor = RGB(25, 25, 25);
            iconLabel.textAlignment = NSTextAlignmentCenter;
            
            [scrollView addSubview:button];
            [scrollView addSubview:iconLabel];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kImageWidth, kImageWidth));
                make.top.equalTo(button.superview.mas_top).with.offset(kImageMargin/2);
                if (lastView) {
                    make.left.equalTo(lastView.mas_right).with.offset(kImageMargin);
                }else{
                    make.left.equalTo(button.superview.mas_left).with.offset(kImageMargin);
                }
            }];
            [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kImageWidth, 10));
                make.top.equalTo(button.mas_bottom).with.offset(kImageMargin/2);
                make.centerX.equalTo(button);
            }];
            
            lastView = button;
        
        }
        [self.contentView addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView.superview);
        }];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.contentView.backgroundColor =  RGB(246, 246, 246);
        UIView *iconView = [UIView new];
        iconView.backgroundColor = RGB(255, 110, 0);
        iconView.layer.cornerRadius = 2;
        [self.contentView addSubview:iconView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        [titleLabel setTextColor:RGB(2, 2, 2)];
        [self.contentView addSubview:titleLabel];

        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iconView.superview);
            make.left.equalTo(iconView.superview.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(3, 15));
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iconView.superview);
            make.left.equalTo(iconView.mas_right).with.offset(6);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        self.titleLabel = titleLabel;
        
    }
    return self;
}
//隐藏分割线
- (void)addSubview:(UIView *)view
{
    NSString *className = NSStringFromClass([view class]);
    if (![className isEqualToString:@"UIButton"]&&
        ![className isEqualToString:@"UITableViewCellContentView"]){
        return;
    }
    [super addSubview:view];
}
@end
