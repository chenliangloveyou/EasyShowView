//
//  EasyShowView+Loding.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/29.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowView+Loding.h"

#import "EasyShowOptions.h"

@implementation EasyShowView (Loding)


+ (void)showLoding
{
    [EasyShowView showLodingText:@""];
}
+ (void)showLodingText:(NSString *)text
{
    UIView *showView = kTopViewController.view ;
    [EasyShowView showLodingText:text inView:showView];
}
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showLodingText:text image:nil inView:superView];
}
+ (void)showLodingText:(NSString *)text image:(UIImage *)image
{
    UIView *showView = kTopViewController.view ;
    [EasyShowView showLodingText:text image:image inView:showView];
}
+ (void)showLodingText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView image:image stauts:ShowStatusLoding];
}


+ (void)hidenLoding
{
    UIView *showView = kTopViewController.view ;
    [EasyShowView hidenLoingInView:showView];
}
+ (void)hidenAllLoding
{
    
}
+ (void)hidenLoingInView:(UIView *)superView
{
    NSEnumerator *subviewsEnum = [superView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowView *showView = (EasyShowView *)subview ;
            [showView clearCurrentShow];
        }
    }
}


@end
