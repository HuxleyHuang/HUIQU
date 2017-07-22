//
//  ExchangeLog.h
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeLog : NSObject

@property(copy, nonatomic) NSString *exName;
@property(copy, nonatomic) NSString *exTime;
@property(copy, nonatomic) NSString *exExplain;


+(ExchangeLog *)initDataWithName:(NSString *)exName andTime:(NSString *)exTime andExplain:(NSString *)exExplain;

@end
