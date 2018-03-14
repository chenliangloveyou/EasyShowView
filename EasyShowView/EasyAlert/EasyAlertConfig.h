//
//  EasyAlertConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EasyAlertTypes.h"
@interface EasyAlertConfig : NSObject


/**
 * alertview的背景颜色
 */
@property (nonatomic,strong)UIColor *tintColor ;

/**
 * title的字体颜色
 */
@property (nonatomic,strong)UIColor *titleColor ;

/**
 * subtitle的字体颜色
 */
@property (nonatomic,strong)UIColor *subtitleColor ;

/**
 * 当alertview为两个的时候，是否横着摆放
 */
@property (nonatomic,assign)BOOL alertTowItemHorizontal ;

/**
 * alertView:展示和消失的动画类型。(只对自定义的alertview起作用)
 */
@property (nonatomic,assign)alertAnimationType alertAnimationType ;

/**
 * 点击alertview之外的空白区域，是否销毁alertview。默认为:NO
 */
@property (nonatomic,assign)BOOL bgViewReceiveEvent ;
/**
 * 允许出现alertView的最大数量
 */
@property (nonatomic,assign)NSUInteger alertViewMaxNum ;

@property (nonatomic, assign) BOOL isSupportRotating;

+ (instancetype)shared ;

- (EasyAlertConfig *(^)(UIColor *))setTintColor;
- (EasyAlertConfig *(^)(UIColor *))setTitleColor ;
- (EasyAlertConfig *(^)(UIColor *))setSubtitleColor ;
- (EasyAlertConfig *(^)(BOOL))setAlertTowItemHorizontal ;
- (EasyAlertConfig *(^)(alertAnimationType))setAlertAnimationType ;
- (EasyAlertConfig *(^)(BOOL))setBgViewReceiveEvent ;
- (EasyAlertConfig *(^)(NSUInteger))setAlertViewMaxNum ;

@end
