//
//  XDJCalendarComponentView.h
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
@interface XDJCalendarComponentView : UIControl

@property (readonly) UILabel *textLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;//用于放农历
@property (copy, nonatomic) UIColor *textColor;
@property (copy, nonatomic) UIColor *highlightTextColor;
@property (nonatomic, copy) UIColor *otherMonthTextColor;
//@property (strong, nonatomic) EKEvent *containingEvent;
@property (strong, nonatomic) id representedObject;

@end
