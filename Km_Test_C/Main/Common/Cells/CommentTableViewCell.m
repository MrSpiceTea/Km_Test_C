//
//  CommentTableViewCell.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/12.
//  Copyright © 2016年 OMG. All rights reserved.
//
#define kCommentTableViewCellIdentifier @"CommentTableViewCleeIdentifier"
#define kCommentTableViewCell @"CommentTableViewCell"
#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.contentLabel.text = @"大家发；卢卡斯肌肤发；卢卡斯肌肤立刻撒酒发；卢卡斯肌肤立刻撒酒发；卢卡斯肌肤立刻撒酒立刻撒酒疯";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CommentTableViewCell *)cellWithTableView:(UITableView *)tableView{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentTableViewCellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:kCommentTableViewCell owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIImage *image2 = [UIImage imageNamed:@"dynamic_comment_bg_n.9"];
    image2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width*0.5 topCapHeight:image2.size.height*0.5];
    self.messageBackgroundImageView.image = image2;
    self.contentLabel.numberOfLines = 0;
}

- (void)setModel:(FriendCircleCommentModel *)model{
    _model = model;
    self.contentLabel.text = model.content;
    self.headImageView.image = [UIImage imageNamed:model.profileImageUrl];
}
@end
