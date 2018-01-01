//
//  EasyShowTypes.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/20.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>


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
 * 文字展示时的动画类型
 */
typedef NS_ENUM(NSUInteger , TextAnimationType) {
    TextAnimationTypeNone ,//无动画
    TextAnimationTypeFade,//alpha改变
    TextAnimationTypeBounce ,//抖动
};


/**
 * 加载框的样式
 */
typedef NS_ENUM(NSUInteger , LodingShowType) {
    
    LodingShowTypeTurnAround     = 0 ,  //默认转圈样式
    LodingShowTypeTurnAroundLeft = 1 ,  //默认在左边转圈样式
    
    LodingShowTypeIndicator      = 2 ,  //菊花样式
    LodingShowTypeIndicatorLeft  = 3 ,  //菊花在左边的样式
    
    LodingShowTypePlayImages     = 4 ,  //以一个图片数组轮流播放（需添加一组图片，在EasyShowOptions中添加）
    LodingShowTypePlayImagesLeft = 5 ,  //以一个图片数组轮流播放需添加一组图片）
    
    LodingShowTypeImageUpturn    = 6 ,//自定义图片翻转样式
    LodingShowTypeImageUpturnLeft= 7 ,//自动以图片左边翻转样式
    
    LodingShowTypeImageAround    = 8 ,//自定义图片边缘转圈样式
    LodingShowTypeImageAroundLeft= 9 ,//自动以图片左边边缘转圈样式
};

/**
 *
 */
typedef NS_ENUM(NSUInteger , lodingAnimationType) {
    lodingAnimationTypeNone ,//无动画
    lodingAnimationTypeFade,//alpha改变
    lodingAnimationTypeBounce ,//抖动
} ;


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

/**
 * alertView的动画形式
 */
typedef NS_ENUM(NSUInteger , alertAnimationType) {
    alertAnimationTypeNone ,//无动画
    alertAnimationTypeFade,//alpha改变
    alertAnimationTypeBounce ,//抖动
    alertAnimationTypeZoom, //放大缩小
    alertAnimationTypePush ,//向上push
};



@interface EasyShowTypes : NSObject

@end
