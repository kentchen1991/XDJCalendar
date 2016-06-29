//
//  XDJCalendarView.h
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDJCalendarView : UIControl

@property (copy, nonatomic) NSDate *selectedDate;
//@property (assign, nonatomic) BOOL boldPrimaryComponentText;
/**
 *  选中圆圈指示的颜色
 */
@property (copy, nonatomic) UIColor *selectedIndicatorColor;
/**
 *  今天圆圈指示的颜色
 */
@property (copy, nonatomic) UIColor *todayIndicatorColor;
/**
 *  组件普通字体颜色
 */
@property (copy, nonatomic) UIColor *componentTextColor;
/**
 *  组件选中字体颜色
 */
@property (copy, nonatomic) UIColor *highlightedComponentTextColor;


@end
