//
//  XDJSelectCalendarPickModel.h
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDJSelectCalendarType.h"

@interface XDJSelectCalendarPickModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic) BOOL isOn;
@property (nonatomic) XDJCalendarSelectViewType type;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName isOn:(BOOL)isOn type:(XDJCalendarSelectViewType)type;

@end
