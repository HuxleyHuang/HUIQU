//
//  HHScrollLabel.h
//  HuiQu
//
//  Created by Huxley on 16/11/1.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, HHLabelSpeed) {
    HHLabelSpeedSlow = -1,
    HHLabelSpeedMild,
    HHLabelSpeedFast
};

@interface HHScrollLabel : UIView

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;         // 默认:system(15)
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) NSAttributedString *attributedText;

@property (nonatomic, assign) HHLabelSpeed speed;

// 循环滚动次数(为0时无限滚动)
@property (nonatomic, assign) NSUInteger repeatCount;

@property (nonatomic, assign) CGFloat leastInnerGap;

- (void)reloadView;

@end
