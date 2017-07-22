//
//  ExchangeLog.m
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "ExchangeLog.h"

@implementation ExchangeLog


+(ExchangeLog *)initDataWithName:(NSString *)exName andTime:(NSString *)exTime andExplain:(NSString *)exExplain{
    ExchangeLog *exLog = [[ExchangeLog alloc] init];
    exLog.exName = exName;
    exLog.exTime = exTime;
    exLog.exExplain = exExplain;
    
    return exLog;

}

@end
