//
//  WebGameViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/31.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
@interface WebGameViewController : UIViewController

@property(strong, nonatomic)UIWebView *webView;

@property(copy, nonatomic) NSString *urlStr;

@property(strong, nonatomic) AFNetworkReachabilityManager *netWorkManager;

@property(strong, nonatomic) AFHTTPSessionManager *httpSessionManager;


@end
