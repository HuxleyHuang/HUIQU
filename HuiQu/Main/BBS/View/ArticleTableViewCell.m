//
//  ArticleTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/10/14.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "Macros.h"
#define  Current_Screen_Width self.contentView.bounds.size.width
@implementation ArticleTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    
    return self;
}


-(void)initSubView{
    
    _articleImageView = [[UIImageView alloc] init];
    _articleDetailView = [[UIView alloc] init];
    _appearNameLabel = [[UILabel alloc] init];
    _appearTimeLabel = [[UILabel alloc] init];
    _articleTitleLabel = [[UILabel alloc] init];
    _visitView = [[UIView alloc] init];
    _revertImage = [[UIImageView alloc] init];
    _callerImage = [[UIImageView alloc] init];
    _revertLabel = [[UILabel alloc] init];
    _callerLabel = [[UILabel alloc] init];
    
    
    _articleImageView.frame = CGRectMake(5, 5, 80, 80);
    _articleDetailView.frame = CGRectMake(CGRectGetMaxX(_articleImageView.frame)+5, 5, Main_Screen_Width-GetViewWidth(_articleImageView)-5-5-5, 90);
    _appearNameLabel.frame = CGRectMake(5, 0, GetViewWidth(_articleDetailView)-5-5, 18);
    _appearTimeLabel.frame = CGRectMake(5, CGRectGetMaxY(_appearNameLabel.frame), 80, 15);
    _articleTitleLabel.frame = CGRectMake(5, CGRectGetMaxY(_appearTimeLabel.frame)+5, GetViewWidth(_articleDetailView)-5-5, 30);
    _visitView.frame = CGRectMake(GetViewWidth(_articleDetailView)-105, GetViewHeight(_articleDetailView)-25, 103, 22);
    
    _revertImage.frame = CGRectMake(0, 1, 20, 20);
    _revertLabel.frame = CGRectMake(CGRectGetMaxX(_revertImage.frame), 1, 30, 20);
    _callerImage.frame = CGRectMake(CGRectGetMaxX(_revertLabel.frame), 1, 20, 20);
    _callerLabel.frame = CGRectMake(CGRectGetMaxX(_callerImage.frame), 1, 33, 20);
    
    _revertImage.image = [UIImage imageNamed:@"revert"];
    _callerImage.image = [UIImage imageNamed:@"caller"];
    _callerLabel.font = [UIFont systemFontOfSize:7];
    _revertLabel.font = [UIFont systemFontOfSize:7];
    _appearNameLabel.font = [UIFont systemFontOfSize:13];
    _appearTimeLabel.font = [UIFont systemFontOfSize:9];
    _articleTitleLabel.font = [UIFont systemFontOfSize:11];
    

    _appearNameLabel.textColor = [UIColor orangeColor];
    
    _cellHeight = CGRectGetMaxY(_articleDetailView.frame)+5;
    
    
    [_visitView addSubview:_callerImage];
    [_visitView addSubview:_callerLabel];
    [_visitView addSubview:_revertLabel];
    [_visitView addSubview:_revertImage];
    
    [_articleDetailView addSubview:_visitView];
    [_articleDetailView addSubview:_articleTitleLabel];
    [_articleDetailView addSubview:_appearTimeLabel];
    [_articleDetailView addSubview:_appearNameLabel];
    [self.contentView addSubview:_articleImageView];
    [self.contentView addSubview:_articleDetailView];
    
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
