//
//  FirendCircleIssueViewController.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/5/8.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "FirendCircleIssueViewController.h"
#import "FriendCircleModel.h"
#import "ZTImagePicker.h"
#import "ZTImagePickerAlbumList.h"

#import "UIImage+expanded.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface FirendCircleIssueViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ZTImagePickerDelegate>
@property (nonatomic,strong) UILabel *textLegnthLabel;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIActionSheet *actionSheet;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation FirendCircleIssueViewController

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布动态";
//    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0]);
    [self setupUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imagePickerSelectedPhotosCompletionNotification:) name:kZTImagePickerSelectedPhotosCompletionNotification object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self]; 
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
        if (self.selectedPhotos.count>0) {
//            [cell.contentView addSubview:[self selectedPhotosView]];
            //TODO: FirendCircleIssueImagesCCell selectedPhotos
             cell.imageView.image = [self.selectedPhotos[0] objectForKey:@"thumnail"];
        }else{
            [cell.contentView addSubview:[self actionView]];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){//图片
        //得到图片
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
      
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//视频
        //NSURL *mediatype = [info objectForKey:UIImagePickerControllerMediaType];
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        //创建ALAssetsLibrary对象并将视频保存到媒体库
        // Assets Library 框架包是提供了在应用程序中操作图片和视频的相关功能。相当于一个桥梁，链接了应用程序和多媒体文件。
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        // 将视频保存到相册中
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL
                                          completionBlock:^(NSURL *assetURL, NSError *error) {
                                              if (!error) {
                                                  NSLog(@"captured video saved with no error.");
                                              }else{
                                                  NSLog(@"error occured while saving the video:%@", error);
                                              }
                                          }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Pravite method
//开始拍照
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
//        // 设置录制视频的质量
//        [picker setVideoQuality:UIImagePickerControllerQualityTypeHigh];
//        //设置最长摄像时间
//        [picker setVideoMaximumDuration:10.f];
        
//        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
//            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//        }
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"Camera is not available");
    }
}

//录像
- (void)a{
    
}

//打开本地相册
- (void)LocalPhoto
{

    //  8.0
//    if ([PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusAuthorized) {
//        UIAlertView * photoLibaryNotice = [[UIAlertView alloc]initWithTitle:@"应用程序无访问照片权限" message:@"请在“设置\"-\"隐私\"-\"照片”中设置允许访问" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"设置", nil];
//        [photoLibaryNotice show];
//        return;
//    }

//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.title = @"选择照片";
//    [picker.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    picker.delegate = self;
//    //设置选择后的图片可被编辑
//    picker.allowsEditing = NO;
//    [self presentViewController:picker animated:YES completion:nil];

    NSString *tipTextWhenNoPhotosAuthorization; // 提示语
    // 获取当前应用对照片的访问授权状态
    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
    // 如果没有获取访问授权，或者访问授权状态已经被明确禁止，则显示提示语，引导用户开启授权
    if (authorizationStatus == ALAuthorizationStatusRestricted || authorizationStatus == ALAuthorizationStatusDenied) {
        NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
        tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appName];
        // 展示提示语
        UIAlertView * photoLibaryNotice = [[UIAlertView alloc]initWithTitle:@"应用程序无访问照片权限" message:tipTextWhenNoPhotosAuthorization delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"设置", nil];
        [photoLibaryNotice show];

        return;
    }

    ZTImagePickerAlbumList *albumList = [[ZTImagePickerAlbumList alloc]init];
    UINavigationController *imagePickerNav = [[UINavigationController alloc]initWithRootViewController:albumList];
    [self presentViewController:imagePickerNav animated:YES completion:nil];

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

- (UIView *)selectedPhotosView{
    return nil;
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
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)barButtonAction:(UIButton *)button{
    if (button.tag == 101) {
         [self dismissSelf];
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
        dic[@"profileImageUrl"] = @"zhangxueyou";
        dic[@"images"] = nil;
        
        NSMutableArray *plistarray  = [NSMutableArray arrayWithContentsOfFile:kFriendCircleListPath];
        [plistarray insertObject:dic atIndex:0];
        [plistarray writeToFile:kFriendCircleListPath atomically:YES];
        
        [self.delegate sendIssue:self.textView.text];
        [self dismissSelf];
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

- (void)fetchImagesWithImagePiceker:(NSMutableArray *)images{
    NSLog(@"test%ld",images.count);
}

#pragma mark - Notification
- (void)imagePickerSelectedPhotosCompletionNotification:(NSNotification *)ntf{
    NSMutableArray *images = [[ntf userInfo] objectForKey:kZTImagePickerSelectedPhotosCompletionNotificationDicKey];
    if (images&&images.count>0) {
        self.selectedPhotos = images;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - Getter
//- (UICollectionView *)collectionView{
//    if (!_collectionView) {
//        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) collectionViewLayout:layout];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        _collectionView.alwaysBounceVertical = YES;
//        _collectionView.backgroundColor = [UIColor clearColor];
//        [_collectionView registerClass:[ZTImagePickerItem class] forCellWithReuseIdentifier:ZTImagePickerItemID];
//    }
//    return _collectionView;
//}

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
