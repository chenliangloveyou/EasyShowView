//
//  EasyShowLodingView.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyShowLodingView : UIView

/**
 * 显示一个加载框
 * text:需要显示加载框的字体
 * imageName：需要显示加载框的图片名称
 * superview:加载框所需要的父视图（如果不传会放到window和topviewcontroller上面，在EasyShowOptions里指定）
 *
 * 需要自定义的样式可以在EasyShowOptions里设置
 */
+ (void)showLoding ;
+ (void)showLodingText:(NSString *)text ;
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView ;
+ (void)showLodingText:(NSString *)text imageName:(NSString *)imageName ;
+ (void)showLodingText:(NSString *)text imageName:(NSString *)imageName inView:(UIView *)superView ;


/**
 * 移除一个加载框
 * uperview:加载框所在的父视图。show的时候没有指定父视图。那么隐藏的时候也不用
 */
+ (void)hidenLoding ;
+ (void)hidenLoingInView:(UIView *)superView ;



@end
