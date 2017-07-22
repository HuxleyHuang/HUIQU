//
//  ExchangeLogTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "ExchangeLogTableViewCell.h"
#import "Macros.h"
@implementation ExchangeLogTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
    }
    return self;
}


-(void)layoutUI{
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0,  0, Main_Screen_Width, 55)];
    
    _dhNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (GetViewHeight(_navView)-30)/2, GetViewWidth(_navView)/3, 30)];
    _dhTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_dhNameLabel.frame), GetViewY(_dhNameLabel), Main_Screen_Width/3, 30)];
    _dhExplainLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_dhTimeLabel.frame), GetViewY(_dhTimeLabel), Main_Screen_Width/3, 30)];
    
    
    _dhNameLabel.textAlignment = NSTextAlignmentCenter;
    _dhTimeLabel.textAlignment = NSTextAlignmentCenter;
    _dhExplainLabel.textAlignment = NSTextAlignmentCenter;
    
    _dhNameLabel.font = [UIFont systemFontOfSize:14];
    _dhTimeLabel.font = [UIFont systemFontOfSize:14];
    _dhExplainLabel.font = [UIFont systemFontOfSize:14];
    
  
    
    
    _cellHeight = CGRectGetMaxY(_navView.frame);
    
    [_navView addSubview:_dhExplainLabel];
    [_navView addSubview:_dhTimeLabel];
    [_navView addSubview:_dhNameLabel];
    
    [self.contentView addSubview:_navView];
    
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
