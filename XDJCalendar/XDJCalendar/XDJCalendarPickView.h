//
//  XDJCalendarPickView.h
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XDJCalendarPickView;

@protocol XDJCalendarPickViewDelegate <NSObject>

@optional

- (void)calendarPickView:(XDJCalendarPickView *)pickerView didClickedCancelButtun:(UIButton *)cancelButton;

- (void)titleCalendarPickerView:(XDJCalendarPickView *)pickerView didSelectRowResult:(id)result;

@end


@interface XDJCalendarPickView : UIView

- (instancetype)initWithTitleStr:(NSArray*)titleS frame:(CGRect)frame;
- (void)showInView:(UIView*)superView;
@property (nonatomic, weak) id <XDJCalendarPickViewDelegate> delegate;

@end
