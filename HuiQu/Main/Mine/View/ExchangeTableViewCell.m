//
//  ExchangeTableViewCell.m
//  HuiQu
//
//  Created by Huxley on 16/10/23.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "ExchangeTableViewCell.h"
#import "Macros.h"
@implementation ExchangeTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
    }
    
    return self;

}


-(void)layoutUI{
    _detailToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,Main_Screen_Width,40)];
    _nameButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ddd" style:UIBarButtonItemStylePlain target:self action:nil];
    _typeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ddd" style:UIBarButtonItemStylePlain target:self action:nil];
    _haveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"dfd" style:UIBarButtonItemStylePlain target:self action:nil];
    _optionButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"ggg" style:UIBarButtonItemStylePlain target:self action:nil];
    _spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    _nameButtonItem.enabled = NO;
    _typeButtonItem.enabled = NO;
    _haveButtonItem.enabled = NO;
    _optionButtonItem.enabled = NO;
    
    _detailToolBar.items = @[_nameButtonItem,_spaceButtonItem,_typeButtonItem,_spaceButtonItem,_haveButtonItem,_spaceButtonItem,_optionButtonItem];
    
    
    
    _cellHeight = CGRectGetMaxY(_detailToolBar.frame);
    
    [self.contentView addSubview:_detailToolBar];
    
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
