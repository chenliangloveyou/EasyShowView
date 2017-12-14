//
//  EasyShowTextView.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowView.h"

@interface EasyShowTextView : EasyShowView


+ (void)showText:(NSString *)text ;
+ (void)showText:(NSString *)text inView:(UIView *)view ;

+ (void)showSuccessText:(NSString *)text ;
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView ;

+ (void)showErrorText:(NSString *)text ;
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView ;

+ (void)showInfoText:(NSString *)text ;
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView ;

+ (void)showImageText:(NSString *)text image:(UIImage *)image ;
+ (void)showImageText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView ;


@end
