//
//  GameLogViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameLogViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView *tableHeaderView;
@property(strong, nonatomic)UIView *headView;
@property(strong, nonatomic)UIView *tabView;
@property(strong, nonatomic)UIImageView *headImageView;

@property(strong, nonatomic) UILabel *showNameLabel;
@property(strong, nonatomic) UILabel *nameLabel;
@property(strong, nonatomic) UILabel *howMoneyLabel;
@property(strong, nonatomic) UILabel *moneyLabel;

@property(strong, nonatomic) UIButton *leftButton;
@property(strong, nonatomic) UIButton *rightButton;


@property(strong, nonatomic)UITableView *leftTableView;
@property(strong, nonatomic)UITableView *rightTableView;


@end
