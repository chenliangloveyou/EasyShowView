//
//  EasyShowTextGlobalConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyShowTypes.h"
#import "EasyShowUtils.h"


@interface EasyShowTextGlobalConfig : NSObject

/** 吐丝所在的父视图(默认为yes：显示到window上。如果设置为NO:将显示到最顶层控制器上) **/
@property (nonatomic,assign)BOOL showOnWindow ;

/** 显示期间，父视图是否接受事件 **/
@property (nonatomic,assign)BOOL superViewReceiveEvent;

/** 展示/隐藏 动画类型 **/
@property (nonatomic,assign)TextAnimationType animationType ;

/** 显示吐丝的位置（上、中、下、statusbar上、导航条上） **/
@property (nonatomic,assign)ShowTextStatusType textStatusType ;

/** 显示文字大小 **/
@property (nonatomic,strong)UIFont  *titleFont ;

/** 显示文字颜色 **/
@property (nonatomic,strong)UIColor *titleColor ;

/** 显示背景颜色 **/
@property (nonatomic,strong)UIColor *bgColor ;

/** 阴影颜色(为clearcolor的时候不显示阴影) **/
@property (nonatomic,strong)UIColor *shadowColor ;

/** 显示文字的时间 **/
@property (nonatomic,copy) float(^textShowTimeBlock)(NSString *text) ;

easyShowView_singleton_interface

//是否已经使用了globalConfig，库内部使用
+ (BOOL)isUseTextGlobalConfig ;

@end



