//
//  HQMineViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDataViewController.h"
#import "MyMoneyViewController.h"
#import "MyQRCodeViewController.h"
#import "DouDiZhuViewController.h"
#import "MovieViewController.h"
#import "MyMessageViewController.h"
#import "AboutMeViewController.h"
#import "GameLogViewController.h"

@interface HQMineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (strong, nonatomic) UITableView *mineTableView;


/** 跳转视图 */
@property (strong, nonatomic) PersonDataViewController *personDataViewController;
@property (strong, nonatomic) MyMoneyViewController *myMoneyViewController;
@property (strong, nonatomic) GameLogViewController *gameLogViewController;
@property (strong, nonatomic) MyMessageViewController *messageViewController;
@property (strong, nonatomic) AboutMeViewController *aboutMeViewController;



@property (strong, nonatomic) UIControl *personControl;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIBarButtonItem *rightBarButton;
@property (strong, nonatomic) UIButton *exitButton;




@end
