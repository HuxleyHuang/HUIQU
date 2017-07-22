//
//  PersonDataTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/10/18.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "PersonDataTableViewCell.h"
#import "Macros.h"
@implementation PersonDataTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
    }

    return self;
}

-(void)layoutUI{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, 100, 22)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:0.8];
    _cellHeight =CGRectGetMaxY(_titleLabel.frame)+22;
    
    
    [self.contentView addSubview:_titleLabel];
    
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
