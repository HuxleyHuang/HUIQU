//
//  HQNewsViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/9.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "NewsDetailViewController.h"
@interface HQNewsViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) DCPicScrollView *picScrollView;

@property (strong, nonatomic) UITableView *newsTableView;
@property (strong, nonatomic) NewsDetailViewController *detailViewController;


@property(strong, nonatomic) UIView *sortView;
@end
