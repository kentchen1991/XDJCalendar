//
//  XDJIndicatorView.m
//  XDJCalendar
//
//  Created by csh on 16/6/29.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "XDJIndicatorView.h"

@interface XDJIndicatorView ()

@property (strong, nonatomic) CAShapeLayer *ellipseLayer;

@end

@implementation XDJIndicatorView

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    self.ellipseLayer = [CAShapeLayer layer];
    self.ellipseLayer.fillColor = self.color.CGColor;
    [self.layer addSublayer:self.ellipseLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.ellipseLayer.path = CGPathCreateWithEllipseInRect(self.bounds, nil);
    self.ellipseLayer.frame = self.bounds;
}

- (void)setColor:(UIColor *)color {
    self->_color = color;
    self.ellipseLayer.fillColor = color.CGColor;
}


@end
