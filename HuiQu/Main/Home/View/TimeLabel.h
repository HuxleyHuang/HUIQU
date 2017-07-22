//
//  TimeLabel.h
//  HuiQu
//
//  Created by Huxley on 16/11/8.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLabel : UILabel


@property (nonatomic,assign)NSInteger second;
@property (nonatomic,assign)NSInteger minute;
@property (nonatomic,assign)NSInteger hour;
@property (nonatomic,strong)NSTimer *timer;



@end
