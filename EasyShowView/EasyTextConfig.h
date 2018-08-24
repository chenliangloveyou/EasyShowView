//
//  EasyTextConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyTextTypes.h"
#import "EasyShowUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface EasyTextConfig : NSObject

// 显示吐丝所需要的父视图(为空将显示在window上)
@property (nonatomic,strong)UIView *superView ;

//显示期间，父视图是否接受事件
@property (nonatomic,assign)BOOL superReceiveEvent ;

// 展示/隐藏 动画类型
@property (nonatomic,assign)TextAnimationType animationType ;

// 显示吐丝的位置（上、中、下、statusbar上、导航条上）
@property (nonatomic,assign)TextStatusType statusType ;

//显示文字大小
@property (nonatomic,strong)UIFont  *titleFont ;

// 显示文字颜色
@property (nonatomic,strong)UIColor *titleColor ;

//显示背景颜色
@property (nonatomic,strong)UIColor *bgColor ;

// 阴影颜色(为clearcolor的时候不显示阴影)
@property (nonatomic,strong)UIColor *shadowColor ;

//显示文字的时间
@property (nonatomic,copy) float(^textShowTimeBlock)(NSString *text) ;


#pragma mark - 创建对象的简便方法

+ (instancetype)shared ;


#pragma mark - 链式编程设置属性(和上面直接设置属性一样)

- (EasyTextConfig *(^)(UIView *))setSuperView ;
- (EasyTextConfig *(^)(BOOL))setSuperReceiveEvent ;
- (EasyTextConfig *(^)(TextAnimationType))setAnimationType ;
- (EasyTextConfig *(^)(TextStatusType))setStatusType ;

- (EasyTextConfig *(^)(UIFont *))setTitleFont ;
- (EasyTextConfig *(^)(UIColor *))setTitleColor ;
- (EasyTextConfig *(^)(UIColor *))setBgColor ;
- (EasyTextConfig *(^)(UIColor *))setShadowColor ;


#pragma mark - 类方法设置属性(和上面直接设置属性一样)

/**
 * superview 显示所需要的父视图
 */
+ (instancetype)configWithSuperView:(UIView *)superView ;

/**
 * superview 显示所需要的父视图
 * receive   在显示的期间，superview是否能接接收事件
 * animationType 文字展示的动画形式
 */
+ (instancetype)configWithSuperView:(UIView *)superView
                      animationType:(TextAnimationType)animationType ;

/**
 * superview 显示所需要的父视图
 * receive   在显示的期间，superview是否能接接收事件
 * animationType 文字展示的动画形式
 * statusType 文字显示所在的位置
 */
+ (instancetype)configWithSuperView:(UIView *)superView
                      animationType:(TextAnimationType)animationType
                         statusType:(TextStatusType)statusType ;

/**
 * superview 显示所需要的父视图
 * receive   在显示的期间，superview是否能接接收事件
 * animationType 文字展示的动画形式
 * statusType 文字显示所在的位置
 */
+ (instancetype)configWithSuperView:(UIView *)superView
                      animationType:(TextAnimationType)animationType
                         statusType:(TextStatusType)statusType
                  superReceiveEvent:(BOOL)receive ;

@end

NS_ASSUME_NONNULL_END

