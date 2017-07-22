//
//  AddressTableViewCell.m
//  ChooseLocation
//
//  Created by Sekorm on 16/8/26.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressItem.h"

@interface AddressTableViewCell ()
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic)  UIImageView *selectFlag;
@end
@implementation AddressTableViewCell

- (void)setItem:(AddressItem *)item{
    
    _item = item;
    _addressLabel.text = item.name;
    _addressLabel.textColor = item.isSelected ? [UIColor orangeColor] : [UIColor blackColor] ;
    _selectFlag.hidden = !item.isSelected;
}
@end
