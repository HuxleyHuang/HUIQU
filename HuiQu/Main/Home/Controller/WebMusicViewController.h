//
//  WebMusicViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/31.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebMusicViewController : UIViewController

@property(strong, nonatomic)UIWebView *webView;

@property(copy, nonatomic) NSString *urlStr;

@property(nonatomic) Boolean isPlaying;



@end