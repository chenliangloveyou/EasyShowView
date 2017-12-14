//
//  EasyShowTextView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowTextView.h"

@interface EasyShowTextView()


@end

@implementation EasyShowTextView


+ (void)showText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showText:text inView:showView];
}

+ (void)showText:(NSString *)text inView:(UIView *)view
{
    [EasyShowView showToastWithText:text inView:view image:nil stauts:ShowTextStatusPureText];
}

+ (void)showSuccessText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showSuccessText:text inView:showView];
}
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showToastWithText:text inView:superView image:nil stauts:ShowTextStatusSuccess];
}

+ (void)showErrorText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showErrorText:text inView:showView];
}
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showToastWithText:text inView:superView image:nil stauts:ShowTextStatusError];
}

+ (void)showInfoText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showInfoText:text inView:showView];
}
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showToastWithText:text inView:superView image:nil stauts:ShowTextStatusInfo];
}

+ (void)showImageText:(NSString *)text image:(UIImage *)image
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showImageText:text image:image inView:showView] ;
}
+ (void)showImageText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView
{
    [EasyShowView showToastWithText:text inView:superView image:image stauts:ShowTextStatusImage] ;
}

@end
