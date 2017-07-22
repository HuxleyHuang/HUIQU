//
//  HomeCollectionViewCell.h
//  HuiQu
//
//  Created by Huxley on 16/10/10.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface HomeCollectionViewCell : UICollectionViewCell

/** 图片 */
@property (nonatomic, strong) UIImageView *musicImageView;

@property (nonatomic, strong) UIImageView *musicShadeView;

/** 标题 */
@property (nonatomic, strong) UILabel *musicTitleLabel;

/** 阅读量*/
@property (nonatomic, strong) UILabel *musicReadNumLabel;

/** 透明层*/
@property (nonatomic, strong) UIView *shadeView;

/** 耳机图标*/
@property(nonatomic,strong) UIImageView *earphoneImageView;




-(instancetype)initWithFrame:(CGRect)frame;


-(void)initMusicModel:(MusicModel *)musicModel;

@end
