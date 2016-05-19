//
//  FirendCircleDetailViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/6.
//  Copyright © 2016年 OMG. All rights reserved.
//
#import "BaseNavigationController.h"
#import "FirendCircleDetailViewController.h"
#import "FirendCircleCommentViewController.h"
#import "FriendCircleCell.h"
#import "CommentTableViewCell.h"
#import "FriendCircleDetailBottomView.h"

#import "FriendCircleCommentModel.h"
#import "FriendLikeUserCell.h"
#import "UserModel.h"

@interface FirendCircleDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FirendCircleCommentDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *likeUsersView;
@end

@implementation FirendCircleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

#pragma mark Healper
- (void)setupUI{
    self.title  = @"详情";
    [self.navigationController.navigationBar setBarTintColor:RGB(230, 230, 230)];
    UIBarButtonItem *navRightBtn = [[UIBarButtonItem alloc]initWithTitle:@"更多"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(navRightBtnAction:)];
    [navRightBtn setTintColor:RGB(255, 140, 0)];
    self.navigationItem.rightBarButtonItem = navRightBtn;    
    [self.view addSubview:self.tableView];
    
    CGFloat bottomViewHeight = 44.0f;
    FriendCircleDetailBottomView *bottomView = [[FriendCircleDetailBottomView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT- bottomViewHeight, kSCREEN_WIDTH, bottomViewHeight)];
//    bottomView.backgroundColor = [UIColor blueColor];
    [bottomView.leftButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
    [bottomView.leftButton setTitle:@"赞" forState:UIControlStateNormal];
    [bottomView.rightButton setImage:[UIImage imageNamed:@"activity_detail_like"] forState:UIControlStateNormal];
    [bottomView.rightButton setTitle:@"评论" forState:UIControlStateNormal];
    
    __weak FirendCircleDetailViewController *weakSelf = self;
    bottomView.tapblock = ^(UIButton *button){
        if (button.tag == 0) {
            button.selected = !button.selected;
            if (button.selected) {
                UserModel *user = [UserModel shareUser];
                [weakSelf.model.likeArray insertObject:user atIndex:0];
            }else{
                if (weakSelf.model.likeArray.count>0 ) {
                    [weakSelf.model.likeArray removeObjectAtIndex:0];
                }
            }
            [weakSelf.likeUsersView reloadData];
        }else{
            FirendCircleCommentViewController *FirendCircleCommentViewVC = [[FirendCircleCommentViewController alloc]init];
            FirendCircleCommentViewVC.hidesBottomBarWhenPushed = YES;
            BaseNavigationController *FirendCircleCommentViewVCNav = [[BaseNavigationController alloc]initWithRootViewController:FirendCircleCommentViewVC];
            FirendCircleCommentViewVC.delegate = weakSelf;
            [weakSelf.parentViewController presentViewController:FirendCircleCommentViewVCNav animated:YES completion:nil];
        }
    };

    [self.view addSubview:bottomView];
}

- (UIView *)bottomView{
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.model.cellHeight - 40;
    }else{
        if (indexPath.row == 0) {
            return 40;
        }else{
            if (self.model.commentArray.count == 0) {
                return 40;
            }else{
                FriendCircleCommentModel *commentModel = self.model.commentArray[indexPath.row - 1];
                return commentModel.cellHeight;
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (self.model.commentArray.count == 0) {
        return 2;
    }else{
        return 1 + self.model.commentArray.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCircleCell * cell = nil;
    if (indexPath.section == 0) {
        cell = [FriendCircleCell cellWithTabelView:tableView];
        [cell setModel:self.model];
        cell.detailLikeikeButton.hidden = YES;
        cell.detailCmtikeButton.hidden = YES;
    }else{
        cell = [[FriendCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headcell"];
        if (indexPath.row == 0) {
            [cell.contentView addSubview:self.likeUsersView];
        }else{
            if (self.model.commentArray.count == 0) {
                cell.textLabel.text = @"暂无评论，快来抢沙发吧";
                cell.textLabel.textColor = kCommonCellDetailTextLabelColor;
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }else{
                CommentTableViewCell *cell = [CommentTableViewCell cellWithTableView:tableView];
                FriendCircleCommentModel *commentModel = self.model.commentArray[indexPath.row - 1];
                [cell setModel:commentModel];
                return cell;
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//TODO: do in FriendCircleCell
#pragma mark Collection 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.likeArray.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FriendLikeUserCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:kCellWidhCollectionViewIdentifier forIndexPath:indexPath];
    if (indexPath.row==0) {
        [cell.imgView setImage:[UIImage imageNamed:@"nearby_cardcell_praise_count"]];
    }else{
        if (self.model.likeArray.count>=indexPath.row) {
            UserModel *model = self.model.likeArray[indexPath.row - 1];
            [cell setUserModel:model];
        }else{
            [cell setUserModel:nil];
        }
    }

    return cell;
}

static const CGFloat kFriendLikeUserCell_Pading = 40;
static const CGFloat kCellWidhCollectionCellWidth = 10;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
        return kFriendLikeUserCell_Pading;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kFriendLikeUserCell_Pading/2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kCellWidhCollectionCellWidth, kCellWidhCollectionCellWidth);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{}

#pragma mark - FirendCircleCommentDelegate
- (void)textViewtext:(NSString *)text{
    if (text.length>0) {
        FriendCircleCommentModel *commentModel = [[FriendCircleCommentModel alloc]init];
        commentModel.content = text;
        commentModel.profileImageUrl = @"zhangxueyou";
        [self.model.commentArray insertObject:commentModel atIndex:0];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
   }
}

#pragma mark - Getting/Setting
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 39) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UICollectionView *)likeUsersView{
    if (!_likeUsersView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _likeUsersView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, kSCREEN_WIDTH - 15*2, 35) collectionViewLayout:layout];
        _likeUsersView.scrollEnabled = NO;
//        [_likeUsersView setBackgroundView:nil];
        _likeUsersView.backgroundColor = kCommonTableViewBavkgroundColor;
        _likeUsersView.dataSource = self;
        _likeUsersView.delegate = self;
        [_likeUsersView registerClass:[FriendLikeUserCell class] forCellWithReuseIdentifier:kCellWidhCollectionViewIdentifier];
    }
    return _likeUsersView;
}

#pragma mark - Target Action
- (void)navRightBtnAction:(UIButton *)btn{
    
}

@end
