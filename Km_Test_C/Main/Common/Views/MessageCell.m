//
//  MessageCell.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/13.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "MessageCell.h"


@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.senderTextButton.titleLabel.numberOfLines = 0;
    self.receiverTextButton.titleLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessageModel:(MessageModel *)messageModel{
    _messageModel = messageModel;
    if (messageModel.isHideTime) {
        self.timeLabel.hidden = YES;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    }else{
        self.timeLabel.hidden = NO;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
        }];
    }
    
    [self setMessageWith:messageModel.message type:messageModel.messageType];
   
}

- (void)setMessageWith:(NSString *)message type:(MessageModelType )type{
    if (type == MessageModelTypeReceiver) {
        [self setShowBtn:self.receiverTextButton WithShowImage:self.receiverImageView WithHideBtn:self.senderTextButton WithHideImage:self.senderImageView];
    }else if(type== MessageModelTypeSender){
        [self setShowBtn:self.senderTextButton WithShowImage:self.senderImageView WithHideBtn:self.receiverTextButton WithHideImage:self.receiverImageView];
    }
}

- (void)setShowBtn:(UIButton *)showBtn WithShowImage:(UIImageView *)showImage WithHideBtn:(UIButton *)hideBtn WithHideImage:(UIImageView *)hideImage{
    [showBtn setTitle:_messageModel.message forState:UIControlStateNormal];
    [self layoutIfNeeded];
    NSLog(@"%f,%@",showBtn.titleLabel.frame.size.height,showBtn.titleLabel.text);
    showBtn.hidden = NO;
    showImage.hidden = NO;
    
    hideBtn.hidden = YES;
    hideImage.hidden = YES;
 
    [showBtn mas_updateConstraints :^( MASConstraintMaker *make) {
        CGFloat buttonH = showBtn.titleLabel.frame.size.height;
        make.height.mas_equalTo(buttonH + 30);
    }];
    
    [self layoutIfNeeded];
     UIEdgeInsets edge = UIEdgeInsetsMake(15, 10, 15, 15);
    if (_messageModel.messageType == MessageModelTypeReceiver) {
        edge = UIEdgeInsetsMake(15, 15, 15, 10);
    }
    
    [showBtn setTitleEdgeInsets:edge];
    CGFloat btnMaxY = CGRectGetMaxY (showBtn.frame);
    CGFloat imageMaxY = CGRectGetMaxY (showImage.frame);
    self.messageModel.cellHeight = MAX (btnMaxY, imageMaxY);
}

+ (CGFloat)detailTextHeight:(NSString *)text width:(CGFloat )width {
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]} context:nil];
    return rectToFit.size.height;
}

+ (MessageCell *)cellWithTableView :(UITableView *)tableView{
    static  NSString *messageCell= @"MessageCell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCell];
    cell.backgroundColor = [UIColor clearColor];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:messageCell owner:nil options:nil] firstObject];
        cell.senderTextButton.titleLabel.numberOfLines = 0 ;
        cell.receiverTextButton.titleLabel.numberOfLines=0 ;
    }
    return cell;
}


@end
