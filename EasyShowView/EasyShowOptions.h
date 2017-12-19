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
typedef NS_ENUM(NSUInteger , LodingShowType) {
    
    LodingShowTypeTurnAround     = 0 ,  //默认转圈样式
    LodingShowTypeTurnAroundLeft = 1 ,  //默认在左边转圈样式

    LodingShowTypeIndicator      = 2 ,  //菊花样式
    LodingShowTypeIndicatorLeft  = 3 ,  //菊花在左边的样式

    LodingShowTypePlayImages     = 4 ,  //以一个图片数组轮流播放（需添加一组图片）
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

UIKIT_EXTERN const CGFloat EasyDrawImageWH ;
UIKIT_EXTERN const CGFloat EasyDrawImageEdge ;
UIKIT_EXTERN const CGFloat EasyTextShowEdge ;
UIKIT_EXTERN const CGFloat EasyShowViewMinWidth ;


UIKIT_EXTERN const CGFloat EasyShowLodingMaxWidth  ;     //显示文字的最大宽度（高度已限制死）
UIKIT_EXTERN const CGFloat EasyShowLodingImageEdge ;    //加载框图片的边距
UIKIT_EXTERN const CGFloat EasyShowLodingImageWH  ;      //加载框图片的大小
UIKIT_EXTERN const CGFloat EasyShowLodingImageMaxWH  ;   //加载框图片的最大宽度


UIKIT_EXTERN NSString *const EasyShowViewDidlDismissNotification;


@interface EasyShowOptions : NSObject

#pragma mark - text & loding

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

@property ShowTextStatusType textStatusType ; //文字的显示样式


#pragma mark - loding
/**
 * 加载框的显示样式
 */
@property LodingShowType lodingShowType ;

/**
 * 显示/隐藏 加载框的动画
 */
@property lodingAnimationType lodingAnimationType ;

/**
 *  文字/图片颜色
 *  背景颜色
 */
@property (nonatomic,strong)UIColor *lodingTintColor ;
@property (nonatomic,strong)UIColor *lodingBackgroundColor ;

/**
 * 在显示加载框的时候，superview能否接收事件
 */
@property (nonatomic,assign)BOOL lodingSuperViewReceiveEvent ;

@property (nonatomic,strong)NSArray *lodingPlayImagesArray ;

#pragma mark - alert

/**
 * alertview的背景颜色。
 */
@property (nonatomic,strong)UIColor *alertBackgroundColor ;

/**
 * title/message的字体颜色
 */
@property (nonatomic,strong)UIColor *alertTitleColor ;
@property (nonatomic,strong)UIColor *alertMessageColor ;

/**
 * alertView:是两个按钮的时候 横着摆放
 */
@property (nonatomic,assign)BOOL alertTowItemHorizontal ;

/**
 * alertView:展示和消失的动画类型。
 * 当展示的是系统alertview和ActionSheet不起作用
 */
@property (nonatomic,assign)alertAnimationType alertAnimationType ;

/**
 * 点击alertview之外的空白区域，是否销毁alertview。默认为:NO
 *
 * 系统的alert        不可以点击销毁。
 * 系统的ActionSheet  添加UIAlertActionStyleCancel类型就会有点击销毁。没有就不会销毁。
 */
@property (nonatomic,assign)BOOL alertBgViewTapRemove ;

+ (instancetype)sharedEasyShowOptions ;
//singleton_interface(EasyShowOptions)

@end






