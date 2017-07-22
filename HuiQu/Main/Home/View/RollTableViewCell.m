//
//  RollTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/11/1.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "RollTableViewCell.h"
#import "Macros.h"
@implementation RollTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self layoutUI];
    }
    
    return self;
    
}

-(void)layoutUI{
    _userLabel = [[UILabel alloc] init];
    _timeLabel = [[UILabel alloc] init];
    _explainLabel = [[UILabel alloc] init];
    
    
    _userLabel.frame = CGRectMake(5, 0, self.contentView.bounds.size.width*3/11, 28);
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(_userLabel.frame), 0, self.contentView.bounds.size.width*3/11, 28);
    _explainLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, self.contentView.bounds.size.width*5/11-5, 28);
    
    _userLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _explainLabel.font = [UIFont systemFontOfSize:12];
    
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    
    _cellHeight =  CGRectGetMaxY(_explainLabel.frame);
    
    
    [self.contentView addSubview:_userLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_explainLabel];
    

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
