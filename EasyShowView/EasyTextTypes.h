//
//  EasyTextTypes.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/13.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


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
typedef NS_ENUM(NSInteger , TextStatusType) {
    TextStatusTypeUndefine = 0 ,  /** 未定义 */
    TextStatusTypeTop = 1 ,
    TextStatusTypeMidden ,
    TextStatusTypeBottom,
    TextStatusTypeStatusBar ,//在statusbar上显示
    TextStatusTypeNavigation ,//在navigation上显示
};

/**
 * 文字展示时的动画类型
 */
typedef NS_ENUM(NSInteger , TextAnimationType) {
    TextAnimationTypeUndefine = 0 ,  /** 未定义 */
    TextAnimationTypeNone ,//无动画
    TextAnimationTypeFade,//alpha改变
    TextAnimationTypeBounce ,//抖动
};


UIKIT_EXTERN const CGFloat TextShowMaxTime ;//最大的显示时长。显示的时长为字符串长度成比例。但是不会超过设置的此时间长度(默认为6秒)
UIKIT_EXTERN const CGFloat TextShowMaxWidth ;//文字显示的最大宽度


UIKIT_EXTERN const CGFloat EasyDrawImageWH ;
UIKIT_EXTERN const CGFloat EasyDrawImageEdge ;
UIKIT_EXTERN const CGFloat EasyTextShowEdge ;
UIKIT_EXTERN const CGFloat EasyShowViewMinWidth ;

UIKIT_EXTERN NSString *const EasyShowViewDidlDismissNotification;


@interface EasyTextTypes : NSObject

@end
