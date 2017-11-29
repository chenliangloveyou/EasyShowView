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


typedef NS_ENUM(NSInteger, ShowStatus) {
    
    ShowStatusText ,    /** 纯文字 */
    ShowStatusSuccess, /** 成功 */
    ShowStatusError,   /** 失败 */
    ShowStatusInfo,    /** 提示 */
    ShowStatusImage,   /** 自定义图片 */
    ShowStatusLoding,  /** 正在加载 */
};

/**
 * 纯显示文字，设置文字的位置
 */
typedef NS_ENUM(NSUInteger , ShowStatusTextType) {
    ShowStatusTextTypeTop = 0 ,
    ShowStatusTextTypeMidden ,
    ShowStatusTextTypeBottom,
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
    
};

#define kDrawImageWH 40     //显示图片的宽高
#define KDrawImageEdgeH 15      //显示图片的边距
#define kTextShowEdgeDistance 50 //显示纯文字时，当设置top和bottom的时候，距离屏幕上下的距离

#define kShowViewMinWidth 60 //视图最小的宽度

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
@property CGFloat showAnimationDuration;//展示动画的时间

@property ShowStatusTextType textStatusType ;//显示文字的时候，显示在哪个地方

@property ShowLodingType showLodingType ;//加载框的显示样式

singleton_interface(EasyShowOptions)

@end






