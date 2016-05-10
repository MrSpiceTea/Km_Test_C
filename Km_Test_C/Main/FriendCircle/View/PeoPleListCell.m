//
//  PeoPleListCell.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/10.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "PeoPleListCell.h"

@implementation PeoPleListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWidthTable:(UITableView *)tableView{
    static NSString *identifer = @"peoplelistCell";
    PeoPleListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PeoPleListCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.levelLabel.layer.cornerRadius = 5;
    self.levelLabel.layer.masksToBounds = YES;
}


@end
