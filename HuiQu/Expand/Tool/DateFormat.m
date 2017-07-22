//
//  DateFormat.m
//  InternetReptile
//
//  Created by Huxley on 16/6/13.
//  Copyright © 2016年 Huxley. All rights reserved.
//

#import "DateFormat.h"

@implementation DateFormat

//string转换date
+(NSDate *)getDateFromString:(NSString *)dateStr{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [dateFormat dateFromString:dateStr];
    return date;
}

//date转换string
+(NSString *)getStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *dateStr = [dateFormat stringFromDate:date];
    
    return dateStr;
}






/**
*  格式化日期 为星期
*/

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


//格式化日期为字符串
+(NSString *)formatStringFromDate:(NSDate *)date andFormat:(NSString *)strFormat{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = [NSString stringWithFormat:@"%@",strFormat];
    NSString *formatDate =  [dateFormat stringFromDate:date];
    
    return formatDate;
}



//将时间转成+8区 中国北京时间
+(NSDate *)formatChinaDate:(NSDate *)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //dateFormat.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];//直接指定时区
    dateFormat.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *plus8TZStr = [dateFormat stringFromDate:date];
    dateFormat.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];//这就是GMT+0时区了
    return [dateFormat dateFromString:plus8TZStr];
    
}

//拼接日期和时间
+(NSDate *)dateAndTimePinJie:(NSString *)date andTime:(NSString *)time{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSString *dateTime = [NSString stringWithFormat:@"%@ %@",date,time];
    dateFormat.dateFormat = [NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dated =  [dateFormat dateFromString:dateTime];
    return dated;
}



//获取当前时区当前时间
+(NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate {
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}
    
    
    
#pragma mark - 时间比较大小
+(NSString *)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
        NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
        NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
        NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
        NSComparisonResult result = [dateA compare:dateB];
        if (result == NSOrderedDescending) {
            //oneDay > anotherDay
            return @"1";
        }
        else if (result == NSOrderedAscending){
            //oneDay < anotherDay
            return @"-1";
        }
        //oneDay = anotherDay
        return @"0";
    }

//时分秒截取
+(NSString *)getDateSecond:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSArray *array = [dateStr componentsSeparatedByString:@":"];
    
    return [array objectAtIndex:2];
    
}

+(NSString *)getDateMinute:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSArray *array = [dateStr componentsSeparatedByString:@":"];
    
    return [array objectAtIndex:1];
}

+(NSString *)getDateHour:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSArray *array = [dateStr componentsSeparatedByString:@":"];
    
    return [array objectAtIndex:0];
}


//时间差 折成时间 时:分:秒
+(NSString *)getDate:(NSDate *)maxDate andMinDate:(NSDate *)minDate{
    NSTimeInterval maxDateSecond =  [maxDate timeIntervalSince1970];
    NSTimeInterval minDateSecond = [minDate timeIntervalSince1970];
    NSTimeInterval time=maxDateSecond-minDateSecond;
    int itime = (int)time;
    
    long hour = itime%3600==0?itime/3600:(long)(itime/3600);
    long isecond = itime-hour*3600;
    long minute = isecond%60==0?isecond/60:(long)(isecond/60);
    long second  = isecond-minute*60;
    
    NSString *str = @"00:00:00";
    
    if (hour<10) {
        if (minute<10) {
            if (second<10) {
                str = [NSString stringWithFormat:@"0%ld:0%ld:0%ld",hour,minute,second];
            }else{
                str = [NSString stringWithFormat:@"0%ld:0%ld:%ld",hour,minute,second];
            }
        }else{
            if (second<10) {
                str = [NSString stringWithFormat:@"0%ld:%ld:0%ld",hour,minute,second];
            }else{
                str = [NSString stringWithFormat:@"0%ld:%ld:%ld",hour,minute,second];
            }
        }
        
    }else{
        if (minute<10) {
            if (second<10) {
                str = [NSString stringWithFormat:@"%ld:0%ld:0%ld",hour,minute,second];
            }else{
                str = [NSString stringWithFormat:@"%ld:0%ld:%ld",hour,minute,second];
            }
        }else{
            if (second<10) {
                str = [NSString stringWithFormat:@"%ld:%ld:0%ld",hour,minute,second];
            }else{
                str = [NSString stringWithFormat:@"%ld:%ld:%ld",hour,minute,second];
            }
        }
    }
    
    
    
    return str;
}




@end
