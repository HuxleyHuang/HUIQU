//
//  AppDelegate.m
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "AppDelegate.h"
#import "HQTabBarViewController.h"
#import "NetWork.h"
#import "GuidePageViewController.h"
#import "HQLoginViewController.h"
#import "HQNavViewController.h"

#import "MBProgressHUD+MJ.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:3.0f];//延长3秒显示启动图
   
    
    [self checkNetWork];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"first launch第一次程序启动");
        //== 引导画面了! ==// 
        _guideViewController = [[GuidePageViewController alloc] init];
        [_window setRootViewController:_guideViewController];
        
    }else {
        NSLog(@"second launch再次程序启动");
         _loginViewController = [[HQLoginViewController alloc] init];
         _navigationController = [[HQNavViewController alloc] initWithRootViewController:_loginViewController];
         [_window setRootViewController:_navigationController];
        

    }
    
    //跳过登录
    
//    _tabBarController = [[HQTabBarViewController alloc] init];
//    [_window setRootViewController:_tabBarController];
    
    [_window makeKeyAndVisible];
    return YES;
}

-(void)checkNetWork{
    _netWorkManager = [AFNetworkReachabilityManager sharedManager];
    __block NetWork *network=[NetWork shareInstance];
    [_netWorkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G/3G/4G 网络连接");
                [network changeNetworkStatus:@"2G/3G/4G 网络连接"];
                [MBProgressHUD showSuccess:@"当前使用的是蜂窝数据"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI 连接");
                [network changeNetworkStatus:@"WIFI 连接"];
                [MBProgressHUD showSuccess:@"当前使用的是WIFI连接"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络连接");
                 [network changeNetworkStatus:@"无网络连接"];
                [MBProgressHUD showError:@"网络连接断开"];
                break;
            default:
                NSLog(@"未知网络");
                [network changeNetworkStatus:@"未知网络"];
                [MBProgressHUD showError:@"未知网络连接"];
                break;
        }
    }];
    
    [_netWorkManager startMonitoring];
    

}

//添加网络通知
-(void)networkListener{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChange:) name:AFNetworkingReachabilityDidChangeNotification object:nil];

}

//
-(void)netWorkChange:(NSNotification *)notification{
    NSDictionary *dic =  notification.userInfo;
    __block NetWork *network=[NetWork shareInstance];
    
    NSLog(@"网络状态已改变");
    
    //获取网络状态
    NSInteger status = [[dic objectForKey:@"AFNetworkingReachabilityNotificationStatusItem"] integerValue];
    if (status==AFNetworkReachabilityStatusNotReachable) {
        [network changeNetworkStatus:@"无网络连接"];
        
    }else if(status==AFNetworkReachabilityStatusReachableViaWWAN){
        [network changeNetworkStatus:@"蜂窝数据"];
        
    }else if(status==AFNetworkReachabilityStatusReachableViaWiFi){
        [network changeNetworkStatus:@"WIFI网络"];
        
    }else if(status==AFNetworkReachabilityStatusUnknown){
        [network changeNetworkStatus:@"未知网络"];
        
    }
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
