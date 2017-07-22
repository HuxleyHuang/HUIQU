//
//  HomeTableViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/10/10.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property(strong, nonatomic) UIImageView *coverImageView;
@property(strong, nonatomic) UIView *detailView;

@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UILabel *typeLabel;
@property(strong, nonatomic) UILabel *whoStarLabel;
@property(strong, nonatomic) UILabel *starShowLabel;
@property(strong, nonatomic) UILabel *showFilmLabel;
@property(strong, nonatomic) UILabel *timeLabel;

@property(nonatomic,assign) CGFloat movieTableCellHeight;





-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
