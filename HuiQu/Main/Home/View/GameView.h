//
//  GameView.h
//  HuiQu
//
//  Created by Huxley on 16/11/14.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameView : UIView


/** 名称视图 **/
@property(strong, nonatomic) UIView *titleView;


/** 游戏名称  **/
@property(strong, nonatomic) UILabel *titleLabel;


/** 图片 **/
@property(strong, nonatomic) UIImageView *imageView;



-(instancetype)initWithGameView:(NSString *)title andImage:(UIImage *)image andCurrView:(id)view andGeuster:(SEL)tapGesture;


@end
