//
//  HQNavViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HQNavViewController.h"
#import "UIImage+Image.h"
//橘色导航栏
#define NavBarColor [UIColor colorWithRed:250/255.0 green:120/255.0 blue:40/255.0 alpha:1.0]

@interface HQNavViewController ()

@end

@implementation HQNavViewController


+ (void)load
{
    
    UIBarButtonItem *item=[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    dic[NSForegroundColorAttributeName]=[UIColor blackColor];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    [bar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *dicBar=[NSMutableDictionary dictionary];
    
    dicBar[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [bar setTitleTextAttributes:dic];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        
    }
    
    return [super pushViewController:viewController animated:animated];
}

@end
