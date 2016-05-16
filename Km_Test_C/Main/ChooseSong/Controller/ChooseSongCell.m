//
//  ChooseSongCell.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChooseSongCell.h"
static NSString *chooseSongSerachCellIdentifier = @"chooseSongSerachCell";
static NSString *chooseSongTopGridCellIdentifier = @"chooseSongTopGridCell";
static NSString *chooseSongTitleCellIdentifier = @"chooseSongTitleCell";
static NSString *chooseSongHotCellIdentifier = @"chooseSongHotCell";
static NSString *chooseSongBottomGirdCellIdentifier = @"chooseSongBottomGirdCell";

@implementation ChooseSongCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView{
    ChooseSongCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseSongTitleCellIdentifier];
    if (cell == nil) {
        cell = [[ChooseSongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseSongTitleCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
        UIView *iconView = [UIView new];
        iconView.backgroundColor = RGB(255, 110, 0);
        iconView.layer.cornerRadius = 3;
        [cell.contentView addSubview:iconView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setTextColor:RGB(2, 2, 2)];
        [cell.contentView addSubview:titleLabel];
        
        UIView *bottomSeparator = [UIView new];
        bottomSeparator.backgroundColor = RGB(235, 235, 235);
        [cell.contentView addSubview:bottomSeparator];
        
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iconView.superview);
            make.left.equalTo(iconView.superview.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(6, 28));
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iconView.superview);
            make.left.equalTo(iconView.mas_right).with.offset(6);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomSeparator.superview.mas_left).with.offset(0);
            make.bottom.equalTo(bottomSeparator.superview.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH, 1));
        }];
        
        cell.titleLabel = titleLabel;
    }
    return cell;
}

+ (instancetype)cellWithHotCell:(UITableView *)tableView{
    ChooseSongCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseSongHotCellIdentifier];
    if (cell == nil) {
        cell = [[ChooseSongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseSongHotCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [titleLabel setTextColor:RGB(2, 2, 2)];
        [cell.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        [detailLabel setBackgroundColor:[UIColor clearColor]];
        [detailLabel setFont:[UIFont systemFontOfSize:12]];
        [detailLabel setTextColor:kCommonCellDetailTextLabelColor];
        [cell.contentView addSubview:detailLabel];
        
        UIButton *button = [UIButton new];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button.titleLabel setTextColor:[UIColor blackColor]];
        [button setImage:[UIImage imageNamed:@"wan_picksong_icon_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"wan_picksong_icon_hl"] forState:UIControlStateHighlighted];
        //        [button setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        [cell.contentView addSubview:button];
        
        UIView *bottomSeparator = [UIView new];
        bottomSeparator.backgroundColor = RGB(235, 235, 235);
        [cell.contentView addSubview:bottomSeparator];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(25);
            make.left.equalTo(titleLabel.superview.mas_left).with.offset(10);
            make.top.equalTo(titleLabel.superview.mas_top).with.offset(5);
            make.right.mas_equalTo(button.mas_left).with.offset(-30);
        }];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.left.mas_offset(10);
            make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(0);
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(65, 25));
            make.centerY.equalTo(button.superview);
            make.right.equalTo(button.superview.mas_right).with.offset(-15);
        }];
        
        [bottomSeparator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomSeparator.superview.mas_left).with.offset(0);
            make.bottom.equalTo(bottomSeparator.superview.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH, 1));
        }];
        
        cell.titleLabel = titleLabel;
        cell.detailLabel = detailLabel;

    }
    return cell;
}


- (instancetype)initWithCustomView:(UIView *)customview reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.contentView addSubview:customview];
    }
    return self;
}

+ (instancetype)cellWithSerachView:(UITableView *)tableView{
    ChooseSongCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseSongSerachCellIdentifier];
    if (cell == nil) {
        cell = [[ChooseSongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseSongSerachCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView addSubview:[cell serachBarView]];
    }
    return cell;
}

+ (CGFloat)heightWithSerachView{
    return 60;
}

#pragma mark - CustomView
- (UIView *)serachBarView{
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(10, 10, kSCREEN_WIDTH - 20, 35)];
    view.backgroundColor = RGB(240, 240, 240);
    view.layer.cornerRadius = 15;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wan_searchview_icon"]];
    UILabel *label = [UILabel new];
    [label setText:@"搜歌"];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setTextColor:RGB(160, 160, 160)];
    
    [view addSubview:imageView];
    [view addSubview:label];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(15, 15));
        make.centerY.equalTo(view);
        make.left.equalTo(view).with.offset(10);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(50, 25));
        make.centerY.equalTo(view);
        make.left.equalTo(imageView.mas_right).with.offset(10);
    }];
    return view;
}

static const CGFloat kTopGridViewMargin = 5.0f;
- (UIView *)chooseSongTopGridView{
    int sidesMargin = 10;
    int leftWidth = kSCREEN_WIDTH/2 - kTopGridViewMargin/2 - sidesMargin;
    int rightWidth = (kSCREEN_WIDTH/2 - kTopGridViewMargin/2 - kTopGridViewMargin -sidesMargin)/2;
    UIView *chooseSongTopGridView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, (leftWidth)+20)];
    UIButton *button1 = [UIButton new];
    UIButton *button2 = [UIButton new];
    UIButton *button3 = [UIButton new];
    UIButton *button4 = [UIButton new];
    
    [button1 setTag:101];
    [button2 setTag:102];
    [button3 setTag:103];
    [button4 setTag:104];
    
    __weak ChooseSongCell *weakSelf = self;
    void (^viewBlock)() = ^(UIButton *btn,NSString *title,NSString *imageName){
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        //        [view setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn addTarget:weakSelf action:@selector(topButtonTapAction:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *iconLabel = [[UILabel alloc]init];
        iconLabel.text = title;
        iconLabel.font = [UIFont systemFontOfSize:16];
        iconLabel.textColor = [UIColor whiteColor];
        [btn addSubview:iconLabel];
        [chooseSongTopGridView addSubview:btn];
        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btn.mas_left).with.offset(kTopGridViewMargin);
            make.bottom.equalTo(btn.mas_bottom).with.offset(-kTopGridViewMargin);
        }];
    };
    
    viewBlock(button1,@"歌手",@"angelababy");
    viewBlock(button2,@"",@"new_wan_picksong_local");
    viewBlock(button3,@"",@"new_wan_picksong_common");
    viewBlock(button4,@"",@"new_wan_picksong_rank");
    
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseSongTopGridView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(leftWidth, leftWidth));
        make.left.equalTo(chooseSongTopGridView).with.offset(sidesMargin);
    }];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseSongTopGridView).with.offset(0);
        make.left.equalTo(button1.mas_right).with.offset(kTopGridViewMargin);
        make.size.mas_equalTo(CGSizeMake(rightWidth, rightWidth));
    }];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(chooseSongTopGridView).with.offset(0);
        make.left.equalTo(button2.mas_right).with.offset(kTopGridViewMargin);
        make.size.mas_equalTo(CGSizeMake(rightWidth, rightWidth));
    }];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(leftWidth, rightWidth));
        make.left.equalTo(button1.mas_right).with.offset(kTopGridViewMargin);
        make.top.equalTo(button2.mas_bottom).with.offset(kTopGridViewMargin);
    }];
    return chooseSongTopGridView;
}

- (void)topButtonTapAction:(UIButton *)btn{
    self.topGridViewTapBlock(btn.tag);
}

@end
