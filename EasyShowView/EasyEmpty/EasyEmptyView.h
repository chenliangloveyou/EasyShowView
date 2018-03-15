//
//  EasyEmptyView.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/1/16.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyEmptyPart.h"
#import "EasyEmptyConfig.h"
#import "EasyEmptyTypes.h"

@interface EasyEmptyView : UIScrollView

+ (void)showEmptyInView:(UIView *)superview
                   item:(EasyEmptyPart *(^)(void))item ;

+ (void)showEmptyInView:(UIView *)superview
                   item:(EasyEmptyPart *(^)(void))item
                 config:(EasyEmptyConfig *(^)(void))config ;

+ (void)showEmptyInView:(UIView *)superview
                   item:(EasyEmptyPart *(^)(void))item
                 config:(EasyEmptyConfig *(^)(void))config
               callback:(emptyViewCallback)callback ;


+ (void)hiddenEmptyView:(UIView *)superView ;

#warning 添加视图出来，可用于直接隐藏


@end
