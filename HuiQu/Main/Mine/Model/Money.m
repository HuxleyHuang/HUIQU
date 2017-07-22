//
//  Money.m
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "Money.h"

@implementation Money

+(Money *)initMoneyData:(NSString *)name andMoneyType:(NSString *)type andHaveMoney:(NSNumber *)nums{
    Money *money  = [[Money alloc] init];
    money.gameName = name;
    money.moneyType = type;
    money.haveMoney = nums;
    return money;
}


@end
