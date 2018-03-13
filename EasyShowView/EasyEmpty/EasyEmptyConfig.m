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
+ (instancetype)configWithBgColor:(UIColor *)bgColor
{
    return [self configWithBgColor:bgColor titleFount:nil];
}
+ (instancetype)configWithBgColor:(UIColor *)bgColor titleFount:(UIFont *)titleFount
{
    return [self shared] ;
}
@end
