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

@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UILabel *titleLab;

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
    
    
    
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.selectButton.tintColor = [UIColor grayColor];
    [self.selectButton setBackgroundImage:[[UIImage imageNamed:@"comment_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.selectButton setBackgroundImage:[[UIImage imageNamed:@"comment_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
    [self.selectButton addTarget:self action:@selector(selectButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];

}

- (void)selectButtonDidTap:(UIButton*)btn {
    btn.selected = !btn.selected;
    
}

@end
