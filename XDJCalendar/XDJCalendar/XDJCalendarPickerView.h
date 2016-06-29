//
//  XDJPickerView.h
//  demo
//
//  Created by jolin on 16/3/14.
//  Copyright © 2016年 jolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDJCalendarPickerView;

@protocol XDJCalendarPickerViewDelegate <NSObject>

@optional

- (void)calendarPickerView:(XDJCalendarPickerView *)pickerView didClickedCancelButtun:(UIButton *)cancelButton;

- (void)titleCalendarPickerView:(XDJCalendarPickerView *)pickerView didSelectRowResult:(id)result;

@end

@interface XDJCalendarPickerView : UIView

@property (nonatomic, readonly) NSArray *pickerStrings;

@property (nonatomic, weak) id<XDJCalendarPickerViewDelegate> delegate;

@property (nonatomic, copy) NSString *title;

- (instancetype)initPickerViewWithPickerStrings:(NSArray *)pickerStrings;

- (void)show;

@end
