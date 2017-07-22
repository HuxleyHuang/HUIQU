//
//  ExchangeLogViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeLogViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UITableView *logTableView;

@property(strong, nonatomic) UIView *tableHeaderView;

@end
