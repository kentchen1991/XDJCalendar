//
//  XDJCalendarSelectVIew.h
//  XDJCalendar
//
//  Created by csh on 16/6/29.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDJCalendarNotif.h"
#import "XDJSelectCalendarType.h"
//typedef NS_ENUM(NSInteger,XDJCalendarSelectViewType) {
//    XDJCalendarSelectViewTypeMonthAll = 1, //全月全选
//    XDJCalendarSelectViewTypeMonthWeekdayMorning ,//工作日上午
//    XDJCalendarSelectViewTypeMonthAllWeekdayAfternoon ,//工作日下午
//    XDJCalendarSelectViewTypeMonthCycleMonth ,//循环全月行程
//};

@protocol XDJCalendarSelectViewDelegate <NSObject>

@optional
- (void)calendarSelectViewDataChange:(BOOL)isOn type:(XDJCalendarSelectViewType)type;
- (void)calendarSelectViewAllDataOff;

@end

@interface XDJCalendarSelectVIew : UIView

@property (nonatomic, weak) id <XDJCalendarSelectViewDelegate>delegate;

@end

