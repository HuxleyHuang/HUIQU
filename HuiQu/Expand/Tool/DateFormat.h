//
//  DateFormat.h
//  InternetReptile
//
//  Created by Huxley on 16/6/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormat : NSObject



+(NSDate *)getDateFromString:(NSString *)dateStr;

+(NSString *)getStringFromDate:(NSDate *)date;



//通过日期获取星期
+(NSString *)weekdayStringFromDate:(NSDate *)date;

+(NSString *)formatStringFromDate:(NSDate *)date andFormat:(NSString *)strFormat;
+(NSDate *)formatChinaDate:(NSDate *)date;
+(NSDate *)dateAndTimePinJie:(NSString *)date andTime:(NSString *)time;
+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
+(NSString *)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;


//截取时分秒
+(NSString *)getDateSecond:(NSDate *)date;
+(NSString *)getDateMinute:(NSDate *)date;
+(NSString *)getDateHour:(NSDate *)date;


//时间差 折成时间 时:分:秒
+(NSString *)getDate:(NSDate *)maxDate andMinDate:(NSDate *)minDate;

@end
