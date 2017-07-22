//
//  PersonDataTableViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/10/18.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonDataTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;

@property (assign, nonatomic) CGFloat cellHeight;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
