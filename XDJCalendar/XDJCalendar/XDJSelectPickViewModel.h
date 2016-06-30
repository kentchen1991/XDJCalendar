//
//  XDJSelectPickViewModel.h
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDJSelectCalendarPickModel.h"
//@class XDJSelectCalendarPickModel;

@interface XDJSelectPickViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<XDJSelectCalendarPickModel*> *dataArray;

@end
