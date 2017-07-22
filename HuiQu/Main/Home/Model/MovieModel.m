//
//  MovieModel.m
//  HuiQu
//
//  Created by Huxley on 16/10/10.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel



//这里给的是初始化值
-(instancetype)init{
    self=[super init];
    if (self) {
        _coverPath = @"movie_cover";
        _name = @"刑警兄弟";
        _type = [NSArray arrayWithObjects:@"刑警兄弟",@"铜牌巨星",@"谍影重重4", nil];
        _stars = [NSArray arrayWithObjects:@"黄宗泽",@"金刚",@"曾志伟",@"徐子珊", nil];
        _time = @"2016-10-10";
        
    }
    return self;

}

@end
