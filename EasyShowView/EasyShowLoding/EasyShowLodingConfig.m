//
//  EasyShowLodingConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/4.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyShowLodingConfig.h"

@implementation EasyShowLodingConfig


+ (instancetype)configInView:(UIView *)superView
{
    return [self configInView:superView
                 superReceive:EasyUndefine];
}
+ (instancetype)configInView:(UIView *)superView
                superReceive:(BOOL)receive
{
    return [self configInView:superView
                 superReceive:receive
                     showType:EasyUndefine];
}
+ (instancetype)configInView:(UIView *)superView
                superReceive:(BOOL)receive
                    showType:(LodingShowType)showType
{
    return [self configInView:superView
                 superReceive:receive
                     showType:showType
                animationType:EasyUndefine];
}
+ (instancetype)configInView:(UIView *)superView
                superReceive:(BOOL)receive
                    showType:(LodingShowType)showType
               animationType:(lodingAnimationType)animationType
{
    EasyShowLodingConfig *config = [[EasyShowLodingConfig alloc]init];
    config.superView = superView ;
    config.superReceiveEvent = receive ;
    config.lodingType = showType ;
    config.animationType = animationType ;
    return config ;
}
@end
