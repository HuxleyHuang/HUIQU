//
//  DouDiZhuViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "DouDiZhuViewController.h"
#import "Macros.h"
@interface DouDiZhuViewController ()

@end

@implementation DouDiZhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://flash1.7k7k.com/h5/weixin/doudizhu2/game.html"]];
    
    [_webView loadRequest:request];
    
    
    [self.view addSubview:_webView];

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillLayoutSubviews{
    
    [self _shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
    
}

-(void)_shouldRotateToOrientation:(UIDeviceOrientation)orientation {
    
    if (orientation == UIDeviceOrientationPortrait ||orientation ==
        UIDeviceOrientationPortraitUpsideDown) { // 竖屏
        NSLog(@"竖屏");
    } else if(orientation == UIDeviceOrientationLandscapeRight || orientation == UIDeviceOrientationLandscapeLeft){ // 横屏
        NSLog(@"横屏");
        _webView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
       // _webView.transform = CGAffineTransformMakeRotation(M_PI/90);
    }else if(orientation == UIDeviceOrientationUnknown){
        NSLog(@"未知方向");
    }else{
        NSLog(@"无法识别");
    }


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
