//
//  GuideView.h
//  HuiQu
//
//  Created by Huxley on 16/11/3.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GuideView : UIView
@property (nonatomic,strong) NSArray *images;

@property (nonatomic, assign) int scrollDirection;//0代表横向，1，代表纵向


- (instancetype)initWithFrame:(CGRect)frame Images:(NSArray *)images;



@end

