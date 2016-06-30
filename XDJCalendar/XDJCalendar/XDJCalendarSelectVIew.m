//
//  XDJCalendarSelectVIew.m
//  XDJCalendar
//
//  Created by csh on 16/6/29.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJCalendarSelectVIew.h"
#import "XDJCalendarSelectCell.h"
#import "XDJSelectPickViewModel.h"


@interface XDJCalendarSelectVIew() <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) XDJSelectPickViewModel *viewModel;

@end

@implementation XDJCalendarSelectVIew

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self addSubview:self.tableview];
    _tableview.rowHeight = 44;
    [self.tableview registerClass:[XDJCalendarSelectCell class] forCellReuseIdentifier:@"cell"];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isOnClick:) name:XDJCalendarSegmentClick object:nil];
}


- (void)isOnClick:(NSNotification*)notif { //点击选项按钮 触发
    XDJSelectCalendarPickModel *model = [notif object];
    //数据改变触发事件
    if ([self.delegate respondsToSelector:@selector(calendarSelectViewDataChange:type:)]) {
        [self.delegate calendarSelectViewDataChange:model.isOn type:model.type];
    }
    
}

- (void)loadData {
    self.viewModel = [[XDJSelectPickViewModel alloc] init];
    self.viewModel.dataArray = [NSMutableArray arrayWithCapacity:10];
    XDJSelectCalendarPickModel *model1 = [[XDJSelectCalendarPickModel alloc] initWithTitle:@"全月全选" imageName:@"CustomerServices" isOn:YES type:XDJCalendarSelectViewTypeMonthAll];
    XDJSelectCalendarPickModel *model2 = [[XDJSelectCalendarPickModel alloc] initWithTitle:@"所有工作日上午" imageName:@"CustomerServices" isOn:NO type:XDJCalendarSelectViewTypeMonthWeekdayMorning];
    XDJSelectCalendarPickModel *model3 = [[XDJSelectCalendarPickModel alloc] initWithTitle:@"所有工作日下午" imageName:@"CustomerServices" isOn:NO type:XDJCalendarSelectViewTypeMonthAllWeekdayAfternoon];
    XDJSelectCalendarPickModel *model4 = [[XDJSelectCalendarPickModel alloc] initWithTitle:@"循环全月行程" imageName:@"CustomerServices" isOn:NO type:XDJCalendarSelectViewTypeMonthCycleMonth];
    self.viewModel.dataArray = [NSMutableArray arrayWithObjects:model1,model2,model3,model4,nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XDJCalendarSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.data = self.viewModel.dataArray[indexPath.row];
    [cell loadData];
    return cell;
    
}

#pragma mark - getter
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}
@end
