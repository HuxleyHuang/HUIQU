//
//  MoneyLogTableViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/10/28.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyLogTableViewCell : UITableViewCell

@property(assign, nonatomic) CGFloat cellHeight;

@property(strong, nonatomic) UILabel *explainLabel;
@property(strong, nonatomic) UILabel *timeLabel;
@property(strong, nonatomic) UILabel *sumLabel;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
