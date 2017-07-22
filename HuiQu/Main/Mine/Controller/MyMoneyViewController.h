//
//  MyMoneyViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExchangeLogViewController;
@interface MyMoneyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property(strong, nonatomic) UITableView *moneyTableView;

@property(strong, nonatomic) UIView *tableHeaderView;

@property(strong, nonatomic) UIImageView *headImageView;


@property(strong, nonatomic) UILabel *showNameLabel;

@property(strong, nonatomic) UILabel *nameLabel;

@property(strong, nonatomic) UILabel *howMoneyLabel;

@property(strong, nonatomic) UILabel *moneyLabel;

@property(strong, nonatomic) UIBarButtonItem *rightBarButtonItem;

@property(strong, nonatomic) UIToolbar *explainToolBar;

@property(strong, nonatomic) UIView *toolView;

@property(strong, nonatomic) UIView *headView;

@property(strong, nonatomic) ExchangeLogViewController *exchangeLogViewController;

@end
