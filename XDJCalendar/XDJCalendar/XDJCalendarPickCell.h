//
//  XDJCalendarPickCell.h
//  XDJCalendar
//
//  Created by csh on 16/6/29.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDJCalendarPickCell : UIControl

@property (nonatomic, readonly, copy) NSString *currentTitle;
- (void)setTitleStr:(NSString*)title;
@property (strong, nonatomic) UIButton *sButton;
- (void)restoreView;


@end
