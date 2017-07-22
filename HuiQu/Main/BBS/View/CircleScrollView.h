//
//  CircleScrollView.h
//  HuiQu
//
//  Created by Huxley on 16/10/14.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CircleScrollView;
@protocol CircleScrollViewDelegate <NSObject>

- (void)didClickImageAtIndex:(NSInteger)index scrollView:(CircleScrollView *)scrollView;

@end

@interface CircleScrollView : UIView

@property (weak, nonatomic) id<CircleScrollViewDelegate> delegate;
@property (assign, nonatomic) NSTimeInterval duringTime;            // 间隔时间，0表示不自动滚动

@property (strong, nonatomic) NSArray *titles;               //文本标题


- (void)images:(NSArray *)images;
- (void)closeTimer;
- (void)openTimer;

@end
