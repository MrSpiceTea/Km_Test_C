//
//  FirendCircleIssueViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/8.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FirendCircleIssueViewController.h"
#import "FriendCircleModel.h"

#import "UIImage+expanded.h"

@interface FirendCircleIssueViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UILabel *textLegnthLabel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIActionSheet *actionSheet;
@end

@implementation FirendCircleIssueViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布动态";
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,
                                                    YES)[0]);
    [self setupUI];
}

- (void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.tableView.tableHeaderView = [self textView];
    self.view.backgroundColor = RGB(246, 246, 246);
    UIButton *navLeftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [navLeftButton setTitle:@"取消" forState:UIControlStateNormal];
    [navLeftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [navLeftButton setTag:101];
    [navLeftButton addTarget:self action:@selector(barButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    UIButton *navRightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [navRightButton setTitle:@"发布" forState:UIControlStateNormal];
    [navRightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [navRightButton setTag:102];
    [navRightButton addTarget:self action:@selector(barButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:navRightButton];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
}

#pragma mark - TableViewDelegate
static const CGFloat kTextViewHeight = 80.0f;
static const CGFloat kActionViewHeight = 90.0f;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return kTextViewHeight;
    }else if(indexPath.row == 1){
        return 30;
    }else{
        return kActionViewHeight;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row == 0) {
        [cell.contentView addSubview:[self textView]];
    }else if (indexPath.row == 1){
        [cell.contentView addSubview:self.textLegnthLabel];
    }else if(indexPath.row == 2){
        [cell.contentView addSubview:[self actionView]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //得到图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //图片存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == _actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex)
    {
        case 0:
            [self LocalPhoto];
            break;
            
        case 1:
            [self takePhoto];
            break;
    }
}

#pragma mark - pravite method
//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        
//        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
//            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//        }
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.title = @"选择照片";
    [picker.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)showActionSheet{
    _actionSheet = [[UIActionSheet alloc]
                    initWithTitle:nil
                    delegate:self
                    cancelButtonTitle:@"取消"
                    destructiveButtonTitle:nil
                    otherButtonTitles: @"从手机相册获取", @"打开照相机",nil];
    
    [_actionSheet showInView:self.view];
}

- (UIView *)actionView{
    CGFloat leadtailSpacing = 16.0f;
    CGFloat viewSpacing = 12.0f;
    CGFloat buttonWidth = (kSCREEN_WIDTH - leadtailSpacing*2 - viewSpacing*3)/4;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kActionViewHeight)];
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i<4; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonWidth, buttonWidth)];
        [button setTag:i+1000];
        [button setImage:[UIImage imageNamed:@"quanzi_publishfeed_addimage_icon"] forState:UIControlStateNormal];
        [button setTitle:@"照片" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        button.imageEdgeInsets = UIEdgeInsetsMake(-15, 15, 15, -15);
        button.titleEdgeInsets = UIEdgeInsetsMake(15, -15, -15, 15);
        button.backgroundColor = RGB(230, 230, 230);
        button.layer.cornerRadius = 10;
        [button addTarget:self action:@selector(actionViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button];
        [array addObject:button];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:viewSpacing leadSpacing:leadtailSpacing tailSpacing:leadtailSpacing];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.height.mas_offset(buttonWidth);
    }];
    return backView;
}

#pragma mark - TargetAction
- (void)barButtonAction:(UIButton *)button{
    if (button.tag == 101) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(button.tag == 102){
        if (self.textView.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"无内容" message:@"请输入需要发布的内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"userName"] = @"测试名字";
        dic[@"location"] = @"阿拉伯";
        dic[@"text"] = self.textView.text;
        dic[@"distan"] = @"300km";
        dic[@"createdAt"] = @"公元前";
        dic[@"profileImageUrl"] = @"张学友";
        dic[@"images"] = nil;
        
        NSMutableArray *plistarray  = [NSMutableArray arrayWithContentsOfFile:kFriendCircleListPath];
        [plistarray insertObject:dic atIndex:0];
        [plistarray writeToFile:kFriendCircleListPath atomically:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)actionViewAction:(UIButton *)button{
    switch (button.tag) {
        case 1000:
            [self showActionSheet];
            break;
            
        default:
            break;
    }
}
#pragma mark - get/set
- (UILabel *)textLegnthLabel{
    if (!_textLegnthLabel) {
        _textLegnthLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH - 50, 5, 50, 20)];
        [_textLegnthLabel setText:@"0/200"];
        [_textLegnthLabel setFont:[UIFont systemFontOfSize:14]];
        [_textLegnthLabel setTextColor:RGB(140, 140, 140)];
    }
    return _textLegnthLabel;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kTextViewHeight -5)];
        [_textView setFont:[UIFont systemFontOfSize:16]];
        
    }
    return _textView;
}

@end
