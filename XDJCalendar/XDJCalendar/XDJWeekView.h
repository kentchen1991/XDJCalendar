//
//  XDJWeekView.h
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XDJWeekMark) {
    XDJWeekSun = 1,
    XDJWeekMon,
    XDJWeekTue,
    XDJWeekWed,
    XDJWeekThu,
    XDJWeekFri,
    XDJWeekSat
};

@interface XDJWeekView : UIView

/**
 *  根据 weekArr设置周几的显示内容
 */
- (instancetype)initWithWeekNameArr:(NSArray<NSString*>*)weekArr;
@property (nonatomic, readonly) NSArray <NSString*> *weekArr;
@property (nonatomic, strong) UIColor *weekdayHeaderTextColor;
@property (nonatomic, strong) UIColor *weekdayHeaderWeekendTextColor;

@end
