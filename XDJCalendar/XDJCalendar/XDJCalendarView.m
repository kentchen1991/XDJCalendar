//
//  XDJCalendarView.m
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJCalendarView.h"
#import "XDJCalendarNavgationBar.h"
#import "XDJWeekView.h"
#import "XDJCalendarComponentView.h"
#import <Masonry.h>
#import "DAYUtils.h"
#import "XDJIndicatorView.h"

@interface XDJCalendarView()
{
    NSUInteger _visibleYear;
    NSUInteger _visibleMonth;
}
@property (strong, nonatomic) XDJCalendarNavgationBar *navigationBar;
@property (nonatomic, strong) XDJWeekView *weekView;
@property (nonatomic, strong) UIView *contentWrapperView;
@property (nonatomic, strong) UIView *contentView;
@property (strong, nonatomic) NSMutableArray<XDJCalendarComponentView*> *componentViews;
@property (readonly, copy) NSString *navigationBarTitle;
@property (strong, nonatomic) XDJIndicatorView *selectedIndicatorView;
@property (strong, nonatomic) XDJIndicatorView *todayIndicatorView;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end

@implementation XDJCalendarView
#pragma mark - life
- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self reloadViewAnimated:NO];
}


#pragma mark - private

- (void)commonInit {
    self.selectedIndicatorColor = [UIColor colorWithRed:0.74 green:0.18 blue:0.06 alpha:1];
    self.todayIndicatorColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    self.componentTextColor = [UIColor blackColor];
    self.highlightedComponentTextColor = [UIColor whiteColor];
    
    NSDate *todayDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateComponents *comps = [DAYUtils dateComponentsFromDate:todayDate];
    self->_visibleYear = comps.year;
    self->_visibleMonth = comps.month;
    //头部导航
    self.navigationBar = [[XDJCalendarNavgationBar alloc] init];
    self.navigationBar.textLabel.text = @"2016年06月";
    [self.navigationBar setBackgroundColor:[UIColor orangeColor]];
    [self.navigationBar addTarget:self action:@selector(navigationBarButtonDidTap:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.navigationBar];
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.top.mas_equalTo(@0);
        make.height.mas_equalTo(@40);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //周几
    self.weekView = [[XDJWeekView alloc] initWithWeekNameArr:@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]];
    [self.weekView setWeekdayHeaderWeekendTextColor:[UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1]];
    [self.weekView setWeekdayHeaderTextColor:[UIColor colorWithRed:0.75 green:0.25 blue:0.25 alpha:1]];
    
    [self addSubview:self.weekView];
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.top.equalTo(self.navigationBar.mas_bottom);
        make.height.mas_equalTo(@20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //内容
    self.contentWrapperView = [[UIView alloc] init];
    [self addSubview:self.contentWrapperView];
    [self.contentWrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.top.equalTo(self.weekView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    self.contentView = [[UIView alloc] init];
    [self.contentWrapperView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentWrapperView).insets(UIEdgeInsetsZero);
    }];
    self.componentViews = [NSMutableArray array];
    [self setleftAndRightSwipeGesture];
    [self makeUIElements];
    
}

- (void)setleftAndRightSwipeGesture
{
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.contentView addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.contentView addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {//向左 表示查看下个月
        [self jumpToNextMonth];
        
        return;
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {//向右 表示查看上个月
        [self jumpToPreviousMonth];
        
        return;
    }
}


- (void)makeUIElements {

    self.todayIndicatorView = [[XDJIndicatorView alloc] init];
    self.selectedIndicatorView = [[XDJIndicatorView alloc] init];
    [self.contentWrapperView insertSubview:self.todayIndicatorView belowSubview:self.contentView];
    [self.contentWrapperView insertSubview:self.selectedIndicatorView belowSubview:self.contentView];
    self.todayIndicatorView.hidden = YES;
    self.selectedIndicatorView.hidden = YES;
    
    __block NSInteger markTag = 100;
    for (int i = 1; i <= 6; i++) {
        __block UIView *currentRowView;
        currentRowView = [[UIView alloc] init];
        currentRowView.tag = i;
//        currentRowView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:currentRowView];
        if (i == 1) {
            [currentRowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.contentView.mas_width);
                make.height.equalTo(self.contentView.mas_height).multipliedBy(0.167);
                make.top.mas_equalTo(0);
                make.centerX.equalTo(self.contentView.mas_centerX);
            }];
        }else {
            UIView *lastView = [self.contentView viewWithTag:i-1];
            [currentRowView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.contentView.mas_width);
                make.height.equalTo(self.contentView.mas_height).multipliedBy(0.167);
                make.top.equalTo(lastView.mas_bottom);
                make.centerX.equalTo(self.contentView.mas_centerX);
            }];
        }
      
        for (int j = 1; j <= 7; j++) {
            XDJCalendarComponentView *componentView = [[XDJCalendarComponentView alloc] init];
            componentView.tag = j + markTag;
            componentView.textLabel.text = @"11";
            componentView.textLabel.textAlignment = NSTextAlignmentCenter;
            [componentView addTarget:self action:@selector(componentDidTap:) forControlEvents:UIControlEventTouchUpInside];
            [self.componentViews addObject:componentView];
            [currentRowView addSubview:componentView];
            if (j == 1) {
                [componentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(currentRowView.mas_top);
                    make.bottom.equalTo(currentRowView.mas_bottom);
                    make.width.equalTo(currentRowView.mas_width).multipliedBy(0.142);
                    make.left.mas_equalTo(@0);
                }];
            }else {
                UIView *view = [currentRowView viewWithTag:j + markTag -1];
                [componentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(currentRowView.mas_top);
                    make.bottom.equalTo(currentRowView.mas_bottom);
                    make.width.equalTo(currentRowView.mas_width).multipliedBy(0.142);
                    make.left.equalTo(view.mas_right);
                }];
            }
            
        }
        
    }

}

