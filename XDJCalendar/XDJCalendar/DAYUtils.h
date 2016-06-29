//
//  DAYUtils.h
//  Daysquare
//
//  Created by 杨弘宇 on 16/6/7.
//  Copyright © 2016年 Cyandev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAYUtils : NSObject

+ (NSCalendar *)localCalendar;

+ (NSDate *)dateWithMonth:(NSUInteger)month year:(NSUInteger)year;

+ (NSDate *)dateWithMonth:(NSUInteger)month day:(NSUInteger)day year:(NSUInteger)year;

+ (NSDate *)dateFromDateComponents:(NSDateComponents *)components;

+ (NSUInteger)daysInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

+ (NSUInteger)firstWeekdayInMonth:(NSUInteger)month ofYear:(NSUInteger)year;

+ (NSString *)stringOfWeekdayInEnglish:(NSUInteger)weekday;

+ (NSString *)stringOfMonthInEnglish:(NSUInteger)month;


+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)date;

+ (BOOL)isDateTodayWithDateComponents:(NSDateComponents *)dateComponents;

#pragma mark - 阴历
/**
 *  阴历的月份
 */
+ (NSString *)stringOfMonthInLunarCalendar:(NSUInteger)month;
/**
 *  阴历的每天显示
 */
+ (NSString *)stringOfDayInLunarCalendar:(NSUInteger)day;

+ (NSString *)LunarForSolarYear:(NSDate*)date;
@end
