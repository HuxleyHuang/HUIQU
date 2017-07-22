//
//  HQTabBarViewController.m
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HQTabBarViewController.h"
#import "HQNavViewController.h"
#import "ImageManager.h"
@interface HQTabBarViewController ()

@end

@implementation HQTabBarViewController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildVc];
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBarTintColor:[UIColor orangeColor]];
    [self setHidesBottomBarWhenPushed:YES];
    
}


#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{
    
    HQHomeViewController *homeVC = [[HQHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:homeVC Image:@"home_normal" selectedImage:@"home_normal" title:@"首页"];
    
    
    HQBBSViewController *bbsVC = [[HQBBSViewController alloc] init];
    [self setUpOneChildVcWithVc:bbsVC Image:@"bbs_normal" selectedImage:@"bbs_normal" title:@"论坛"];
   
    
    HQNewsViewController *newsVC = [[HQNewsViewController alloc] init];
    [self setUpOneChildVcWithVc:newsVC Image:@"news_normal" selectedImage:@"news_normal" title:@"慧云购"];
    
    
    
    HQMineViewController *mineVC = [[HQMineViewController alloc] init];
    [self setUpOneChildVcWithVc:mineVC Image:@"mine_normal" selectedImage:@"mine_normal" title:@"会员中心"];
    
    
    
    
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    HQNavViewController *nav = [[HQNavViewController alloc] initWithRootViewController:Vc];
    
    
    
    Vc.view.backgroundColor = [UIColor whiteColor];
    UIImage *myImage = [ImageManager reSizeImage:[UIImage imageNamed:image] toSize:CGSizeMake(50, 32)];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [ImageManager reSizeImage:[UIImage imageNamed:selectedImage] toSize:CGSizeMake(50, 32)];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    //Vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}






- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
}

@end
