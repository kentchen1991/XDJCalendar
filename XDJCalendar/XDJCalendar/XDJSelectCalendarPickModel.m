//
//  XDJSelectCalendarPickModel.m
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJSelectCalendarPickModel.h"

@implementation XDJSelectCalendarPickModel

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName isOn:(BOOL)isOn type:(XDJCalendarSelectViewType)type {
    if (self = [super init]) {
        self.title = title;
        self.imageName = imageName;
        self.isOn = isOn;
        self.type = type;
    }
    return self;
}

@end
