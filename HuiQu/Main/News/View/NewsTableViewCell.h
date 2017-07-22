//
//  NewTableViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/10/17.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property(strong, nonatomic) UIImageView *newsImageView;
@property(strong, nonatomic) UIView *newsDetailView;
@property(strong, nonatomic) UILabel *newsTitleLabel;
@property(strong, nonatomic) UILabel *newsTextLabel;
@property(nonatomic) CGFloat cellHeight;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