- (void)reloadViewAnimated:(BOOL)animated {
    [self configureIndicatorViews];
    [self configureContentView];
    if (animated) {
        [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil];
    }
}

- (void)configureContentView {
    
    NSUInteger pointer = 0;
    NSUInteger totalDays = [DAYUtils daysInMonth:self->_visibleMonth ofYear:self->_visibleYear];
    NSUInteger paddingDays = [DAYUtils firstWeekdayInMonth:self->_visibleMonth ofYear:self->_visibleYear] - 1;
    
    // Make padding days.
    NSUInteger paddingYear = self->_visibleMonth == 1 ? self->_visibleYear - 1 : self->_visibleYear;
    NSUInteger paddingMonth = self->_visibleMonth == 1 ? 12 : self->_visibleMonth - 1;
    NSUInteger totalDaysInLastMonth = [DAYUtils daysInMonth:paddingMonth ofYear:paddingYear];
    
    for (int j = (int)paddingDays; j > 0; j--) {
        //上个月的显示
        [self configureComponentView:self.componentViews[pointer++] withDay:totalDaysInLastMonth - j + 1  month:paddingMonth year:paddingYear];
        //+ 1 当天也算一天
    }
    
    // Make days in current month.
    for (int j = 0; j < totalDays; j++) {
        [self configureComponentView:self.componentViews[pointer++] withDay:j + 1 month:self->_visibleMonth year:self->_visibleYear];
    }
    
    // Make days in next month to fill the remain cells.
    NSUInteger reserveYear = self->_visibleMonth == 12 ? self->_visibleYear + 1 : self->_visibleYear;
    NSUInteger reserveMonth = self->_visibleMonth == 12 ? 1 : self->_visibleMonth + 1;
    
    for (int j = 0; self.componentViews.count - pointer > 0; j++) {
        [self configureComponentView:self.componentViews[pointer++] withDay:j + 1 month:reserveMonth year:reserveYear];
    }

}
#pragma mark 设置显示的数据
- (void)configureComponentView:(XDJCalendarComponentView *)view withDay:(NSUInteger)day month:(NSUInteger)month year:(NSUInteger)year {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = day;
    comps.month = month;
    comps.year = year;
    view.representedObject = comps; //用于点击组件后传递数据
    view.textColor = self.componentTextColor;
    view.highlightTextColor = self.highlightedComponentTextColor;
    
    //显示今天
    if ([DAYUtils isDateTodayWithDateComponents:comps]) {
        if (self.todayIndicatorView.hidden) {
            self.todayIndicatorView.hidden = NO;
            self.todayIndicatorView.transform = CGAffineTransformMakeScale(0, 0);
            [UIView animateWithDuration:0.3 animations:^{
                self.todayIndicatorView.transform = CGAffineTransformIdentity;
            }];
        }
        self.todayIndicatorView.attachingView = view;
        [self addConstraintToCenterIndicatorView:self.todayIndicatorView toView:view];
    }
    
    // 显示组件view里面的红点 和显示选中后字体颜色的改变
    if (self.selectedIndicatorView && self.selectedIndicatorView.attachingView == view) {
        [view setSelected:YES];
    }
    else {
        [view setSelected:NO];
    }
 
    //农历
    NSDate *dateFromDateComponentsForDate = [[DAYUtils localCalendar] dateFromComponents:comps];
    view.subTitleLabel.text = [DAYUtils LunarForSolarYear:dateFromDateComponentsForDate];
    
    

    
    if (self->_visibleMonth == month ) {//&& self.boldPrimaryComponentText  本月的颜色
        view.textLabel.font = [UIFont boldSystemFontOfSize:16];
//        [view setTextColor:[UIColor blackColor]];
    }
    else { //其它月份的颜色
        view.textLabel.font = [UIFont systemFontOfSize:16];
        [view setOtherMonthTextColor:[UIColor lightGrayColor]];
    }
    
    view.textLabel.text = [NSString stringWithFormat:@"%d", (int) day];
}

