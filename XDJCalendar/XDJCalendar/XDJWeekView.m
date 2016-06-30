//
//  XDJWeekView.m
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJWeekView.h"
#import <Masonry.h>

@interface XDJWeekView ()
@property (nonatomic, readwrite ,strong) NSArray <NSString*> *weekArr;
@end

@implementation XDJWeekView

- (instancetype)initWithWeekNameArr:(NSArray<NSString*>*)weekArr {
    XDJWeekView *weekView =  [self init];
    weekView.weekArr = weekArr;
    [self setTitleForLab];
    return weekView;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        for (int i = XDJWeekSun; i <= XDJWeekSat; i++) {
            UILabel *weekdayLabel      = [[UILabel alloc] init];
            weekdayLabel.tag           = i;
            weekdayLabel.textAlignment = NSTextAlignmentCenter;
            weekdayLabel.font = [UIFont systemFontOfSize:11];
            [self addSubview:weekdayLabel];
            
            if (i == 1) {
                [weekdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    //                make.centerY.equalTo(self.mas_centerY);
                    make.top.equalTo(self.mas_top);
                    make.bottom.equalTo(self.mas_bottom);
                    make.width.equalTo(self.mas_width).multipliedBy(0.142);
                    make.left.mas_equalTo(@0);
                }];
            }else{
                UIView *view = [self viewWithTag:i-1];
                [weekdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    //                make.centerY.equalTo(self.mas_centerY);
                    make.top.equalTo(self.mas_top);
                    make.bottom.equalTo(self.mas_bottom);
                    make.width.equalTo(self.mas_width).multipliedBy(0.142);
                    make.left.equalTo(view.mas_right);
                }];
            }
        }
    }
    return self;
}

- (void)setTitleForLab {
    if (!self.weekArr) return;
    for (int i = XDJWeekSun; i <= XDJWeekSat; i++) {
       UILabel *lab = [self viewWithTag:i];
        [lab setText:self.weekArr[i-1]];
    }
}

-(void)setWeekdayHeaderTextColor:(UIColor *)weekdayHeaderTextColor {
    _weekdayHeaderTextColor = weekdayHeaderTextColor;
    for (int i = XDJWeekMon; i <= XDJWeekFri; i++) {
        UILabel *lab = [self viewWithTag:i];
        [lab setTextColor:weekdayHeaderTextColor];
    }
}

-(void)setWeekdayHeaderWeekendTextColor:(UIColor *)weekdayHeaderWeekendTextColor {
    _weekdayHeaderWeekendTextColor = weekdayHeaderWeekendTextColor;
    UILabel *lab = [self viewWithTag:XDJWeekSun];
    [lab setTextColor:weekdayHeaderWeekendTextColor];
    UILabel *labsat = [self viewWithTag:XDJWeekSat];
    [labsat setTextColor:weekdayHeaderWeekendTextColor];
}

@end
