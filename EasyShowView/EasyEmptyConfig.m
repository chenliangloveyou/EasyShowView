//
//  EasyEmptyConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyEmptyConfig.h"
#import "EasyEmptyGlobalConfig.h"

@implementation EasyEmptyConfig

+ (instancetype)shared
{
    return [[EasyEmptyConfig alloc]init];
}
- (instancetype)init{
    if ([super init]) {
        EasyEmptyGlobalConfig *globalC = [EasyEmptyGlobalConfig shared] ;
        _scrollVerticalEnable = globalC.scrollVerticalEnable ;
        _easyViewEdgeInsets = UIEdgeInsetsZero ;
    }
    return self ;
}


- (EasyEmptyConfig *(^)(UIColor *))setBgColor
{
    return ^EasyEmptyConfig *(UIColor *bgColor){
        self.bgColor = bgColor ;
        return self ;
    };
}
- (EasyEmptyConfig *(^)(UIFont *))setTitleFont
{
    return ^EasyEmptyConfig *(UIFont *titleFont){
        self.tittleFont = titleFont ;
        return self ;
    } ;
}
- (EasyEmptyConfig *(^)(UIColor *))setTitleColor
{
    return ^EasyEmptyConfig *(UIColor *titleColor){
        self.titleColor = titleColor ;
        return self ;
    } ;
}
- (EasyEmptyConfig *(^)(UIFont *))setSubtitleFont
{
    return ^EasyEmptyConfig *(UIFont *subtitleFont){
        self.subtitleFont = subtitleFont ;
        return self ;
    } ;
}
- (EasyEmptyConfig *(^)(UIColor *))setSubtitleColor
{
    return ^EasyEmptyConfig *(UIColor *titleColor){
        self.subTitleColor = titleColor ;
        return self ;
    } ;
}
- (EasyEmptyConfig *(^)(UIFont *))setButtonFont
{
    return ^EasyEmptyConfig *(UIFont *buttonFont){
        self.buttonFont = buttonFont ;
        return self ;
    } ;
}
- (EasyEmptyConfig *(^)(UIColor *))setButtonColor
{
    return ^EasyEmptyConfig *(UIColor *buttonColor){
        self.buttonColor = buttonColor ;
        return self ;
    } ;
}
- (EasyEmptyConfig *(^)(UIColor *))setButtonBgColor
{
    return ^EasyEmptyConfig *(UIColor *buttonbgColor){
        self.buttonBgColor = buttonbgColor ;
        return self ;
    } ;
}
- (EasyEmptyConfig *(^)(UIEdgeInsets))setEasyViewEdgeInsets
{
    return ^EasyEmptyConfig *(UIEdgeInsets edge){
        self.easyViewEdgeInsets = edge ;
        return self ;
    } ;
}
- (EasyEmptyConfig *(^)(UIEdgeInsets))setButtonEdgeInsets
{
    return ^EasyEmptyConfig *(UIEdgeInsets edge){
        self.buttonEdgeInsets = edge ;
        return self ;
    } ;
}

- (EasyEmptyConfig *(^)(BOOL))setScrollVerticalEnable
{
    return ^EasyEmptyConfig *(BOOL enabel){
        self.scrollVerticalEnable = enabel ;
        return self ;
    } ;
}

+ (instancetype)configWithBgColor:(UIColor *)bgColor
{
    return [self configWithBgColor:bgColor titleFount:[EasyEmptyGlobalConfig shared].tittleFont];
}
+ (instancetype)configWithBgColor:(UIColor *)bgColor titleFount:(UIFont *)titleFount
{
    EasyEmptyConfig *config = [self shared] ;
    config.bgColor = bgColor ;
    config.tittleFont = titleFount ;
    return config ;
}
@end
