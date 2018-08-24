//
//  EasyAlertTypes.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/13.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 添加一个item的样式，只有color和blod可选
 */
typedef NS_ENUM(NSInteger, AlertItemType) {
    AlertItemTypeBlack = 1,  // 黑色字体
    AlertItemTypeBlodBlack , // 黑色加粗字体
    AlertItemTypeBlue,       // 蓝色字体
    AlertItemTypeBlodBlue,   // 蓝色加粗字体
    AlertItemTypeRed   ,     // 红色字体
    AlertItemTypeBlodRed ,   // 红色加粗字体
    AlertItemTypeCustom ,    //自定义的一种自己，需要配置，如果不配置将会是第一种(黑色字体)
    
    AlertItemTypeSystemDefault ,
    AlertItemTypeSystemCancel ,
    AlertItemTypeSystemDestructive ,
};

/**
 * alertView的动画形式
 */
typedef NS_ENUM(NSInteger , AlertAnimationType) {
    AlertAnimationTypeUndefine ,//未定义
    AlertAnimationTypeNone ,//无动画
    AlertAnimationTypeFade,//alpha改变
    AlertAnimationTypeBounce ,//抖动
    AlertAnimationTypeZoom, //放大缩小
    AlertAnimationTypePush ,//向上push
};


typedef NS_ENUM(NSInteger , AlertViewType) {
    AlertViewTypeAlert ,   //默认类型
    AlertViewTypeActionSheet ,
    AlertViewTypeSystemAlert ,
    AlertViewTypeSystemActionSheet ,
};

typedef NS_ENUM(NSInteger , AlertBgEffectType) {
    AlertBgEffectTypeUndefine ,   //默认类型
    AlertBgEffectTypeAlphaCover ,
    AlertBgEffectTypeWoolGlass,
};


@class EasyAlertView ;

/**
 * 点击item回调，注意：如果全局和item都有回调，会优先显示全局的回调
 */
typedef void (^AlertCallback)(EasyAlertView *showview , long index);


@interface EasyAlertTypes : NSObject

@end
