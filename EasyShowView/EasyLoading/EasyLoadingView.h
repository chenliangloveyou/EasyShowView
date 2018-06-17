//
//  EasyLoadingView.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyLoadingConfig.h"

@interface EasyLoadingView : UIView

/**
 * 显示一个加载框（config：显示属性设置）
 */
+ (EasyLoadingView *)showLoading ;
+ (EasyLoadingView *)showLoadingText:(NSString *)text ;
+ (EasyLoadingView *)showLoadingText:(NSString *)text
                            config:(EasyLoadingConfig *(^)(void))config ;

/**
 * 显示一个带图片的加载框 （config：显示属性设置）
 */
+ (EasyLoadingView *)showLoadingText:(NSString *)text
                         imageName:(NSString *)imageName ;
+ (EasyLoadingView *)showLoadingText:(NSString *)text
                         imageName:(NSString *)imageName
                            config:(EasyLoadingConfig *(^)(void))config ;

/**
 * 移除一个加载框
 * superview:加载框所在的父视图。(如果show没指定父视图。那么隐藏也不用)
 */
+ (void)hidenLoading ;
+ (void)hidenLoingInView:(UIView *)superView ;
+ (void)hidenLoading:(EasyLoadingView *)LoadingView ;


@end
