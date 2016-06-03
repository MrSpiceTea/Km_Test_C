//
//  ZTImagePicker.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/6/1.
//  Copyright © 2016年 OMG. All rights reserved.
//
#import "ZTImagePicker.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/UTCoreTypes.h>
#define kMaxSelectedCount 9


@interface ZTImagePicker ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ZTImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择图片";
    [self loadImages];
    
    UIButton *pickerlistButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    [pickerlistButton setTitle:@"选择相册" forState:UIControlStateNormal];
    [pickerlistButton addTarget:self action:@selector(pickerlistButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBI = [[UIBarButtonItem alloc]initWithCustomView:pickerlistButton];
    self.navigationItem.leftBarButtonItem = leftBI;
    
    UIButton *cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [cancleButton setTitle:@"完成" forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBI = [[UIBarButtonItem alloc]initWithCustomView:cancleButton];
    self.navigationItem.rightBarButtonItem = rightBI;
    
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

#pragma mark - Helper
- (void)loadImages{
    [_ztAssets removeAllObjects];
    @autoreleasepool {
        [self.ztAssets removeAllObjects];
        [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result == nil) {
                return;
            }
            [self.ztAssets addObject:result];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            // scroll to bottom

        });
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)ztAssets{
    if (!_ztAssets) {
        _ztAssets = [NSMutableArray array];
    }
    return _ztAssets;
}

- (NSMutableArray *)imagesFromAssets:(NSMutableArray *)assests{
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    for(ALAsset *asset in assests) {
        id obj = [asset valueForProperty:ALAssetPropertyType];
        if (!obj) {
            continue;
        }
        NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
        CLLocation* wgs84Location = [asset valueForProperty:ALAssetPropertyLocation];
        if (wgs84Location) {
            [workingDictionary setObject:wgs84Location forKey:ALAssetPropertyLocation];
        }
        [workingDictionary setObject:obj forKey:UIImagePickerControllerMediaType];
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        if(assetRep != nil) {
            CGImageRef imgRef = nil;
            //defaultRepresentation returns image as it appears in photo picker, rotated and sized,
            //so use UIImageOrientationUp when creating our image below.
            UIImageOrientation orientation = UIImageOrientationUp;
            BOOL origina;
            if (origina) {
                imgRef = [assetRep fullResolutionImage];
//                                    orientation = [assetRep orientation];
            } else {
                imgRef = [assetRep fullScreenImage];
            }
            UIImage *img = [UIImage imageWithCGImage:imgRef
                                               scale:1.0f
                                         orientation:orientation];
            [workingDictionary setObject:[UIImage imageWithCGImage: asset.thumbnail] forKey:@"thumnail"];
            [workingDictionary setObject:img forKey:UIImagePickerControllerOriginalImage];
            
            [workingDictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:UIImagePickerControllerReferenceURL];
            [returnArray addObject:workingDictionary];
        }
    }
    return returnArray;
}

#pragma mark - TargetActon
- (void)cancleButtonAction:(UIButton *)btn{
    //TODO: 修改反回方式
    NSMutableArray *images = [self imagesFromAssets:self.selectedPhotos];
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:images
                                                         forKey:kZTImagePickerSelectedPhotosCompletionNotificationDicKey];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kZTImagePickerSelectedPhotosCompletionNotification
         object:nil
         userInfo:dataDict];
    }];
}

- (void)pickerlistButtonAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ztAssets.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZTImagePickerItem *itemcell = [collectionView dequeueReusableCellWithReuseIdentifier:ZTImagePickerItemID forIndexPath:indexPath];
    itemcell.assets = self.ztAssets[indexPath.row];
    __weak ZTImagePicker *weakSelf = self;
    __weak typeof(itemcell) weakCell = itemcell;//__weak ZTImagePickerItem *weakCell = itemcell;
    itemcell.selectedBlock = ^(BOOL selected){
        if (selected) {
            if (weakSelf.selectedPhotos.count == kMaxSelectedCount) {
                //show alert
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"最多只能添加9张照片" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                weakCell.selectButton.selected = NO;
                return ;
            }
            [weakSelf.selectedPhotos addObject:self.ztAssets[indexPath.row]];
            [weakCell startSelectedAnimation];
        }else{
            [weakSelf.selectedPhotos removeObject:self.ztAssets[indexPath.row]];
        }
    };
    //TODO: previewer
    return itemcell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(3, 3, 0, 3);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kZTImagePickerItemCell_Height, kZTImagePickerItemCell_Height);
}

#pragma mark - Getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[ZTImagePickerItem class] forCellWithReuseIdentifier:ZTImagePickerItemID];
    }
    return _collectionView;
}

- (NSMutableArray *)selectedPhotos{
    if (!_selectedPhotos) {
        _selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}

#pragma mark - AssetHelper

@end
