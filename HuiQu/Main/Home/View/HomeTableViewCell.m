//
//  HomeTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/10/10.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "Macros.h"

@implementation HomeTableViewCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
   
    return self;
}


-(void)initSubView{
    //电影封面
    _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,120,140)];
    //_coverImageView.backgroundColor = [UIColor redColor];
    [_coverImageView setImage:[UIImage imageNamed:@"movie_cover"]];
    
    
    //电影详情
    _detailView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_coverImageView.frame)+10, 5, Main_Screen_Width-GetViewWidth(_coverImageView)-15-5, 140)];
    //_detailView.backgroundColor = [UIColor blueColor];
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, GetViewWidth(_detailView)-10, 25)];
    [_titleLabel setText:@"刑警兄弟(VIP电影)"];
    [_detailView addSubview:_titleLabel];
    
    //类型
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_titleLabel.frame)+8, GetViewWidth(_detailView)-10, 20)];
    [_typeLabel setText:@"刑警兄弟丨铜牌巨星丨谍影重重4"];
    [_typeLabel setFont:[UIFont systemFontOfSize:11]];
    
    
    //主演
    _whoStarLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_typeLabel.frame)+8,30, 20)];
    [_whoStarLabel setText:@"主演:"];
    [_whoStarLabel setFont:[UIFont systemFontOfSize:11]];
    
    //明星
    _starShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_whoStarLabel.frame), GetViewY(_whoStarLabel), GetViewWidth(_detailView)-GetViewWidth(_whoStarLabel)-10, 20)];
    [_starShowLabel setFont:[UIFont systemFontOfSize:11]];
    [_starShowLabel setText:@"黄宗泽 金刚 曾志伟 徐子珊 "];
    
    //上映时间
    _showFilmLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,CGRectGetMaxY(_whoStarLabel.frame)+8, 55, 20)];
    [_showFilmLabel setFont:[UIFont systemFontOfSize:11]];
    [_showFilmLabel setText:@"上映时间:"];
    [_detailView addSubview:_showFilmLabel];
    
    
    //时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_showFilmLabel.frame), GetViewY(_showFilmLabel), GetViewWidth(_detailView)-55-10, GetViewHeight(_showFilmLabel))];
    [_timeLabel setText:@"2016-07-20"];
    [_timeLabel setFont:[UIFont systemFontOfSize:11]];
     [_detailView addSubview:_timeLabel];
   
    

    
    [_detailView addSubview:_typeLabel];
    [_detailView addSubview:_whoStarLabel];
    [_detailView addSubview:_starShowLabel];
    
    
    
    
    [self.contentView addSubview:_coverImageView];
    [self.contentView addSubview:_detailView];
    
    _movieTableCellHeight = CGRectGetMaxY(_detailView.frame)+5;
    
    

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
