//
//  AlbumListCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "AlbumListCell.h"
#import <UIImageView+WebCache.h>
@implementation AlbumListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        self.layer.masksToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.isOpenMenu = NO;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setTextColor:RGB(2, 2, 2)];
        [self.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        [detailLabel setFont:[UIFont systemFontOfSize:12]];
        [detailLabel setTextColor:kCommonCellDetailTextLabelColor];
        [self.contentView addSubview:detailLabel];
        
        UIButton *button = [UIButton new];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button.titleLabel setTextColor:[UIColor blackColor]];
        [button setImage:[UIImage imageNamed:@"wan_picksong_icon_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wan_picksong_icon_hl"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:button];
        
        UILabel *numLabel = [[UILabel alloc] init];
        [numLabel setBackgroundColor:[UIColor clearColor]];
        [numLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [numLabel setTextColor:kCommonCellDetailTextLabelColor];
        [numLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:numLabel];
        
        UIView *bottomSeparator = [UIView new];
        bottomSeparator.backgroundColor = kCommonTableViewCellBottomSeparatorBavkgroundColor;
        [self.contentView addSubview:bottomSeparator];
        

        [self.contentView addSubview:self.menuView];
        
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.equalTo(numLabel.superview.mas_left).with.offset(10);
//            make.centerY.equalTo(numLabel.superview);
            make.centerY.equalTo(detailLabel.mas_top);
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
            make.centerY.equalTo(titleLabel.mas_bottom);
            make.right.equalTo(button.superview.mas_right).with.offset(-15);
        }];
        
        [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(numLabel.mas_right).with.offset(10);
            make.top.equalTo(detailLabel.mas_bottom).with.offset(9);
            make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH, 1));
        }];
        
        [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.menuView.superview.mas_left).with.offset(0);
            make.top.equalTo(bottomSeparator.mas_bottom).with.offset(-1);
            make.right.equalTo(self.menuView.superview.mas_right).with.offset(0);
            make.height.mas_offset(@40);
        }];
        
        self.titleLabel = titleLabel;
        self.detailLabel = detailLabel;
        self.numLabel = numLabel;
    }
     return self;
}

- (UIView *)menuView{
    if (!_menuView) {
        _menuView = [UIView new];
        [_menuView.layer setBorderColor:[kCommonTableViewCellBottomSeparatorBavkgroundColor CGColor]];
        [_menuView.layer setBorderWidth:1];
        [_menuView setBackgroundColor:kCommonTableViewSeparatorBavkgroundColor];
        NSMutableArray *buttonArray = [NSMutableArray array];
        for (int i =1; i<4; i++) {
            UIButton *button = [UIButton new];
            [button setTag:i];
            [button.layer setBorderColor:[kCommonTableViewCellBottomSeparatorBavkgroundColor CGColor]];
            [button.layer setBorderWidth:1];
            [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:@"标题" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_menuView addSubview:button];
            [buttonArray addObject:button];
        }
        
//        UIButton *(^creatButton)() = ^(NSString *title,NSUInteger tag,UIImage *image){
//            UIButton *button;
//            return button;
//        };
//        
        
        [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:30 tailSpacing:30];
        [buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(25);
            make.centerY.equalTo(_menuView);
        }];
    }
    return _menuView;
}

- (void)setAlbumModel:(AlbumModel *)albumModel{
    _albumModel = albumModel;
    self.titleLabel.text = albumModel.albumName;
    self.detailLabel.text = albumModel.artistName;
    self.numLabel.text = albumModel.serialNumber;
}

//- (void)openMenu{
//    if (self.isOpenMenu) {
//        return;
//    }
//}

- (void)buttonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(albumListCell:didSeletedMentItemAtIndex:)]) {
        [self.delegate albumListCell:self didSeletedMentItemAtIndex:button.tag];
    }
}

@end