//添加和修改今天或者选中的引导view
- (void)addConstraintToCenterIndicatorView:(UIView *)view toView:(UIView *)toView  {
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(toView.mas_centerX);
        make.centerY.equalTo(toView.mas_centerY);
        make.height.width.equalTo(toView.mas_width).multipliedBy(0.8);
    }];
    
}

- (void)jumpToMonth:(NSUInteger)month year:(NSUInteger)year {
    BOOL direction;
    if (self->_visibleYear == year) {
        direction = month > self->_visibleMonth;
    }
    else {
        direction = year > self->_visibleYear;
    }
    
    self->_visibleMonth = month;
    self->_visibleYear = year;
    self->_selectedDate = nil;
    // Deal with indicator views.
    self.todayIndicatorView.hidden = YES;
    self.todayIndicatorView.attachingView = nil;
    self.selectedIndicatorView.attachingView = nil;
    self.selectedIndicatorView.hidden = YES;
    
    [UIView transitionWithView:self.navigationBar.textLabel duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.navigationBar.textLabel.text = self.navigationBarTitle;
    } completion:nil];
    
    UIView *snapshotView = [self.contentWrapperView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = self.contentWrapperView.frame;
    [self addSubview:snapshotView];
    
    [self configureContentView];
    
    self.contentView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(self.contentView.frame) / 3 * (direction ? 1 : -1));
    self.contentView.alpha = 0;
    
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.72 initialSpringVelocity:0 options:kNilOptions animations:^{
        snapshotView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.contentView.frame) / 2 * (direction ? 1 : -1));
        snapshotView.alpha = 0;
//        
//        self.selectedIndicatorView.transform = CGAffineTransformMakeScale(0, 0);
        
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1;
    } completion:^(BOOL finished) {
        [snapshotView removeFromSuperview];
      
    }];
}

- (void)configureIndicatorViews {
    self.selectedIndicatorView.color = self.selectedIndicatorColor;
    self.todayIndicatorView.color = self.todayIndicatorColor;
}


- (void)jumpToPreviousMonth {
    
    NSUInteger prevMonth;
    NSUInteger prevYear;
    
    if (self->_visibleMonth <= 1) {
        prevMonth = 12;
        prevYear = self->_visibleYear - 1;
    }
    else {
        prevMonth = self->_visibleMonth - 1;
        prevYear = self->_visibleYear;
    }
    
    [self jumpToMonth:prevMonth year:prevYear];
    

}

- (void)jumpToNextMonth {
    NSUInteger nextMonth;
    NSUInteger nextYear;
    if (self->_visibleMonth >= 12) {
        nextMonth = 1;
        nextYear = self->_visibleYear + 1;
    }
    else {
        nextMonth = self->_visibleMonth + 1;
        nextYear = self->_visibleYear;
    }
    [self jumpToMonth:nextMonth year:nextYear];
}

#pragma mark - action

- (void)componentDidTap:(XDJCalendarComponentView *)sender {
    NSDateComponents *comps = sender.representedObject;
    
    if (comps.year != self->_visibleYear || comps.month != self->_visibleMonth) {
        [self jumpToMonth:comps.month year:comps.year];
        return;
    }
    if (self.selectedIndicatorView.hidden) {
        self.selectedIndicatorView.hidden = NO;
        self.selectedIndicatorView.transform = CGAffineTransformMakeScale(0, 0);
        self.selectedIndicatorView.attachingView = sender;
        [self addConstraintToCenterIndicatorView:self.selectedIndicatorView toView:sender];
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:kNilOptions animations:^{
            self.selectedIndicatorView.transform = CGAffineTransformIdentity;
            [sender setSelected:YES];
        } completion:nil];
    }
    else {
        [self addConstraintToCenterIndicatorView:self.selectedIndicatorView toView:sender];
        //
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:kNilOptions animations:^{
            [self.contentWrapperView layoutIfNeeded];
            
            [((XDJCalendarComponentView *) self.selectedIndicatorView.attachingView) setSelected:NO];
            [sender setSelected:YES];
        } completion:nil];
        //
        self.selectedIndicatorView.attachingView = sender;
    }
    
    self->_selectedDate = [DAYUtils dateFromDateComponents:comps];
    [self sendActionsForControlEvents:UIControlEventValueChanged]; //t -> g   发送给外部监听的
    

}

- (void)navigationBarButtonDidTap:(id)sender {
    switch (self.navigationBar.lastCommand) {
        case XDJNaviagationBarCommandPrevious:
            [self jumpToPreviousMonth];
            break;
        case XDJNaviagationBarCommandNext:
            [self jumpToNextMonth];
            break;
        default:
            break;
    }
}

#pragma mark - getter 
- (NSString *)navigationBarTitle {
    return [NSString stringWithFormat:@"%lu年%lu月", (unsigned long) self->_visibleYear, self->_visibleMonth];
}


@end
