//
//  EasyShowEmptyView.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/1/16.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EasyShowEmptyView ;

typedef NS_ENUM(NSUInteger , callbackType) {
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

typedef void (^emptyViewCallback)(EasyShowEmptyView *view , UIButton *button , callbackType callbackType);

@interface EasyShowEmptyView : UIScrollView

//+ (instancetype)emptyViewWithDict:(NSDictionary *)dict
//                           callback:(emptyViewCallback)callback ;

/**
 * 标题
 */
+ (void)showEmptyViewWithTitle:(NSString *)title
                        inview:(UIView *)superView;

/**
 * 图片
 */
+ (void)showEmptyViewWithImageName:(NSString *)imageName
                            inview:(UIView *)superView ;

/**
 * 标题 副标题
 */
+ (void)showEmptyViewWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                        inview:(UIView *)superView  ;

/**
 * 标题 副标题 图片
 */
+ (void)showEmptyViewWithtitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                     imageName:(NSString *)imageName
                        inview:(UIView *)superView;

/**
 * 标题 副标题 图片 回调
 */
+ (void)showEmptyViewWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                     imageName:(NSString *)imageName
                        inview:(UIView *)superView
                      callback:(emptyViewCallback)callback;

/**
 * 标题 副标题 图片 按钮 回调
 */
+ (void)showEmptyViewWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle
                     imageName:(NSString *)imageName
              buttonTitleArray:(NSArray *)buttonTitleArray
                        inview:(UIView *)superView
                      callback:(emptyViewCallback)callback;


/**
 * 隐藏空页面展示视图
 */
+ (void)hiddenEmptyView:(UIView *)superView ;


/**
 * 敬请期待
 */
+ (void)showEmptyViewLodingWithTitle:(NSString *)title
                            callback:(emptyViewCallback)callback ;

/**
 * 敬请期待
 */
+ (void)showEmptyViewLodingWithImageName:(NSString *)imageName
                                callback:(emptyViewCallback)callback ;


@end
