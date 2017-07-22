//
//  GlobalData.m
//  HuiQu
//
//  Created by Huxley on 16/11/8.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData

+(GlobalData *)instanceGlobal{
    static GlobalData *global = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        global = [[GlobalData alloc] init];
    });

    return global;
}


@end
