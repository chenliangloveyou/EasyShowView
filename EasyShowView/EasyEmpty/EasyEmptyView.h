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


///**
// * 敬请期待
// */
//+ (void)showEmptyViewLodingWithTitle:(NSString *)title
//                            callback:(emptyViewCallback)callback ;
//
///**
// * 敬请期待
// */
//+ (void)showEmptyViewLodingWithImageName:(NSString *)imageName
//                                callback:(emptyViewCallback)callback ;


@end
