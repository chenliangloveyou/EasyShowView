//
//  UIView+EasyShowExt.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "UIView+EasyShowExt.h"

#import "EasyShowUtils.h"

@implementation UIView (EasyShowExt)

- (CGFloat)easyS_x {
    return self.frame.origin.x;
}
- (void)setEasyS_x:(CGFloat)easyS_x {
    CGRect frame = self.frame;
    frame.origin.x = easyS_x;
    self.frame = frame;
}
- (CGFloat)easyS_y {
    return self.frame.origin.y;
}
- (void)setEasyS_y:(CGFloat)easyS_y {
    CGRect frame = self.frame;
    frame.origin.y = easyS_y;
    self.frame = frame;
}
- (CGFloat)easyS_width {
    return self.frame.size.width;
}

- (void)setEasyS_width:(CGFloat)easyS_width {
    CGRect frame = self.frame;
    frame.size.width = easyS_width;
    self.frame = frame;
}

- (CGFloat)easyS_height {
    return self.frame.size.height;
}

- (void)setEasyS_height:(CGFloat)easyS_height {
    CGRect frame = self.frame;
    frame.size.height = easyS_height;
    self.frame = frame;
}


- (CGFloat)easyS_centerX {
    return self.center.x;
}

- (void)setEasyS_centerX:(CGFloat)easyS_centerX{
    self.center = CGPointMake(easyS_centerX, self.center.y);
}

- (CGFloat)easyS_centerY {
    return self.center.y;
}

- (void)setEasyS_centerY:(CGFloat)easyS_centerY {
    self.center = CGPointMake(self.center.x, easyS_centerY);
}



- (CGFloat)easyS_left {
    return self.frame.origin.x;
}

- (void)setEasyS_left:(CGFloat)easyS_left {
    CGRect frame = self.frame;
    frame.origin.x = easyS_left;
    self.frame = frame;
}

- (CGFloat)easyS_top {
    return self.frame.origin.y;
}

- (void)setEasyS_top:(CGFloat)easyS_top {
    CGRect frame = self.frame;
    frame.origin.y = easyS_top;
    self.frame = frame;
}

- (CGFloat)easyS_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setEasyS_right:(CGFloat)easyS_right {
    CGRect frame = self.frame;
    frame.origin.x = easyS_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)easyS_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setEasyS_bottom:(CGFloat)easyS_bottom {
    CGRect frame = self.frame;
    frame.origin.y = easyS_bottom - frame.size.height;
    self.frame = frame;
}


- (void)setRoundedCorners:(CGFloat)corners
{
    
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corners, 0)];
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = maskPath.CGPath;
    
    self.layer.mask = shapeLayer ;
}

- (void)setRoundedCorners:(UIRectCorner)corners
              borderWidth:(CGFloat)borderWidth
              borderColor:(UIColor *)borderColor
               cornerSize:(CGSize)size
{
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:size];
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor blueColor].CGColor;
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
    if (borderWidth > 0) {
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        
        // 用贝赛尔曲线画线，path 其实是在线的中间，这样会被 layer.mask（遮罩层)遮住一半，故在 halfWidth 处新建 path，刚好产生一个内描边
        CGFloat halfWidth = borderWidth / 2.0f;
        CGRect f = CGRectMake(halfWidth, halfWidth, CGRectGetWidth(self.bounds) - borderWidth, CGRectGetHeight(self.bounds) - borderWidth);
        
        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:f byRoundingCorners:corners cornerRadii:size].CGPath;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = borderColor.CGColor;
        borderLayer.lineWidth = borderWidth;
        borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(f), CGRectGetHeight(f));
        [self.layer addSublayer:borderLayer];
    }
}
@end




















