//
//  XDJPickerView.m
//  demo
//
//  Created by jolin on 16/3/14.
//  Copyright © 2016年 jolin. All rights reserved.
//

#import "XDJCalendarPickerView.h"
#import "UIView+Frame.h"

#define screen_height [UIScreen mainScreen].bounds.size.height
#define screen_width [UIScreen mainScreen].bounds.size.width

@interface XDJCalendarPickerView ()

@property (nonatomic, weak) UIView *containerView; //背景
@property (nonatomic, weak) UIView *titleView;//上部分标题
@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, strong, readwrite) NSArray *pickerStrings;


@end

@implementation XDJCalendarPickerView

- (instancetype)initPickerViewWithPickerStrings:(NSArray *)pickerStrings {
    if (self = [super init]) {
        _pickerStrings = pickerStrings;
        [self setupSubView];
      
    }
    return self;
}

- (void)setupSubView{
    
    UIButton *cancelButton = [self buttonWithTile:@"取消" selector:@selector(cancelButtonClicked:)];
    cancelButton.x = 10;
    cancelButton.y = 0;
    cancelButton.size = CGSizeMake(44, 44);
    
    
    UIButton *sureButton = [self buttonWithTile:@"完成" selector:@selector(sureButtonClicked:)];
    sureButton.x = self.containerView.width - sureButton.width - 10;
    sureButton.y = 0;
    sureButton.size = CGSizeMake(44, 44);
    
    UIView *titleView = [[UIView alloc] initWithFrame:(CGRect){0, 0, self.containerView.width, 44}];
    titleView.backgroundColor = [UIColor whiteColor];
    self.titleView = titleView;
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:titleView.bounds];
    titleLable.height = 44;
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.textAlignment = NSTextAlignmentLeft;
    self.titleLable = titleLable;
    
    [titleView addSubview:titleLable];

    [titleView addSubview:cancelButton];
    [titleView addSubview:sureButton];
    [titleView setBackgroundColor:[UIColor colorWithRed:248/255.0f green:249/255.0f blue:255/255.0f alpha:1]];
    
    [self.containerView  addSubview:titleView];
}


#pragma mark - event response
- (void)cancelButtonClicked:(UIButton *) button{
    if ([self.delegate respondsToSelector:@selector(calendarPickerView:didClickedCancelButtun:)]) {
        [self.delegate calendarPickerView:self didClickedCancelButtun:button];
    }
    [self hide];
}


- (void)sureButtonClicked:(UIButton *) button{
    if ([self.delegate respondsToSelector:@selector(titleCalendarPickerView:didSelectRowResult:)]) {
    }
    [self hide];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hide];
}

#pragma mark - private methods
- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.alpha = 0;
        self.containerView.y = screen_height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIButton *)buttonWithTile:(NSString *)title selector:(SEL)selector{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - public methods
- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window endEditing:YES];
    [window addSubview:self];
    self.frame = window.bounds;
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.alpha = 1;
        self.containerView.y = screen_height - self.containerView.height;
    }];
    
}


#pragma mark - getters and setters
- (UIView *)containerView {
    if (!_containerView) {
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height, screen_width, 176) ];
        containerView.backgroundColor = [UIColor whiteColor];
        containerView.alpha = 0;
        
        [self addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLable.text = title;
}


@end
