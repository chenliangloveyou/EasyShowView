//
//  EasyTextGlobalConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyTextTypes.h"
#import "EasyShowUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface EasyTextGlobalConfig : NSObject

// 显示吐丝所需要的父视图(为空将显示在window上)
//@property (nonatomic,strong)UIView *superView UI_APPEARANCE_SELECTOR ;

//显示期间，父视图是否接受事件
@property (nonatomic,assign)BOOL superReceiveEvent UI_APPEARANCE_SELECTOR ;

// 展示/隐藏 动画类型
@property (nonatomic,assign)TextAnimationType animationType UI_APPEARANCE_SELECTOR ;

// 显示吐丝的位置（上、中、下、statusbar上、导航条上）
@property (nonatomic,assign)TextStatusType statusType UI_APPEARANCE_SELECTOR ;

//显示背景颜色
@property (nonatomic,strong)UIColor *bgColor UI_APPEARANCE_SELECTOR ;

//显示文字大小
@property (nonatomic,strong)UIFont  *titleFont UI_APPEARANCE_SELECTOR ;

// 显示文字颜色
@property (nonatomic,strong)UIColor *titleColor UI_APPEARANCE_SELECTOR ;

// 阴影颜色(为clearcolor的时候不显示阴影)
@property (nonatomic,strong)UIColor *shadowColor UI_APPEARANCE_SELECTOR;

//显示文字的时间
@property (nonatomic,copy) float(^textShowTimeBlock)(NSString *text) UI_APPEARANCE_SELECTOR ;

// 吐丝是否系那是到window上，默认为YES 。(如果设置为NO:将显示到最顶层controller上) ---> window和controller的区别。当push到下一个控制器的时候，会不会还在系那是
@property (nonatomic,assign)BOOL showOnWindow UI_APPEARANCE_SELECTOR ;

easyShowView_singleton_interface


/**
 * 是否已经使用了globalConfig，库内部使用
 */
+ (BOOL)isUseTextGlobalConfig ;

@end

NS_ASSUME_NONNULL_END


