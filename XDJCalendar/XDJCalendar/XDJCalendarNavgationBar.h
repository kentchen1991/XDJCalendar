//
//  XDJNavgationBar.h
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, XDJNaviagationBarCommand) {
    XDJNaviagationBarCommandNoCommand = 0,
    XDJNaviagationBarCommandPrevious,
    XDJNaviagationBarCommandNext
};

@interface XDJCalendarNavgationBar : UIControl

@property (readonly) UILabel *textLabel;

@property (readonly) XDJNaviagationBarCommand lastCommand;

@end
