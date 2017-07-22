//
//  WebGameViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/31.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "WebGameViewController.h"
#import "Macros.h"
#import "NetWork.h"
@interface WebGameViewController ()

@end

@implementation WebGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self layoutUI];
    
}

-(void)alert:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
                                          
     UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:alertAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];

}


-(void)initData{
    
//    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"getUserInfo",@"method", nil];
//    
//    NSString *urlStr =@"http://huiyungou.710zh.com/app/appAction.php";
//    
//    //NSURL *url = [NSURL URLWithString:urlStr];
//
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
//    
//    _httpSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
//    
//    [_httpSessionManager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"请求进度：%lld/%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"%@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error = %@",error);
//    }];
    
    
//    NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [[NSString stringWithFormat:@"method=%@",@"getUserInfo"] dataUsingEncoding:NSUTF8StringEncoding];
//    
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *sessionTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,  NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//       NSString *str =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"data = %@",str);
//        NSLog(@"error = %@",error);
//        
//    }];
//    [sessionTask resume];
    
    
    
    
    

}

-(void)netWorkChange:(NSNotification *)notification{
    

}


-(void)layoutUI{
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44)];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
}

-(void)viewWillLayoutSubviews{
    
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
    
}


-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    
    
    if(orientation == UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight){
        _webView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-32);
    }else if(orientation==UIDeviceOrientationPortrait || orientation== UIDeviceOrientationPortraitUpsideDown){
        _webView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-44-20);
    }
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
