//
//  AlbumListCell.h
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/3.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumModel.h"

@protocol AlbumListCellMentViewDelegate;

@interface AlbumListCell : UITableViewCell
@property (weak, nonatomic) id <AlbumListCellMentViewDelegate> delegate;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UILabel *numLabel;
@property (assign, nonatomic) BOOL isOpenMenu;
@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) AlbumModel *albumModel;
@property (strong, nonatomic) NSIndexPath *indexPath;
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@end


@protocol AlbumListCellMentViewDelegate <NSObject>
- (void)albumListCell:(AlbumListCell *)albumListCell didSeletedMentItemAtIndex:(NSInteger)menuItemIndex;
@end
