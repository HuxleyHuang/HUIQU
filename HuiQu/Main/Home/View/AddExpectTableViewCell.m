//
//  AddExpectTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/11/30.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "AddExpectTableViewCell.h"

@implementation AddExpectTableViewCell




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self layoutUI];
    }
    return self;
}


-(void)layoutUI{


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
