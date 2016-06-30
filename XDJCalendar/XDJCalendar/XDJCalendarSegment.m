//
//  XDJCalendarSegment.m
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJCalendarSegment.h"

@implementation XDJCalendarSegment

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super initWithItems:items];
    if (self) {
        [self setBackgroundImage:[self imageFromColor:[UIColor lightGrayColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:[self imageFromColor:[UIColor orangeColor]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setDividerImage:[UIImage new] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setTintColor:[UIColor whiteColor]];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
