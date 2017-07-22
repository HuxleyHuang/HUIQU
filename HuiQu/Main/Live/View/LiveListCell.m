//
//  LiveListCell.m
//  HuiQu
//
//  Created by Huxley on 16/12/15.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "LiveListCell.h"

#import "Macros.h"

#import "LiveItemModel.h"
#import "CreatorItemModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "ImageManager.h"
@implementation LiveListCell




- (void)setLive:(LiveItemModel *)live
{
    _live = live;
    
    
    NSURL *imageUrl = [NSURL URLWithString:live.creator.portrait];
    
    [self.headerImage sd_setImageWithURL:imageUrl placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
       
    }];
    
    
    if (live.city.length == 0) {
        _liveAddressLabel.text = @"难道在火星?";
    }else{
        _liveAddressLabel.text = live.city;
        
    }
    
    self.liveNameLabel.text = live.creator.nick;
    NSLog(@"%@",live.creator.nick);
    
   
    [self.previewImageView sd_setImageWithURL:imageUrl placeholderImage:nil];
    //self.previewImageView.image = [ImageManager reSizeImage:self.previewImageView.image toSize:self.previewImageView.frame.size];
    self.previewImageView.contentMode = UIViewContentModeScaleToFill;
    self.previewImageView.clipsToBounds = YES;
    
    
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%zd人在看", live.online_users];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%zd", live.online_users]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:Color(216, 41, 116) range:range];
    self.peopleNumberLabel.attributedText = attr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headerImage.layer.cornerRadius = 5;
    _headerImage.layer.masksToBounds = YES;
    
    _liveLabel.layer.cornerRadius = 5;
    _liveLabel.layer.masksToBounds = YES;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
