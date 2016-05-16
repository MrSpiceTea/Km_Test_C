//
//  ChooseSongCell.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/4/24.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChooseSongCell.h"
#import "ChooseSongGirdView.h"
static NSString *chooseSongSerachCellIdentifier = @"chooseSongSerachCell";
static NSString *chooseSongTopGridCellIdentifier = @"chooseSongTopGridCell";
static NSString *chooseSongTitleCellIdentifier = @"chooseSongTitleCell";
static NSString *chooseSongHotCellIdentifier = @"chooseSongHotCell";
static NSString *chooseSongBottomGirdCellIdentifier = @"chooseSongBottomGirdCell";
//CGFloat kGirdViewHeight = 480.0f;
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

+ (instancetype)cellWithTopGridView:(UITableView *)tableView{
    ChooseSongCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseSongHotCellIdentifier];
    if (cell == nil) {
        cell = [[ChooseSongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseSongHotCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView addSubview:[cell chooseSongTopGridView]];
    }
    return cell;
}

- (instancetype)initWithCustomView:(UIView *)customView tableView:(UITableView *)tableView{
    ChooseSongCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseSongBottomGirdCellIdentifier];
    if (cell == nil) {
        cell = [[ChooseSongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseSongBottomGirdCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.contentView addSubview:customView];
        cell.contentView.backgroundColor = RGB(240, 240, 240);
    }
    return cell;
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

+ (instancetype)cellWithBottomGirdView:(UITableView *)tableView{
    ChooseSongCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseSongBottomGirdCellIdentifier];
    if (cell == nil) {
        cell = [[ChooseSongCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseSongBottomGirdCellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        [cell.contentView addSubview:[cell chooseSongBottomGirdView]];
        cell.contentView.backgroundColor = RGB(240, 240, 240);
    }
    return cell;
}


+ (CGFloat)heightWithTopGridView{
    return kSCREEN_WIDTH/2;
}

+ (CGFloat)heightWithSerachView{
    return 60.0f;
}

+ (CGFloat)heightWithGirdView{
    CGFloat GirdViewHeight = 480;
    if (kDevice_Is_iPhone6Plus) {
        GirdViewHeight = 520.0f;
    }
    return GirdViewHeight;
}

+ (CGFloat)heightWithCell{
    return 60.0f;
}

+ (CGFloat)heightWithhead{
    return 50.0f;
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

- (UIView *)chooseSongBottomGirdView{
    ChooseSongGirdView *gird = [[ChooseSongGirdView alloc]init];
    return gird;
}

//- (UIView *)chooseSongBottomGirdView{
//    if (kDevice_Is_iPhone6Plus) {
//        kGirdViewHeight = 520;
//    }
//    CGFloat gridViewHeight = 130;
//    int intes = 10;
//    int num = 3;
//    if(kDevice_Is_iPhone6Plus){
//        gridViewHeight = 150;
//        intes = 12;
//    }
//    __block UIView *lastView = nil;
//    UIView *nineButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kGirdViewHeight - 30)];
//    nineButtonView.backgroundColor = [UIColor whiteColor];
//    for (int i = 0; i < 9; i++) {
//        UIView *view = [UIView new];
//        [view setTag:i];
//        
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nineViewTapAction:)];
//        [view addGestureRecognizer:singleTap];
//
//        [nineButtonView addSubview:view];
//        UIImageView *icon= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhuanjitest"]];
//        icon.layer.masksToBounds = YES;
//        icon.layer.cornerRadius = 8;
//        UILabel *iconLabel = [[UILabel alloc]init];
//        
//        iconLabel.text = @"好声音第一季";
//        iconLabel.font = [UIFont systemFontOfSize:14];
//        iconLabel.textColor = [UIColor blackColor];
//        [view addSubview:icon];
//        [view addSubview:iconLabel];
//        
//        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(0, 0, 20, 0));
//        }];
//        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(icon.mas_bottom).with.offset(5);
//            make.width.mas_offset(gridViewHeight);
//            make.left.equalTo(iconLabel.superview.mas_left).with.offset(5);
//        }];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(gridViewHeight);
//            if (lastView) {
//                make.width.equalTo(lastView);
//            } else {
//                if (i % num != 0) {
//                    make.width.mas_equalTo((view.superview.frame.size.width - (num + 1)* intes)/4);
//                }
//            }
//            // 2. 判断是否是第一列
//            if (i % num == 0) {
//                // 一：是第一列时 添加左侧与父视图左侧约束
//                make.left.mas_equalTo(view.superview).offset(intes);
//            } else {
//                // 二： 不是第一列时 添加左侧与上个view左侧约束
//                make.left.mas_equalTo(lastView.mas_right).offset(intes);
//            }
//            // 3. 判断是否是最后一列 给最后一列添加与父视图右边约束
//            if (i % num == (num - 1)) {
//                make.right.mas_equalTo(view.superview).offset(-intes);
//            }
//            // 4. 判断是否为第一列
//            if (i / num == 0) {
//                // 第一列添加顶部约束
//                make.top.mas_equalTo(view.superview).offset(intes);
//            } else {
//                // 其余添加顶部约束 intes*10 是我留出的距顶部高度
//                make.top.mas_equalTo(intes + ( i / num )* (100 + intes*5));
//            }
//            
//        }];
//        // 每次循环结束 此次的View为下次约束的基准
//        lastView = view;
//    }
//    return nineButtonView;
//}

- (void)topButtonTapAction:(UIButton *)btn{
    if (self.topGridViewTapBlock) {
        self.topGridViewTapBlock(btn.tag);
    }
}

//- (void)nineViewTapAction:(UITapGestureRecognizer *)tap{
//    if (self.bottomGirdViewBlock) {
//        self.bottomGirdViewBlock(tap.view.tag);
//    }
//}

@end
