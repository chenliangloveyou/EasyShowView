//
//  EasyShowTextConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyShowTypes.h"
@interface EasyShowTextConfig : NSObject

@property (nonatomic,strong)UIView *superView ;
@property (nonatomic,assign)ShowTextSuperReceiveEvent superViewReceiveEvent;
@property (nonatomic,assign)TextAnimationType animationType ;
@property (nonatomic,assign)ShowTextStatusType textStatusType ;

/**
 * 显示大小、文字颜色、背景颜色、阴影颜色(为clearcolor的时候不显示阴影)
 */
@property (nonatomic,strong)UIFont  *textTitleFount ;         //文字大小
@property (nonatomic,strong)UIColor *textTitleColor ;        //文字颜色
@property (nonatomic,strong)UIColor *textBackGroundColor ;  //背景颜色
@property (nonatomic,strong)UIColor *textShadowColor ;//阴影颜色

@property (nonatomic,copy) float(^textShowTimeBlock)(NSString *text) ;


/**
 * superview 显示所需要的父视图
 */
+ (instancetype)configWithSuperView:(UIView *)superView ;

/**
 * superview 显示所需要的父视图
 * receive   在显示的期间，superview是否能接接收事件
 */
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(ShowTextSuperReceiveEvent)receive ;


/**
 * superview 显示所需要的父视图
 * receive   在显示的期间，superview是否能接接收事件
 * animationType 文字展示的动画形式
 */
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(ShowTextSuperReceiveEvent)receive
                      animationType:(TextAnimationType)animationType ;

/**
 * superview 显示所需要的父视图
 * receive   在显示的期间，superview是否能接接收事件
 * animationType 文字展示的动画形式
 * statusType 文字显示所在的位置
 */
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(ShowTextSuperReceiveEvent)receive
                      animationType:(TextAnimationType)animationType
                     textStatusType:(ShowTextStatusType)statusType ;

@end
