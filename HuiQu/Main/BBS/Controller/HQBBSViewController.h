//
//  HQBBSViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "ArticleDetailViewController.h"
@interface HQBBSViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) DCPicScrollView *picScrollView;

@property (strong, nonatomic) UITableView *articleTableView;

@property(strong, nonatomic) UIView *sortView;


@property (nonatomic ,strong ) UIView *inputView; //左边输入视图
@property (nonatomic , strong) UITextField *nameTextField;//搜索框
@property (nonatomic , strong) UIImageView *imgSearch; //搜索图片

@property (nonatomic, strong) UIButton *searchBtn;  //搜索按钮
@property (strong, nonatomic) UIControl *shadeControl;   //遮罩


/** 发表 */
@property (strong, nonatomic) UIImageView *appearImageView;


/** 帖子详情控制器 */
@property (strong, nonatomic) ArticleDetailViewController *articleDetailViewController;




@end
