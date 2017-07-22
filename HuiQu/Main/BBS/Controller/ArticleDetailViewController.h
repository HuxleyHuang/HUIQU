//
//  ArticleDetailViewController.h
//  HuiQu
//
//  Created by Huxley on 16/10/18.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleDetailViewController : UIViewController


/** 帖子 数据源 */
@property (strong, nonatomic) Article *article;

@end
