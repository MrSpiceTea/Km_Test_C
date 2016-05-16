//
//  ChatSessionViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/5/13.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ChatSessionViewController.h"
#import "MessageCell.h"
#import "MessageModel.h"

@interface ChatSessionViewController ()

@end

@implementation ChatSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"客服";
    
    //testdata
    MessageModel *model = [[MessageModel alloc]init];
    model.message = @"阿斯顿发了水电开发";
    model.messageType = MessageModelTypeReceiver;
    
    MessageModel *model2 = [[MessageModel alloc]init];
    model2.message = @"阿斯顿发了水电开发了间发";
    model2.messageType = MessageModelTypeReceiver;
    
    MessageModel *model3 = [[MessageModel alloc]init];
    model3.message = @"阿斯顿发了水电开发少空间发";
    model3.messageType = MessageModelTypeSender;
    
    self.dataSource = [NSMutableArray arrayWithObjects:model,model2,model3, nil];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = kCommonBavkgroundViewColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *model = self.dataSource[indexPath.row];
    return model.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [MessageCell cellWithTableView:tableView];
    [cell setMessageModel:self.dataSource[indexPath.row]];
    cell.receiverImageView.image = [UIImage imageNamed:@"myhome_default_head"];
    cell.senderImageView.image = [UIImage imageNamed:@"myhome_default_head"];
    return cell;
}


@end
