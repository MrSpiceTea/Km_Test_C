//
//  QRCodeViewController.m
//  Km_Test_C
//
//  Created by Mr.Xie on 16/4/28.
//  Copyright © 2016年 OMG. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodeAreaView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+expanded.h"

#define REMINDTEXT @"或输入连接码"
@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    AVCaptureSession * _captureSession;//输入输出的中间桥梁
    QRCodeAreaView *_areaView;//扫描区域视图
}
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic, strong) CAShapeLayer * maskLayer;
@property (nonatomic, strong) CAShapeLayer * shadowLayer;
@property (nonatomic, strong) CAShapeLayer * scanRectLayer;

@property (nonatomic, assign) CGRect scanRect;
@property (nonatomic, strong) UILabel * remind;

@end

@implementation QRCodeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:self.tabBarController];
}
//
//- (void)viewWillDisAppear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self showTabBar:self.tabBarController];
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    [self showTabBar:self.tabBarController];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码扫描";
    [self setupSubViews];
    [self setupCapture];
    [self startRunning];
}

- (void)setupSubViews{
    _areaView = [[QRCodeAreaView alloc]initWithFrame:self.scanRect];
    [self.view addSubview:_areaView];
    [self.view.layer addSublayer: self.scanRectLayer];
    [self.view.layer addSublayer: self.shadowLayer];
//    [self.view.layer addSublayer:self.scanRectLayer];
    [self.view addSubview: self.remind];
}

- (void)setupCapture{
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    _captureSession = [[AVCaptureSession alloc]init];
    //高质量采集率
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_captureSession addInput:input];
    [_captureSession addOutput:output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [self stopReading];
        [_areaView stopAnimaion];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        NSLog(@"%@",metadataObject.stringValue);
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"message" message:metadataObject.stringValue delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self startRunning];
    [_areaView startAnimaion];
}

- (void)startRunning{
    //开始捕获
    [_captureSession startRunning];
}

- (void)stopReading
{
    [_captureSession stopRunning];
}

- (void)dealloc{
    _captureSession = nil;
}

//亮灯
- (void)systemLightSwitch:(BOOL)open
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

#pragma mark >> layer <<
/**
 *  扫描范围
 */
static const CGFloat kScanRectHeight = 250;
- (CGRect)scanRect
{
    if (CGRectEqualToRect(_scanRect, CGRectZero)) {
        CGFloat yOffset = (kSCREEN_HEIGHT - kScanRectHeight)/2;
        CGFloat xOffset = (kSCREEN_WIDTH - kScanRectHeight)/2;
        _scanRect = CGRectMake(xOffset, yOffset, kScanRectHeight, kScanRectHeight);
    }
    return _scanRect;
}
/**
 *  阴影层
 */
- (CAShapeLayer *)shadowLayer
{
    if (!_shadowLayer) {
        _shadowLayer = [CAShapeLayer layer];
        _shadowLayer.path = [UIBezierPath bezierPathWithRect: self.view.bounds].CGPath;
        _shadowLayer.fillColor = [UIColor colorWithWhite: 0 alpha: 0.75].CGColor;
        _shadowLayer.mask = self.maskLayer;
    }
    return _shadowLayer;
}

/**
 *  遮掩层
 */
- (CAShapeLayer *)maskLayer
{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer = [self generateMaskLayerWithRect: kSCREEN_BOUNDS exceptRect: self.scanRect];
    }
    return _maskLayer;
}


#pragma mark - generate
/**
 *  生成空缺部分rect的layer
 */
- (CAShapeLayer *)generateMaskLayerWithRect: (CGRect)rect exceptRect: (CGRect)exceptRect
{
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    if (!CGRectContainsRect(rect, exceptRect)) {
        return nil;
    }
    else if (CGRectEqualToRect(rect, CGRectZero)) {
        maskLayer.path = [UIBezierPath bezierPathWithRect: rect].CGPath;
        return maskLayer;
    }
    
    CGFloat boundsInitX = CGRectGetMinX(rect);
    CGFloat boundsInitY = CGRectGetMinY(rect);
    CGFloat boundsWidth = CGRectGetWidth(rect);
    CGFloat boundsHeight = CGRectGetHeight(rect);
    
    CGFloat minX = CGRectGetMinX(exceptRect);
    CGFloat maxX = CGRectGetMaxX(exceptRect);
    CGFloat minY = CGRectGetMinY(exceptRect);
    CGFloat maxY = CGRectGetMaxY(exceptRect);
    CGFloat width = CGRectGetWidth(exceptRect);
    
    /** 添加路径*/
    UIBezierPath * path = [UIBezierPath bezierPathWithRect: CGRectMake(boundsInitX, boundsInitY, minX, boundsHeight)];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(minX, boundsInitY, width, minY)]];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(maxX, boundsInitY, boundsWidth - maxX, boundsHeight)]];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(minX, maxY, width, boundsHeight - maxY)]];
    maskLayer.path = path.CGPath;
    
    return maskLayer; 
}

/**
 *  扫描框
 */
- (CAShapeLayer *)scanRectLayer
{
    if (!_scanRectLayer) {
        CGRect scanRect = self.scanRect;
        scanRect.origin.x -= 1;
        scanRect.origin.y -= 1;
        scanRect.size.width += 2;
        scanRect.size.height += 2;
        
        _scanRectLayer = [CAShapeLayer layer];
        _scanRectLayer.path = [UIBezierPath bezierPathWithRect: scanRect].CGPath;
        _scanRectLayer.fillColor = [UIColor clearColor].CGColor;
        _scanRectLayer.strokeColor = [UIColor orangeColor].CGColor;
    }
    return _scanRectLayer;
}

- (UILabel *)remind
{
    if (!_remind) {
        CGRect textRect = self.scanRect;
        textRect.origin.y += CGRectGetHeight(textRect) + 20;
        textRect.size.height = 25.f;
        _remind = [[UILabel alloc] initWithFrame: textRect];
        _remind.textColor = [UIColor whiteColor];
        _remind.textAlignment = NSTextAlignmentCenter;
        _remind.text = REMINDTEXT;
        _remind.backgroundColor = [UIColor clearColor];
    }
    return _remind;
}


@end
