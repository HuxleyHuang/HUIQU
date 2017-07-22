//
//  NewTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/10/17.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "Macros.h"
#define  Current_Screen_Width self.contentView.bounds.size.width
@implementation NewsTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    
    return self;
}


-(void)initSubView{
    _newsImageView = [[UIImageView alloc] init];
    _newsTextLabel = [[UILabel alloc] init];
    _newsDetailView = [[UIView alloc] init];
    _newsTitleLabel = [[UILabel alloc] init];
    
    [_newsImageView setFrame:CGRectMake(5, 5, 80, 80)];
    [_newsDetailView setFrame:CGRectMake(CGRectGetMaxX(_newsImageView.frame)+5, CGRectGetMinY(_newsDetailView.frame)+5, Main_Screen_Width-GetViewWidth(_newsImageView)-5-5, CGRectGetHeight(_newsImageView.frame))];
    [_newsTextLabel setFrame:CGRectMake(5, 5, GetViewWidth(_newsDetailView)-5-5, 20)];
    [_newsTitleLabel setFrame:CGRectMake(5,CGRectGetMaxY(_newsTextLabel.frame), GetViewWidth(_newsDetailView)-5-5, 50)];
   
    _newsTextLabel.font = [UIFont systemFontOfSize:14];
    _newsTitleLabel.font = [UIFont systemFontOfSize:12];
    
//    _newsTitleLabel.backgroundColor = [UIColor redColor];
//    _newsDetailView.backgroundColor = [UIColor grayColor];
//    _newsTextLabel.backgroundColor = [UIColor blackColor];
//    _newsImageView.backgroundColor = [UIColor greenColor];
    
    
    _cellHeight = CGRectGetMaxY(_newsImageView.frame)+5;
    
    [_newsDetailView addSubview:_newsTextLabel];
    [_newsDetailView addSubview:_newsTitleLabel];
    [self.contentView addSubview:_newsDetailView];
    [self.contentView addSubview:_newsImageView];
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
