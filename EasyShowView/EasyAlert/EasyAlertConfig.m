//
//  EasyAlertConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyAlertConfig.h"

@implementation EasyAlertConfig


+ (instancetype)shared
{
    return [[self alloc]init];
}
- (instancetype)init
{
    if (self = [super init]) {
        _alertViewMaxNum = 0 ;
        _twoItemHorizontal  = EasyUndefine ;
        _bgViewEvent = EasyUndefine ;
        _animationType = EasyUndefine ;
        _isSupportRotating = EasyUndefine ;
    }
    return self ;
}

- (EasyAlertConfig *(^)(UIColor *))setTintColor
{
    return ^EasyAlertConfig *(UIColor *tintColor){
        self.tintColor = tintColor ;
        return self;
    };
}
- (EasyAlertConfig *(^)(UIColor *))setTitleColor
{
    return ^EasyAlertConfig *(UIColor *titleColor){
        self.titleColor = titleColor ;
        return self;
    };
}
- (EasyAlertConfig *(^)(UIColor *))setSubtitleColor
{
    return ^EasyAlertConfig *(UIColor *subtitleColor){
        self.subtitleColor = subtitleColor ;
        return self;
    };
}
- (EasyAlertConfig *(^)(BOOL))settwoItemHorizontal
{
    return ^EasyAlertConfig *(BOOL horizontal){
        self.twoItemHorizontal = horizontal ;
        return self;
    };
}
- (EasyAlertConfig *(^)(AlertAnimationType))setAnimationType
{
    return ^EasyAlertConfig *(AlertAnimationType type){
        self.animationType = type ;
        return self;
    };
}
- (EasyAlertConfig *(^)(BOOL))setBgViewEvent
{
    return ^EasyAlertConfig *(BOOL event){
        self.bgViewEvent = event ;
        return self;
    };
}
- (EasyAlertConfig *(^)(NSUInteger))setAlertViewMaxNum
{
    return ^EasyAlertConfig *(NSUInteger maxnum){
        self.alertViewMaxNum = maxnum ;
        return self;
    };
}

@end
