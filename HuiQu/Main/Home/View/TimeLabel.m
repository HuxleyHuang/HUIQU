//
//  TimeLabel.m
//  HuiQu
//
//  Created by Huxley on 16/11/8.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "TimeLabel.h"

@implementation TimeLabel


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];
    }
    return self;
}


- (void)timeHeadle{
    
    
    
    self.second--;
    if (self.second==-1) {
        self.second=59;
        self.minute--;
        if (self.minute==-1) {
            self.minute=59;
            self.hour--;
        }
    }
 
     self.text = [NSString stringWithFormat:@"%0.2ld:%0.2ld:%0.2ld",(long)self.hour,(long)self.minute,(long)self.second];
    
    if (self.second==0 && self.minute==0 && self.hour==0) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





@end
