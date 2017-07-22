//
//  RollTableViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/11/1.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollTableViewCell : UITableViewCell

@property(strong, nonatomic) UILabel *userLabel;
@property(strong, nonatomic) UILabel *timeLabel;
@property(strong, nonatomic) UILabel *explainLabel;

@property(assign, nonatomic) CGFloat cellHeight;


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;




@end
