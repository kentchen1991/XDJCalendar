//
//  XDJCalendarView.h
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XDJCalendarComponentView;
@interface XDJCalendarView : UIControl

@property (copy, nonatomic) NSDate *selectedDate;
//@property (assign, nonatomic) BOOL boldPrimaryComponentText;
/**
 *  选中圆圈指示的颜色
 */
@property (copy, nonatomic) UIColor *selectedIndicatorColor;
/**
 *  今天圆圈指示的颜色
 */
@property (copy, nonatomic) UIColor *todayIndicatorColor;
/**
 *  组件普通字体颜色
 */
@property (copy, nonatomic) UIColor *componentTextColor;
/**
 *  组件选中字体颜色
 */
@property (copy, nonatomic) UIColor *highlightedComponentTextColor;

//所有的组件
@property (strong, nonatomic, readonly) NSMutableArray<XDJCalendarComponentView*> *componentViews;
@property (readonly, copy) NSString *navigationBarTitle;
/**
 *  将所有组件都设置红点和取消红点
 */
- (void)setComponentViewsSelect:(BOOL)isSelect;
/**
 *  初始化 并且设置是不是需要展示自定义的日历导航栏 如果不需要 可以通过 navigationBarTitle 来获取标题
 *
 *  @param frame  <#frame description#>
 *  @param isNeed <#isNeed description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame NeedDisplayCalendarNavgationBar:(BOOL)isNeed;
@end
