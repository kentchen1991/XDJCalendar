//
//  XDJCalendarComponentView.m
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJCalendarComponentView.h"
#import <EventKitUI/EventKitUI.h>
#import <Masonry.h>

@interface XDJCalendarComponentView () //<EKEventViewDelegate>

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIView *dotView;


@end

@implementation XDJCalendarComponentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {

    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textAlignment = 1;
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textAlignment = 1;
    self.subTitleLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.textLabel];
    [self addSubview:self.subTitleLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).multipliedBy(0.8);//在中心点网上一部分
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.4);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel.mas_bottom);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.2);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
  
    self.dotView = [[UIView alloc] init];
    self.dotView.layer.cornerRadius = 5;
    self.dotView.hidden = arc4random()%2;
    [self addSubview:self.dotView];
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo(@10);
        make.height.mas_equalTo(@10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    
    UITapGestureRecognizer *aRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTap:)];
    [self addGestureRecognizer:aRecognizer];
    
  
}

-(void)setSelected:(BOOL)selected {
    if (selected) {
        self.textLabel.textColor = self.highlightTextColor;
        self.subTitleLabel.textColor = self.highlightTextColor;
        self.dotView.backgroundColor = self.highlightTextColor;
    }
    else {
        self.textLabel.textColor = self.textColor;
        self.subTitleLabel.textColor = self.textColor;
        self.dotView.backgroundColor = [UIColor redColor];
    }
}

-(void)setOtherMonthTextColor:(UIColor *)otherMonthTextColor {
    _textColor = otherMonthTextColor;
    self.textLabel.textColor = otherMonthTextColor;
    self.subTitleLabel.textColor = otherMonthTextColor;
}
//

- (void)viewDidTap:(id)sender {
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}


@end
