//
//  EasyShowTextView.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyShowTextConfig.h"

@interface EasyShowTextView : UIView

/**
 * 显示一个纯文字消息 config为配置信息，详解请看demo
 */
+ (void)showText:(NSString *)text ;
+ (void)showText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config ;

/**
 * 显示一个成功消息
 */
+ (void)showSuccessText:(NSString *)text ;
+ (void)showSuccessText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config ;

/**
 * 显示一个错误消息
 */
+ (void)showErrorText:(NSString *)text ;
+ (void)showErrorText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config ;

/**
 * 显示一个提示消息
 */
+ (void)showInfoText:(NSString *)text ;
+ (void)showInfoText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config ;

/**
 * 显示一个自定义图片消息
 */
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName ;
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName config:(EasyShowTextConfig *(^)(void))config ;


//NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, "请使用+ (void)showText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config ;")
+ (void)showText:(NSString *)text inView:(UIView *)view ;
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView ;
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView ;
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView ;
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName inView:(UIView *)superView ;

@end
