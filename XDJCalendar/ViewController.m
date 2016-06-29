//
//  ViewController.m
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "ViewController.h"
#import "XDJCalendarView.h"
#import "XDJCalendarPickerView.h"

@interface ViewController ()<XDJCalendarPickerViewDelegate>

@property (strong, nonatomic) XDJCalendarView *calendarView;
@property (nonatomic, strong) XDJCalendarPickerView *pickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendarView = [[XDJCalendarView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 350)];
    [self.view addSubview:self.calendarView];
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)calendarViewDidChange:(id)sender {
    NSLog(@"%@",self.calendarView.selectedDate);
    //显示弹窗
    [self.pickerView show];
}

- (XDJCalendarPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[XDJCalendarPickerView alloc] initPickerViewWithPickerStrings:@[@"早上",@"下午",@"晚上"]];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (void)calendarPickerView:(XDJCalendarPickerView *)pickerView didClickedCancelButtun:(UIButton *)cancelButton {
    
}

- (void)titleCalendarPickerView:(XDJCalendarPickerView *)pickerView didSelectRowResult:(id)result {
    NSLog(@"%@",result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
