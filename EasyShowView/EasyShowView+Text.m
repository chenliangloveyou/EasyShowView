//
//  EasyShowView+Text.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/29.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowView+Text.h"

@implementation EasyShowView (Text)


+ (void)showText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showText:text inView:showView];
}

+ (void)showText:(NSString *)text inView:(UIView *)view
{
    [EasyShowView showToastWithText:text inView:view image:nil stauts:ShowTextStatusPureText];
}

+ (void)showSuccessText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showSuccessText:text inView:showView];
}
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showToastWithText:text inView:superView image:nil stauts:ShowTextStatusSuccess];
}

+ (void)showErrorText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showErrorText:text inView:showView];
}
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showToastWithText:text inView:superView image:nil stauts:ShowTextStatusError];
}

+ (void)showInfoText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showInfoText:text inView:showView];
}
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showToastWithText:text inView:superView image:nil stauts:ShowTextStatusInfo];
}

+ (void)showImageText:(NSString *)text image:(UIImage *)image
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showImageText:text image:image inView:showView] ;
}
+ (void)showImageText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView
{
    [EasyShowView showToastWithText:text inView:superView image:image stauts:ShowTextStatusImage] ;
}


@end
