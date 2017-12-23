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
#import "EasyShowTypes.h"

UIKIT_EXTERN const CGFloat EasyDrawImageWH ;
UIKIT_EXTERN const CGFloat EasyDrawImageEdge ;
UIKIT_EXTERN const CGFloat EasyTextShowEdge ;
UIKIT_EXTERN const CGFloat EasyShowViewMinWidth ;


UIKIT_EXTERN const CGFloat TextShowMaxTime ;//最大的显示时长。显示的时长为字符串长度成比例。但是不会超过设置的此时间长度(默认为6秒)
UIKIT_EXTERN const CGFloat TextShowMaxWidth ;//文字显示的最大宽度


UIKIT_EXTERN const CGFloat EasyShowLodingMaxWidth  ;     //显示文字的最大宽度（高度已限制死）
UIKIT_EXTERN const CGFloat EasyShowLodingImageEdge ;    //加载框图片的边距
UIKIT_EXTERN const CGFloat EasyShowLodingImageWH  ;      //加载框图片的大小
UIKIT_EXTERN const CGFloat EasyShowLodingImageMaxWH  ;   //加载框图片的最大宽度

UIKIT_EXTERN const CGFloat EasyShowAnimationTime ;//动画时间

UIKIT_EXTERN NSString *const EasyShowViewDidlDismissNotification;


@interface EasyShowOptions : NSObject

+ (instancetype)sharedEasyShowOptions ;

#pragma mark - text 


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
 * 在显示加载框的时候，superview能否接收事件。默认为NO
 */
@property BOOL lodingSuperViewReceiveEvent ;

/**
 * 是否将加载框显示到window上面。默认为NO（此属性只有在不传superview的时候有效）
 * 当为NO： 加载框会遮盖住最上面一个controller的大小。如果lodingSuperViewReceiveEvent为NO,那么superview不接受事件，返回按钮会有效。
 * 当为YES：加载框会在盖住整个window的大小。如果lodingSuperViewReceiveEvent为NO,那么在不隐藏加载框的时候返回事件都会被遮住。
 * 
 */
@property BOOL lodingShowOnWindow ;

/**
 * 圆角大小
 */
@property (nonatomic,assign)CGFloat lodingCycleCornerWidth ;

/**
 *  文字/图片颜色、文字大小、背景颜色
 */
@property (nonatomic,strong)UIColor *lodingTintColor ;
@property (nonatomic,strong)UIFont *lodingTextFount ;
@property (nonatomic,strong)UIColor *lodingBackgroundColor ;

/**
 * 加载框为数组动画的时候，这里是传入图片的数据
 */
@property (nonatomic,strong)NSArray *lodingPlayImagesArray ;


#pragma mark - alert


/**
 *alertview的背景颜色。
 * title/message的字体颜色
 */
@property (nonatomic,strong)UIColor *alertTintColor ;
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


@end






