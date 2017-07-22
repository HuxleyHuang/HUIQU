//
//  ArticleTableViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/10/14.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell

@property(strong, nonatomic) UIImageView *articleImageView;
@property(strong, nonatomic) UIView *articleDetailView;
@property(strong, nonatomic) UILabel *articleTitleLabel;
@property(strong, nonatomic) UILabel *appearTimeLabel;
@property(strong, nonatomic) UILabel *appearNameLabel;

/** 访客 */
@property(strong, nonatomic) UIView *visitView;
@property(strong, nonatomic) UIImageView *revertImage;
@property(strong, nonatomic) UIImageView *callerImage;
@property(strong, nonatomic) UILabel *revertLabel;
@property(strong, nonatomic) UILabel *callerLabel;



@property(nonatomic) CGFloat cellHeight;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
