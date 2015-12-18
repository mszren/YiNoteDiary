//
//  ScanController.m
//  Diary
//
//  Created by 我 on 15/12/17.
//  Copyright © 2015年 Owen. All rights reserved.
//

#import "ScanController.h"
#import <AVFoundation/AVFoundation.h>
#import "BaseNavigation.h"
#import "Masonry.h"

@interface ScanController () <AVCaptureMetadataOutputObjectsDelegate>

@end

@implementation ScanController{
    
    AVCaptureSession* _captureSession;
    UIImageView* _line;
    UIImageView* _bgImageView;
    UIButton* scanbutton;
    AVCaptureVideoPreviewLayer* _layer;
    AVCaptureDeviceInput* _input;
    AVCaptureMetadataOutput* _output;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initCamera];
}

//调用摄像头
- (void)initCamera{
    
    BOOL Custom= [UIImagePickerController
                  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];//判断摄像头是否能用
    if (Custom){
        [self initScan];//启动摄像头
    }
    else{
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"摄像头不能使用" preferredStyle:UIAlertControllerStyleAlert];
        [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BaseNavigation sharedInstance] setGreenNavigationBar:self andTitle:@"二维码扫描"];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    //开始捕获
    [_captureSession startRunning];
}

- (void)initView
{

    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (Screen_height < 500) {
        
        UIImage* image = [UIImage imageNamed:@"qrcode_scan_bg_Green.png"];
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height - NavigationBarHeight - 100)];
        _bgImageView.contentMode = UIViewContentModeTop;
        _bgImageView.clipsToBounds = YES;
        
        _bgImageView.image = image;
        _bgImageView.userInteractionEnabled = YES;
    }
    else {
        
        UIImage* image = [UIImage imageNamed:@"qrcode_scan_bg_Green_iphone5"];
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_height - NavigationBarHeight - 100)];
        _bgImageView.contentMode = UIViewContentModeTop;
        _bgImageView.clipsToBounds = YES;
        
        _bgImageView.image = image;
        _bgImageView.userInteractionEnabled = YES;
    }
    [self.view addSubview:_bgImageView];
    
    UILabel* scanelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _bgImageView.frame.size.width , 20)];
    scanelabel.text = @"将取景框对准二维码，即可自动扫描";
    scanelabel.textColor = [UIColor whiteColor];
    scanelabel.textAlignment = NSTextAlignmentCenter;
    scanelabel.numberOfLines = 2;
    scanelabel.font = FONT_SIZE_15;
    scanelabel.backgroundColor = [UIColor clearColor];
    [_bgImageView addSubview:scanelabel];
    
    _line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qrcode_scan_light_green"]];
    _line.center = CGPointMake(_bgImageView.center.x, 60);
    [_bgImageView addSubview:_line];
    
    //下方背景
    UIImageView* scanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _bgImageView.frame.size.height, Screen_Width, 100)];
    scanImageView.image = [UIImage imageNamed:@"qrcode_scan_bar"];
    scanImageView.userInteractionEnabled = YES;
    [self.view addSubview:scanImageView];
    
    //闪光灯
    scanbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanbutton setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [scanbutton setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateHighlighted];
    scanbutton.frame = CGRectMake(0, 0, 65, 87);
    scanbutton.center = CGPointMake(scanImageView.center.x, 50);
    [scanImageView addSubview:scanbutton];
    
    [scanbutton addTarget:self action:@selector(flashLightClick) forControlEvents:UIControlEventTouchUpInside];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scanAnim) userInfo:nil repeats:YES];
}

- (void)initScan
{
    // Do any additional setup after loading the view, typically from a nib.
    //获取摄像设备
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    _output = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程里刷新
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置扫描范围
    _output.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    
    //初始化链接对象
    _captureSession = [[AVCaptureSession alloc] init];
    //高质量采集率
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_captureSession addInput:_input];
    [_captureSession addOutput:_output];
    //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    _output.metadataObjectTypes = @[ AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code ];
    
    _layer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _layer.frame = self.view.layer.bounds;
    [self.view.layer insertSublayer:_layer atIndex:0];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput*)captureOutput didOutputMetadataObjects:(NSArray*)metadataObjects fromConnection:(AVCaptureConnection*)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        //停止扫描
        
        [self stopReading];
        [_captureSession stopRunning];
        AVMetadataMachineReadableCodeObject* metadataObject = [metadataObjects objectAtIndex:0];
        [self translateResult:metadataObject.stringValue];
    }
}

- (void)translateResult:(NSString*)stringValue
{
    NSError* error;
    //http+:[^\\s]* 这是检测网址的正则表达式
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error]; //筛选
    if (regex != nil) {
        NSTextCheckingResult* firstMatch = [regex firstMatchInString:stringValue options:0 range:NSMakeRange(0, [stringValue length])];
        
    }
    
    regex = [NSRegularExpression regularExpressionWithPattern:@"jjb://*" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult* firstMatch = [regex firstMatchInString:stringValue options:0 range:NSMakeRange(0, [stringValue length])];
        if (firstMatch) {
            stringValue = [stringValue substringFromIndex:6];
            NSData* data = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary* dicData =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingMutableLeaves
                                              error:&error];
            if (!error) {
                
                
                
                
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)stopReading
{
    
    [_captureSession stopRunning];
}

#pragma mark 点击取消返回
- (void)pressCancelButton:(UIButton*)button
{
    //停止扫描
    [self stopReading];
    [self.navigationController popViewControllerAnimated:YES];
}

//开启关闭闪光灯
- (void)flashLightClick
{
    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode == AVCaptureTorchModeOff) {
        //闪光灯开启
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [scanbutton setImage:[UIImage imageNamed:@"qrcode_scan_btn_scan_off"] forState:UIControlStateNormal];
        [scanbutton setImage:[UIImage imageNamed:@"qrcode_scan_btn_scan_off"] forState:UIControlStateHighlighted];
    }
    else {
        //闪光灯关闭
        [device setTorchMode:AVCaptureTorchModeOff];
        [scanbutton setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
        [scanbutton setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateHighlighted];
    }
}

- (void)scanAnim
{
    
    [UIView animateWithDuration:2
                     animations:^{
                         
                         _line.frame = CGRectMake(_line.frame.origin.x, 60 + Screen_height / 480 * 170, _line.frame.size.width, _line.frame.size.height);
                         
                     }
                     completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:2
                                          animations:^{
                                              _line.frame = CGRectMake(_line.frame.origin.x, 60, _line.frame.size.width, _line.frame.size.height);
                                          }];
                         
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
