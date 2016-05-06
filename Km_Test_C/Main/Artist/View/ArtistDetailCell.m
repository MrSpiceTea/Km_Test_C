//
//  ArtistDetailCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ArtistDetailCell.h"

@implementation ArtistDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title Fans:(NSString *)fans{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"head"]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];}
    UILabel *titlelabel = [UILabel new];
    [titlelabel setFont:[UIFont systemFontOfSize:18]];
    [titlelabel setText:title];
    [self.contentView addSubview:titlelabel];
    
    UILabel *fanslabel = [UILabel new];
    [fanslabel setFont:[UIFont systemFontOfSize:12]];
    [fanslabel setText:@"粉丝:"];
    [self.contentView addSubview:fanslabel];
    
    UILabel *fansNumlabel = [UILabel new];
    [fansNumlabel setFont:[UIFont systemFontOfSize:12]];
    [fansNumlabel setText:fans];
    [self.contentView addSubview:fansNumlabel];
    
    UIView *bottomSeparator = [UIView new];
    bottomSeparator.backgroundColor = RGB(235, 235, 235);
    [self.contentView addSubview:bottomSeparator];
    
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(5, 15, 20, 0));
    }];
    
    [fanslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titlelabel);
        make.top.equalTo(titlelabel.mas_bottom).mas_offset(0);
    }];
    
    [fansNumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fanslabel.mas_right).with.offset(5);
        make.height.equalTo(@15);
        make.top.equalTo(fanslabel);
    }];
    
    [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomSeparator.superview.mas_left).with.offset(0);
        make.bottom.equalTo(bottomSeparator.superview.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH, 1));
    }];
    return self;
}
@end
