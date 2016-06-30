//
//  ViewController.m
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "ViewController.h"
#import "XDJCalendarView.h"
#import "XDJCalendarPickView.h"
#import "XDJCalendarSelectVIew.h"
#import <Masonry.h>

@interface ViewController () <XDJCalendarPickViewDelegate,XDJCalendarSelectViewDelegate>

@property (strong, nonatomic) XDJCalendarView *calendarView;
@property (nonatomic, strong) XDJCalendarPickView *pickView;
@property (nonatomic, strong) XDJCalendarSelectVIew *selectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendarView = [[XDJCalendarView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 350) NeedDisplayCalendarNavgationBar:YES];//YES 有自定义的显示月份标题   
    [self.view addSubview:self.calendarView];
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    //下部分
    self.selectView = [[XDJCalendarSelectVIew alloc] initWithFrame:CGRectMake(0, 380, [UIScreen mainScreen].bounds.size.width, 300)];
    self.selectView.delegate = self;
    [self.view addSubview:self.selectView];
}

- (void)calendarViewDidChange:(id)sender {
    NSLog(@"%@",self.calendarView.selectedDate);
    //显示弹窗
//    [self.pickerView showInView:self.view];
    [self.pickView showInView:self.view];
}

#pragma mark - 代理

- (void)calendarSelectViewAllDataOff {
    
}

- (void)calendarSelectViewDataChange:(BOOL)isOn type:(XDJCalendarSelectViewType)type {
//    if (isOn) {
        [self.calendarView setComponentViewsSelect:isOn];
//    }
}

- (void)titleCalendarPickerView:(XDJCalendarPickView *)pickerView didSelectRowResult:(id)result {
    
    NSLog(@"%@",result);
    
}

- (XDJCalendarPickView *)pickView{
    if (!_pickView) {
       XDJCalendarPickView *cell = [[XDJCalendarPickView alloc] initWithTitleStr:@[@"早上",@"中午",@"晚上"] frame: self.view.bounds];
        _pickView = cell;
        cell.delegate = self;
    }
    return _pickView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
