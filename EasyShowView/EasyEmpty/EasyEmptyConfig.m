//
//  EasyEmptyConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyEmptyConfig.h"

@implementation EasyEmptyConfig

+ (instancetype)shared
{
    return [[EasyEmptyConfig alloc]init];
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
- (EasyEmptyConfig *(^)(UIEdgeInsets))setButtonEdgeInsets
{
    return ^EasyEmptyConfig *(UIEdgeInsets edge){
        self.buttonEdgeInsets = edge ;
        return self ;
    } ;
}


+ (instancetype)configWithBgColor:(UIColor *)bgColor
{
    return [self configWithBgColor:bgColor titleFount:nil];
}
+ (instancetype)configWithBgColor:(UIColor *)bgColor titleFount:(UIFont *)titleFount
{
    EasyEmptyConfig *config = [self shared] ;
    config.bgColor = bgColor ;
    config.tittleFont = titleFount ;
    return config ;
}
@end
