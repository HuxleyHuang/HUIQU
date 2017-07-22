//
//  WebTVViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/31.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "WebTVViewController.h"
#import "Macros.h"
@interface WebTVViewController ()

@end

@implementation WebTVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layoutUI];
}


-(void)layoutUI{
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-20-44)];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
}


#pragma mark 横竖屏切换
-(void)viewWillLayoutSubviews{
    
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
    
}


-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    
    
    if(orientation == UIDeviceOrientationLandscapeLeft || orientation==UIDeviceOrientationLandscapeRight){
        _webView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-44);
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
