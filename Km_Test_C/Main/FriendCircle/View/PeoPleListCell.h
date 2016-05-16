//
//  PeoPleListCell.h
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/10.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeoPleListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImagView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
+ (instancetype)cellWidthTable:(UITableView *)tableView;
@end
