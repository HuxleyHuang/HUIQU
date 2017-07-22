//
//  Money.h
//  HuiQu
//
//  Created by Huxley on 16/10/27.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Money : NSObject



@property(copy, nonatomic) NSString *gameName;
@property(copy, nonatomic) NSString *moneyType;
@property(assign, nonatomic) NSNumber *haveMoney;



+(Money *)initMoneyData:(NSString *)name andMoneyType:(NSString *)type andHaveMoney:(NSNumber *)nums;

@end
