//
//  ExchangeTableViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/10/23.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeTableViewCell : UITableViewCell

@property(strong, nonatomic) UIToolbar *detailToolBar;


@property(strong, nonatomic) UIBarButtonItem *nameButtonItem;
@property(strong, nonatomic) UIBarButtonItem *typeButtonItem;
@property(strong, nonatomic) UIBarButtonItem *haveButtonItem;
@property(strong, nonatomic) UIBarButtonItem *optionButtonItem;
@property(strong, nonatomic) UIBarButtonItem *spaceButtonItem;

@property(assign, nonatomic) CGFloat cellHeight;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
