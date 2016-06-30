//
//  XDJSelectCalendarType.h
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#ifndef XDJSelectCalendarType_h
#define XDJSelectCalendarType_h

typedef NS_ENUM(NSInteger,XDJCalendarSelectViewType) {
    XDJCalendarSelectViewTypeMonthAll = 1, //全月全选
    XDJCalendarSelectViewTypeMonthWeekdayMorning ,//工作日上午
    XDJCalendarSelectViewTypeMonthAllWeekdayAfternoon ,//工作日下午
    XDJCalendarSelectViewTypeMonthCycleMonth ,//循环全月行程
};

#endif /* XDJSelectCalendarType_h */
