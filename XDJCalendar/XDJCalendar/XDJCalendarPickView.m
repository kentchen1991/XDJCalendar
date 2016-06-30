//
//  XDJCalendarPickView.m
//  XDJCalendar
//
//  Created by csh on 16/6/30.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJCalendarPickView.h"
#import "XDJCalendarPickCell.h"
#import <Masonry.h>
#import "UIView+Frame.h"

@interface  XDJCalendarPickView ()

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIView *contentV;
@property (strong, nonatomic) UIButton *titleView;
@property (nonatomic, strong) NSArray<NSString*> *titleS;
@property (nonatomic, strong) NSMutableArray *selectTitle;
@property (nonatomic, strong) NSMutableArray<XDJCalendarPickCell*> *cellViewArr;

@end

@implementation XDJCalendarPickView

- (instancetype)initWithTitleStr:(NSArray*)titleS frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleS = titleS;
        _selectTitle = [NSMutableArray arrayWithCapacity:10];
        _cellViewArr = [NSMutableArray arrayWithCapacity:10];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.bgView = [[UIView alloc] initWithFrame:self.bounds];
    self.bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selfDismiss)];
    [self.bgView addGestureRecognizer:tap];
    
    self.contentV = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 176, self.width, 176)];
    [self.bgView addSubview:self.contentV];
    self.contentV.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancelButton = [self buttonWithTile:@"取消" selector:@selector(cancelButtonClicked:)];
    cancelButton.x = 10;
    cancelButton.y = 0;
    cancelButton.size = CGSizeMake(44, 44);
    
    UIButton *sureButton = [self buttonWithTile:@"完成" selector:@selector(sureButtonClicked:)];
    sureButton.x = self.width - sureButton.width - 10;
    sureButton.y = 0;
    sureButton.size = CGSizeMake(44, 44);
    [self.contentV addSubview:cancelButton];
    [self.contentV addSubview:sureButton];
    
    [self.titleS enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XDJCalendarPickCell *cell = [[XDJCalendarPickCell alloc] init];
        cell.tag = idx + 1;// 从1开始tag
        cell.frame = CGRectMake(0, (idx+1)*44, self.width, 44);
        [cell setTitleStr:obj];
        [self.contentV addSubview:cell];
        [cell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventValueChanged];
        [self.cellViewArr addObject:cell];
    }];
}

- (void)cellClick:(XDJCalendarPickCell*)cell {
    if (cell.selected) {
        [self.selectTitle addObject:cell.currentTitle];
    }else {
        [self.selectTitle removeObject:cell.currentTitle];
    }
}

- (void)showInView:(UIView*)superView {
    [superView addSubview:self];
    _selectTitle = [NSMutableArray arrayWithCapacity:10];//每次显示都初始化数据
    self.transform = CGAffineTransformMakeTranslation(0, self.height/3);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - event response
- (void)cancelButtonClicked:(UIButton *) button {
    [self selfDismiss];
}

- (void)sureButtonClicked:(UIButton *) button {
    [self selfDismiss];
    if ([self.delegate respondsToSelector:@selector(titleCalendarPickerView:didSelectRowResult:)]) {
        [self.delegate titleCalendarPickerView:self didSelectRowResult:self.selectTitle];
    }
}


- (void)selfDismiss {
    [self.cellViewArr enumerateObjectsUsingBlock:^(XDJCalendarPickCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj restoreView];
    }];
    self.transform = CGAffineTransformMakeTranslation(0, 0);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        //回调代理
    }];
}

- (UIButton *)buttonWithTile:(NSString *)title selector:(SEL)selector{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
