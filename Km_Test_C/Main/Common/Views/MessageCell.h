//
//  MessageCell.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/13.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *receiverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *senderImageView;
@property (weak, nonatomic) IBOutlet UIButton *senderTextButton;
@property (weak, nonatomic) IBOutlet UIButton *receiverTextButton;
@property (strong,nonatomic) MessageModel *messageModel;

+ (MessageCell *)cellWithTableView :(UITableView *)tableView;

@end
