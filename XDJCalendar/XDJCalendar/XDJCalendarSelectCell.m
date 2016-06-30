//
//  XDJCalendarSelectCell.m
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJCalendarSelectCell.h"
#import "XDJCalendarSegment.h"
#import "XDJSelectCalendarPickModel.h"

NSString *const XDJCalendarSegmentClick = @"XDJCalendarSegmentClick";

@interface XDJCalendarSelectCell()

@property (nonatomic, strong) XDJCalendarSegment *segment;

@end

@implementation XDJCalendarSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self cellSetup];
        
        [self buildSubViews];
    }
    
    return self;
}

- (void)cellSetup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.segment = [[XDJCalendarSegment alloc] initWithItems:@[@"是",@"否"]];
    self.segment.frame = CGRectMake(0, 0, 100, 30);
    //默认选择
    self.segment.selectedSegmentIndex = 1;
    //设置背景色
    //设置监听事件
    [self.segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = self.segment;
   
}

- (void)change:(XDJCalendarSegment*)seg {
    
    XDJSelectCalendarPickModel *model = self.data;
    model.isOn = seg.selectedSegmentIndex == 0 ? YES:NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:XDJCalendarSegmentClick object:model];
    
}

- (void)buildSubViews {
    
}

- (void)loadData {
    XDJSelectCalendarPickModel *model = self.data;
    self.textLabel.text = model.title;
    self.imageView.image = [UIImage imageNamed:model.imageName];
    self.segment.selectedSegmentIndex = model.isOn ? 0:1;
}

@end
