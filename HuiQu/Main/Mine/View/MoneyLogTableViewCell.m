//
//  MoneyLogTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/10/28.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "MoneyLogTableViewCell.h"
#import "Macros.h"
@implementation MoneyLogTableViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
    }

    return self;
}

-(void)layoutUI{
    
    _explainLabel = [[UILabel alloc] init];
    _timeLabel = [[UILabel alloc] init];
    _sumLabel = [[UILabel alloc] init];
    
    
    _explainLabel.frame = CGRectMake(5, 5, Main_Screen_Width/2, 25);
    _timeLabel.frame = CGRectMake(GetViewX(_explainLabel), CGRectGetMaxY(_explainLabel.frame), Main_Screen_Width/2, 22);
    _sumLabel.frame = CGRectMake(Main_Screen_Width-65, GetViewY(_explainLabel), 60, 47);
    
    
    
    _explainLabel.textColor = [UIColor blackColor];
    _timeLabel.textColor = [UIColor grayColor];
    _sumLabel.textColor = [UIColor orangeColor];
    
    
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _explainLabel.font = [UIFont systemFontOfSize:15];
    _sumLabel.font = [UIFont systemFontOfSize:17];
    
    _cellHeight = CGRectGetMaxY(_timeLabel.frame)+5;
    
    
    
    [self.contentView addSubview:_sumLabel];
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
