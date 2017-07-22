//
//  ExchangeLogTableViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeLogTableViewCell : UITableViewCell

@property(strong, nonatomic) UIView *navView;
@property(strong, nonatomic) UILabel *dhNameLabel;
@property(strong, nonatomic) UILabel *dhTimeLabel;
@property(strong, nonatomic) UILabel *dhExplainLabel;

@property(assign, nonatomic) CGFloat cellHeight;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
