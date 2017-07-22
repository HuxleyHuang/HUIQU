//
//  AppDelegate.h
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "Macros.h"
@class HQTabBarViewController;
@class GuidePageViewController;
@class HQLoginViewController;
@class HQNavViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HQTabBarViewController *tabBarController;

@property(strong, nonatomic) GuidePageViewController *guideViewController;

@property (strong, nonatomic) AFNetworkReachabilityManager *netWorkManager;

@property(strong, nonatomic) HQNavViewController *navigationController;

@property(strong, nonatomic) HQLoginViewController *loginViewController;



@end

