//
//  EasyEmptyView.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/1/16.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyEmptyItem.h"
#import "EasyEmptyConfig.h"

@class EasyEmptyView ;

typedef NS_ENUM(NSInteger , callbackType) {
    callbackTypeBgView   = 0,
    callbackTypeButton_1 = 1,
    callbackTypeButton_2 = 2,
};

//typedef NS_ENUM(NSUInteger , emptyViewType) {
//    emptyViewTypeLoding ,
//    emptyViewTypeNoData ,
//    emptyViewTypeNetError ,
////    emptyViewTypeCustom ,
//};

typedef void (^emptyViewCallback)(EasyEmptyView *view , UIButton *button , callbackType callbackType);

@interface EasyEmptyView : UIScrollView



+ (void)showEmptyInView:(UIView *)superview
                   item:(EasyEmptyItem *(^)(void))item
                 config:(EasyEmptyConfig *(^)(void))config
               callback:(emptyViewCallback)callback ;

/**
 * 隐藏空页面展示视图
 */
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
