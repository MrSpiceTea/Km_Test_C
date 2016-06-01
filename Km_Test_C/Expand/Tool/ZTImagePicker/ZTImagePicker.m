//
//  ZTImagePicker.m
//  Km_Test_C
//
//  Created by 谢展图 on 16/6/1.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "ZTImagePicker.h"
#import "ZTImagePickerItem.h"
@interface ZTImagePicker ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ZTImagePicker

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择图片";
    [self loadImages];
    
    UIButton *pickerlistButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
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
            NSLog(@"%@",result);
            
        }];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            // scroll to bottom

        });
    }

//    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
//    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        NSLog(@"%@",group);
//    } failureBlock:^(NSError *error) {
//        
//    }];
//

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

#pragma mark - TargetActon
- (void)cancleButtonAction:(UIButton *)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickerlistButtonAction:(UIButton *)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ztAssets.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZTImagePickerItem *itemcell = [collectionView dequeueReusableCellWithReuseIdentifier:ZTImagePickerItemID forIndexPath:indexPath];
    itemcell.backgroundColor = [UIColor brownColor];
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
        _collectionView.backgroundColor = [UIColor redColor];
        [_collectionView registerClass:[ZTImagePickerItem class] forCellWithReuseIdentifier:ZTImagePickerItemID];
    }
    return _collectionView;
}
@end
