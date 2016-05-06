//
//  AlbumListCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "AlbumListCell.h"

@implementation AlbumListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView AlbumModel:(AlbumModel *)albumModel{
    static NSString *identifier = @"AlbumListCell";
    AlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AlbumListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.albumModel = albumModel;
    return cell;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView{
    static NSString *identifier = @"AlbumListCell";
    AlbumListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AlbumListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setTextColor:RGB(2, 2, 2)];
        [self.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        [detailLabel setFont:[UIFont systemFontOfSize:12]];
        [detailLabel setTextColor:RGB(150, 150, 150)];
        [self.contentView addSubview:detailLabel];
        
        UIButton *button = [UIButton new];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button.titleLabel setTextColor:[UIColor blackColor]];
        [button setImage:[UIImage imageNamed:@"wan_picksong_icon_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wan_picksong_icon_hl"] forState:UIControlStateHighlighted];
        //        [button setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        
        UILabel *numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        [numLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [numLabel setTextColor:RGB(150, 150, 150)];
        [numLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:numLabel];
        
        UIView *bottomSeparator = [UIView new];
        bottomSeparator.backgroundColor = RGB(235, 235, 235);
        [self.contentView addSubview:bottomSeparator];
        
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.equalTo(numLabel.superview.mas_left).with.offset(10);
            make.centerY.equalTo(numLabel.superview);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(25);
            make.left.equalTo(numLabel.mas_right).with.offset(10);
            make.top.equalTo(titleLabel.superview.mas_top).with.offset(5);
            make.right.mas_equalTo(button.mas_left).with.offset(-30);
        }];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.left.equalTo(numLabel.mas_right).with.offset(10);
            make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(0);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(65, 25));
            make.centerY.equalTo(button.superview);
            make.right.equalTo(button.superview.mas_right).with.offset(-15);
        }];
        
        [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numLabel.mas_right).with.offset(10);
            make.bottom.equalTo(bottomSeparator.superview.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH, 1));
        }];
        
        self.titleLabel = titleLabel;
        self.detailLabel = detailLabel;
        self.numLabel = numLabel;
    }
     return self;
}

- (instancetype)initWithArtists:(NSArray *)artists reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:title];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setTextColor:RGB(2, 2, 2)];
        [self.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        [detailLabel setFont:[UIFont systemFontOfSize:12]];
        [detailLabel setTextColor:RGB(150, 150, 150)];
        [self.contentView addSubview:detailLabel];
        
        UIButton *button = [UIButton new];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button.titleLabel setTextColor:[UIColor blackColor]];
        [button setImage:[UIImage imageNamed:@"wan_picksong_icon_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wan_picksong_icon_hl"] forState:UIControlStateHighlighted];
        //        [button setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        
        UILabel *numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        [numLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [numLabel setTextColor:RGB(150, 150, 150)];
        [numLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:numLabel];
        
        UIView *bottomSeparator = [UIView new];
        bottomSeparator.backgroundColor = RGB(235, 235, 235);
        [self.contentView addSubview:bottomSeparator];
        
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.equalTo(numLabel.superview.mas_left).with.offset(10);
            make.centerY.equalTo(numLabel.superview);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(25);
            make.left.equalTo(numLabel.mas_right).with.offset(10);
            make.top.equalTo(titleLabel.superview.mas_top).with.offset(5);
            make.right.mas_equalTo(button.mas_left).with.offset(-30);
        }];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.left.equalTo(numLabel.mas_right).with.offset(10);
            make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(0);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(65, 25));
            make.centerY.equalTo(button.superview);
            make.right.equalTo(button.superview.mas_right).with.offset(-15);
        }];
        
        [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numLabel.mas_right).with.offset(10);
            make.bottom.equalTo(bottomSeparator.superview.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH, 1));
        }];
        
        self.titleLabel = titleLabel;
        self.detailLabel = detailLabel;
        self.numLabel = numLabel;
        
    }
    return self;
}

- (void)setAlbumModel:(AlbumModel *)albumModel{
    _albumModel = albumModel;
    self.titleLabel.text = albumModel.albumName;
    self.detailLabel.text = albumModel.artistName;
    self.numLabel.text = albumModel.serialNumber;
}

@end
