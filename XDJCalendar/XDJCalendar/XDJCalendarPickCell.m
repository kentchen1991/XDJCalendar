//
//  XDJCalendarPickCell.m
//  XDJCalendar
//
//  Created by csh on 16/6/29.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJCalendarPickCell.h"
#import <Masonry.h>

@interface XDJCalendarPickCell()

@property (strong, nonatomic) UILabel *titleLab;
@property (nonatomic, readwrite, copy) NSString *currentTitle;

@end

@implementation XDJCalendarPickCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    self.titleLab = [UILabel new];
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    self.sButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.sButton setBackgroundImage:[UIImage imageNamed:@"comment_normal"]  forState:UIControlStateNormal];
    [self.sButton setBackgroundImage:[UIImage imageNamed:@"comment_select"] forState:UIControlStateSelected];
    [self.sButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sButton];
//    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    [self.sButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];
    self.sButton.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick)];
//    [self addGestureRecognizer:tap];
}

- (void)setTitleStr:(NSString*)title {
    self.titleLab.text = title;
    _currentTitle = title;
}

- (void)btnClick:(UIButton*)btn {
    btn.selected = !btn.selected;
    self.selected = btn.selected;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)restoreView {
    [self.sButton setSelected:NO];
    [self setSelected:NO];
}

@end
