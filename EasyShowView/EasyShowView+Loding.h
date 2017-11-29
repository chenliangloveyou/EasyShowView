//
//  EasyShowView+Loding.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/29.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowView.h"

@interface EasyShowView (Loding)


+ (void)showLoding ;
+ (void)showLodingText:(NSString *)text ;
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView ;
+ (void)showLodingText:(NSString *)text image:(UIImage *)image ;
+ (void)showLodingText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView ;

+ (void)showLodingText:(NSString *)text type:(ShowLodingType)lodingType ;


+ (void)hidenLoding ;
+ (void)hidenLoingInView:(UIView *)superView ;
+ (void)hidenAllLoding ;


@end
