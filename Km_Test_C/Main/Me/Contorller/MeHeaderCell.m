//
//  MeHeaderCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/25.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "MeHeaderCell.h"

@implementation MeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        BOOL islogin = 0;
        if (islogin) {
            UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reg_set_headimage"]];
            iconView.layer.masksToBounds = YES;
            //        iconView.layer.cornerRadius = 60;
            [self.contentView addSubview:iconView];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            [titleLabel setBackgroundColor:[UIColor clearColor]];
            [titleLabel setText:@"你还没有登陆"];
            [titleLabel setFont:[UIFont systemFontOfSize:18]];
            [titleLabel setTextColor:RGB(2, 2, 2)];
            [self.contentView addSubview:titleLabel];
            UIImageView *loginView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_login_n"]];
            [self.contentView addSubview:loginView];
            
            [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(70, 70));
                make.centerY.equalTo(iconView.superview);
                make.left.equalTo(iconView.superview.mas_left).with.offset(15);
            }];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(150, 40));
                make.top.equalTo(titleLabel.superview.mas_top).with.offset(15);;
                make.left.equalTo(iconView.mas_right).with.offset(15);
            }];
            [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(80, 25));
                make.top.equalTo(titleLabel.mas_bottom).with.offset(0);;
                make.left.equalTo(iconView.mas_right).with.offset(15);
            }];
        }else{
            
        }


    }
    return self;
}
@end
