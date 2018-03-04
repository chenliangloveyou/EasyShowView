//
//  EasyShowTextGlobalConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyShowTypes.h"

@interface EasyShowTextGlobalConfig : NSObject
/**
 * 在显示的期间，superview是否能接接收事件
 */
@property BOOL textSuperViewReceiveEvent ;

/**
 * 文字展示的动画形式
 */
@property TextAnimationType textAnimationType ;//

/**
 * /文字的显示样式
 */
@property ShowTextStatusType textStatusType ;

/**
 * 显示大小、文字颜色、背景颜色、阴影颜色(为clearcolor的时候不显示阴影)
 */
@property (nonatomic,strong)UIFont *textTitleFount ;         //文字大小
@property (nonatomic,strong)UIColor *textTitleColor ;        //文字颜色
@property (nonatomic,strong)UIColor *textBackGroundColor ;  //背景颜色
@property (nonatomic,strong)UIColor *textShadowColor ;//阴影颜色

@property (nonatomic,copy) float(^textShowTimeBlock)(NSString *text) ;

+ (instancetype)sharedEasyShowTextGlobalConfig ;


//是否已经使用了globalConfig，库内部使用
+ (BOOL)isUseTextGlobalConfig ;

@end



