//
//  EasyAlertGlobalConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyShowUtils.h"
#import "EasyAlertTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface EasyAlertGlobalConfig : NSObject

//alertview的背景颜色
@property (nonatomic,strong)UIColor *tintColor UI_APPEARANCE_SELECTOR;

//title的字体颜色
@property (nonatomic,strong)UIColor *titleColor UI_APPEARANCE_SELECTOR;

//subtitle的字体颜色
@property (nonatomic,strong)UIColor *subtitleColor UI_APPEARANCE_SELECTOR;

//当alertview为两个的时候，是否横着摆放
@property (nonatomic,assign)BOOL twoItemHorizontal UI_APPEARANCE_SELECTOR;

//alertView:展示和消失的动画类型。(只对自定义的alertview起作用)
@property (nonatomic,assign)AlertAnimationType animationType UI_APPEARANCE_SELECTOR;

//背景的样式。(只对自定义的alertview起作用)
@property (nonatomic,assign)AlertBgEffectType effectType UI_APPEARANCE_SELECTOR;


 //点击alertview之外的空白区域，是否销毁alertview。默认为:NO
@property (nonatomic,assign)BOOL bgViewEvent UI_APPEARANCE_SELECTOR ;

//允许出现alertView的最大数量
@property (nonatomic,assign)NSUInteger alertViewMaxNum UI_APPEARANCE_SELECTOR;

//是否支持横屏
@property (nonatomic,assign)BOOL isSupportRotating UI_APPEARANCE_SELECTOR;

easyShowView_singleton_interface

@end

NS_ASSUME_NONNULL_END

