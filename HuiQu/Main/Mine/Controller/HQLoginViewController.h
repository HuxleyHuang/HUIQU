//
//  HQLoginViewController.h
//  HuiQu
//
//  Created by Huxley on 16/11/2.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "ViewController.h"

@interface HQLoginViewController : ViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property(strong, nonatomic)UIButton *btnLogIn;

@property(strong, nonatomic)NSTimer *timer;

@property(strong, nonatomic)NSString *stateString;

@property(strong, nonatomic)NSArray *arrM;

@property(strong, nonatomic)UIView *midV;

@property(strong, nonatomic) UINavigationBar *navBar;

@property(strong, nonatomic) UIScrollView *scorllV;




@end
