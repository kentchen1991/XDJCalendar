//
//  XDJCalendarSelectCell.h
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDJCalendarSelectCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id data;
/**
 *  基本设置
 */
- (void)cellSetup;
/**
 *  构建subView
 */
- (void)buildSubViews;
/**
 *  加载数据
 */
- (void)loadData;

@end
