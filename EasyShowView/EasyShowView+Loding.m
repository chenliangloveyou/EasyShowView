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
    [EasyShowView showLodingText:@"加载中..."];
}
+ (void)showLodingText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showLodingText:text inView:showView];
}
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView image:nil stauts:ShowStatusLoding];
}
+ (void)showLodingText:(NSString *)text image:(UIImage *)image
{
    
}
+ (void)showLodingText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView
{
    
}
+ (void)hidenLoding
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
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
