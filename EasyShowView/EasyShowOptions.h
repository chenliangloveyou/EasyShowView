//
//  EasyShowOptions.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EasyShowUtils.h"

/**
 * 添加一个item的样式，只有color和blod可选
 */
typedef NS_ENUM(NSInteger, ShowAlertItemType) {
    ShowAlertItemTypeBlack = 0,  // 黑色字体
    ShowAlertItemTypeBlodBlack , // 黑色加粗字体
    ShowAlertItemTypeBlue,       // 蓝色字体
    ShowAlertItemTypeBlodBlue,   // 蓝色加粗字体
    ShowAlertItemTypeRed   ,     // 红色字体
    ShowAlertItemTypeBlodRed ,   // 红色加粗字体
    ShowStatusTextTypeCustom     //自定义的一种自己，需要在EasyShowOptions中配置，如果不配置将会是第一种(黑色字体)
};


//显示类型
typedef NS_ENUM(NSUInteger , ShowType) {
    ShowTypeText ,//显示文字
    ShowTypeLoding,//显示加载
};


typedef NS_ENUM(NSInteger, ShowTextStatus) {
    
    ShowTextStatusPureText ,/** 纯文字 */
    ShowTextStatusSuccess,  /** 成功 */
    ShowTextStatusError,    /** 失败 */
    ShowTextStatusInfo,     /** 提示 */
    ShowTextStatusImage,    /** 自定义图片 */
};

/**
 * 设置文字的位置
 */
typedef NS_ENUM(NSUInteger , ShowTextStatusType) {
    ShowTextStatusTypeTop = 0 ,
    ShowTextStatusTypeMidden ,
    ShowTextStatusTypeBottom,
    ShowTextStatusTypeStatusBar ,//在statusbar上显示
    ShowTextStatusTypeNavigation ,//在navigation上显示
};

/**
 * 加载框的样式
 */
typedef NS_ENUM(NSUInteger , ShowLodingType) {
    ShowLodingTypeDefault , //默认转圈样式
    ShowLodingTypeIndicator ,   //菊花样式
    ShowLodingTypeImage ,//自定义图片转圈样式
    ShowLodingTypeLeftDefault ,//默认在左边转圈样式
    ShowLodingTypeLeftIndicator , //菊花在左边的样式
    ShowLodingTypeLeftImage,//自动以图片左边转圈样式
//    ShowLodingTypeCustomImages ,//以一个图片数组轮流播放
};

UIKIT_EXTERN const CGFloat EasyDrawImageWH ;
UIKIT_EXTERN const CGFloat EasyDrawImageEdge ;
UIKIT_EXTERN const CGFloat EasyTextShowEdge ;
UIKIT_EXTERN const CGFloat EasyShowViewMinWidth ;

UIKIT_EXTERN NSString *const EasyShowViewDidlDismissNotification;


@interface EasyShowOptions : NSObject


@property (nonatomic,strong)UIFont *textFount ;         //文字大小
@property (nonatomic,strong)UIColor *textColor ;        //文字颜色
@property (nonatomic,strong)UIColor *backGroundColor ;  //背景颜色

@property BOOL showShadow ;//是否显示阴影
@property (nonatomic,strong)UIColor *shadowColor ;//阴影颜色

@property CGFloat maxWidthScale ; //文字显示的最大宽度的比例
@property CGFloat maxShowTime ;//最大的显示时长。显示的时长为字符串长度成比例。但是不会超过设置的此时间长度(默认为6秒)
@property BOOL superViewReceiveEvent ;//在显示的期间，superview是否能接接收事件

@property BOOL showStartAnimation ;//是否弹出加载时的动画
@property BOOL showEndAnimation ;//是否弹出移除掉的动画
@property CGFloat showAnimationTime;//展示动画的时间

@property ShowTextStatusType textStatusType ; //显示文字的时候，显示在哪个地方

@property ShowLodingType showLodingType ;//加载框的显示样式

singleton_interface(EasyShowOptions)

@end






