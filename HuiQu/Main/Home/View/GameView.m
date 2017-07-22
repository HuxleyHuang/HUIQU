//
//  GameView.m
//  HuiQu
//
//  Created by Huxley on 16/11/14.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "GameView.h"
#import "Macros.h"
#import "ImageManager.h"

@implementation GameView



-(instancetype)initWithGameView:(NSString *)title andImage:(UIImage *)image andCurrView:(id)view andGeuster:(SEL)tapGesture{
    self =  [super init];
    if (self) {
        self.frame= CGRectMake(0, 0,Main_Screen_Width, 255);
        
        self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 35)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width/4, 0, Main_Screen_Width/2, 35)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = title;
        self.titleLabel.textColor = [UIColor orangeColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18 weight:3];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame), Main_Screen_Width, 220)];
        self.imageView.image = [ImageManager reSizeImage:image toSize:CGSizeMake(Main_Screen_Width, 220)];
        self.imageView.multipleTouchEnabled = YES;
        self.imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:view action:tapGesture];
        [self.imageView addGestureRecognizer:tapGestureRecognizer];
        
        [self.titleView addSubview:self.titleLabel];
        
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleView];
    }
    
   return self;
}










@end
