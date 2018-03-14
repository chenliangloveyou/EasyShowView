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
- (EasyAlertConfig *(^)(BOOL))setAlertTowItemHorizontal
{
    return ^EasyAlertConfig *(BOOL horizontal){
        self.alertTowItemHorizontal = horizontal ;
        return self;
    };
}
- (EasyAlertConfig *(^)(alertAnimationType))setAlertAnimationType
{
    return ^EasyAlertConfig *(alertAnimationType type){
        self.alertAnimationType = type ;
        return self;
    };
}
- (EasyAlertConfig *(^)(BOOL))setBgViewReceiveEvent
{
    return ^EasyAlertConfig *(BOOL receive){
        self.bgViewReceiveEvent = receive ;
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
