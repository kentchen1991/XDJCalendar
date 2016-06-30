//
//  DAYUtils.m
//  Daysquare
//
//  Created by 杨弘宇 on 16/6/7.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

#import "DAYUtils.h"

@implementation DAYUtils

+ (NSCalendar *)localCalendar {//阳历
    static NSCalendar *Instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        Instance.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//设置时区
        [Instance setTimeZone:timeZone];
    });
    return Instance;
}

+ (NSDate *)dateWithMonth:(NSUInteger)month year:(NSUInteger)year {
    return [self dateWithMonth:month day:1 year:year];
}

+ (NSDate *)dateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    
    return [self dateFromDateComponents:comps];
}

+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components {
    return [[self localCalendar] dateFromComponents:components];
}

+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year {
    NSDate *date = [self dateWithMonth:month year:year];
    return [[self localCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year {
    NSDate *date = [self dateWithMonth:month year:year];
    return [[self localCalendar] component:NSCalendarUnitWeekday fromDate:date];
}

+ (NSString *)stringOfWeekdayInEnglish:(NSUInteger)weekday {
    NSAssert(weekday >= 1 && weekday <= 7, @"Invalid weekday: %lu", (unsigned long) weekday);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Strings = @[@"Sun", @"Mon", @"Tues", @"Wed", @"Thur", @"Fri", @"Sat"];
//        Strings = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    });
    
    return Strings[weekday - 1];
}

+ (NSString *)stringOfMonthInEnglish:(NSUInteger)month {
    NSAssert(month >= 1 && month <= 12, @"Invalid month: %lu", (unsigned long) month);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Strings = @[@"Jan.", @"Feb.", @"Mar.", @"Apr.", @"May.", @"Jun.", @"Jul.", @"Aug.", @"Sept.", @"Oct.", @"Nov.", @"Dec."];
//        Strings = @[@"1.", @"2.", @"3.", @"4.", @"5.", @"6.", @"7.", @"8.", @"9.", @"10.", @"11.", @"12."];
    });
    
    return Strings[month - 1];
}


+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date {
    return [[self localCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
}

+ (BOOL)isDateTodayWithDateComponents:(NSDateComponents *)dateComponents {
    NSDateComponents *todayComps = [self dateComponentsFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return todayComps.year == dateComponents.year && todayComps.month == dateComponents.month && todayComps.day == dateComponents.day;
}

#pragma mark - 阴历
/**
 *  //////////////////////////////////////////阴历////////////////////////////////////////////////////
 */

+ (NSCalendar *)lunarCalendar { //阴历
    static NSCalendar *Instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        Instance.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        
    });
    return Instance;
}

+ (NSString *)stringOfMonthInLunarCalendar:(NSUInteger)month {
    NSAssert(month >= 1 && month <= 12, @"Invalid month: %lu", (unsigned long) month);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Strings = @[@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊"];
        //        Strings = @[@"1.", @"2.", @"3.", @"4.", @"5.", @"6.", @"7.", @"8.", @"9.", @"10.", @"11.", @"12."];
    });
    return Strings[month - 1];
}

+ (NSString *)stringOfDayInLunarCalendar:(NSUInteger)day {
//    NSAssert(month >= 1 && month <= 12, @"Invalid month: %lu", (unsigned long) month);
    static NSArray *Strings;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Strings = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                    @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                    @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十"];
        //        Strings = @[@"1.", @"2.", @"3.", @"4.", @"5.", @"6.", @"7.", @"8.", @"9.", @"10.", @"11.", @"12."];
    });
    return Strings[day - 1];
}

+ (NSString *)LunarForSolarYear:(NSDate*)date {
    NSInteger day = [[self lunarCalendar] components:NSCalendarUnitDay fromDate:date].day;//日
    
    NSInteger month = [[self lunarCalendar] components:NSCalendarUnitMonth fromDate:date].month; //月
    
    NSString* dayStr = [self stringOfDayInLunarCalendar:day];
    
    NSString* monthStr = [NSString stringWithFormat:@"%@月",[self stringOfMonthInLunarCalendar:month]];
    if ([dayStr isEqualToString:@"初一"]) {
        dayStr = monthStr;
    }
    //节假日转换
    
    
    dayStr = [self LunarForSolarYearWithMonth:monthStr dayStr:dayStr];
    
    
    NSString *lunarDate = [NSString stringWithFormat:@"%@",dayStr];
    
    return lunarDate;
}


#pragma mark - 农历转换函数

+ (NSString*)LunarForSolarYearWithMonth:(NSString*)monthStr dayStr:(NSString*)dayStr {
    
    if([monthStr isEqualToString:@"正月"] &&
       [dayStr isEqualToString:@"正月"]){
        
        //正月初一：春节
        return @"春节";
        
    }else if([monthStr isEqualToString:@"正月"] &&
             [dayStr isEqualToString:@"十五"]){
        
        
        //正月十五：元宵节
        return @"元宵";
        
    }else if([monthStr isEqualToString:@"二月"] &&
             [dayStr isEqualToString:@"初二"]){
        
        //二月初二：春龙节(龙抬头)
        return @"龙抬头";
        
    }else if([monthStr isEqualToString:@"五月"] &&
             [dayStr isEqualToString:@"初五"]){
        
        //五月初五：端午节
        return @"端午";
        
    }else if([monthStr isEqualToString:@"七月"] &&
             [dayStr isEqualToString:@"初七"]){
        
        //七月初七：七夕情人节
        return @"七夕";
        
    }else if([monthStr isEqualToString:@"八月"] &&
             [dayStr isEqualToString:@"十五"]){
        
        //八月十五：中秋节
        return @"中秋";
        
    }else if([monthStr isEqualToString:@"九月"] &&
             [dayStr isEqualToString:@"初九"]){
        
        //九月初九：重阳节、中国老年节（义务助老活动日）
        return @"重阳";
        
    }else if([monthStr isEqualToString:@"腊月"] &&
             [dayStr isEqualToString:@"初八"]){
        
        //腊月初八：腊八节
        return @"腊八";
        
    }else if([monthStr isEqualToString:@"腊月"] &&
             [dayStr isEqualToString:@"二十四"]){
        //腊月二十四 小年
        return @"小年";
    }else{
        return dayStr;
    }
//    else if([solarYear_arr[0]isEqualToString:@"腊"] &&
//             [solarYear_arr[1]isEqualToString:@"三十"]){
//
//        //腊月三十（小月二十九）：除夕
//        return @"除夕";  除夕不一定是30
//        
//    }
    
}




@end
