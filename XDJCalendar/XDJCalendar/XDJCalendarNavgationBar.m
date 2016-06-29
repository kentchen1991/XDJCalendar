//
//  XDJNavgationBar.m
//  XDJCalendar
//
//  Created by csh on 16/6/28.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJCalendarNavgationBar.H"
#import <Masonry.h>


@interface XDJCalendarNavgationBar()

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIButton *prevButton;
@property (strong, nonatomic) UIButton *nextButton;
@property (readwrite, assign, nonatomic) XDJNaviagationBarCommand lastCommand;


@end

@implementation XDJCalendarNavgationBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self commonInit];
//    }
//    return self;
//}


- (void)commonInit {
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.textColor = [UIColor colorWithRed:0.29 green:0.29 blue:0.29 alpha:1];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        
    }];

    
    self.prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.prevButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.prevButton.tintColor = [UIColor grayColor];
    [self.prevButton setBackgroundImage:[[UIImage imageNamed:@"prev"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.prevButton addTarget:self action:@selector(prevButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.prevButton];
    
    [self.prevButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textLabel.mas_left).offset(-10);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.tintColor = [UIColor grayColor];
    [self.nextButton setBackgroundImage:[[UIImage imageNamed:@"next"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.nextButton];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(10);
        make.width.mas_equalTo(@30);
        make.height.mas_equalTo(@30);
        make.centerY.equalTo(self.mas_centerY);
    }];
   
}

- (void)prevButtonDidTap:(id)sender {
    self.lastCommand = XDJNaviagationBarCommandPrevious;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)nextButtonDidTap:(id)sender {
    self.lastCommand = XDJNaviagationBarCommandNext;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}



@end
