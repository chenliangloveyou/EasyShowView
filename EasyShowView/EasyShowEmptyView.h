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

+ (void)emptyViewWithTitle:(NSString *)title
                    inview:(UIView *)superView;

+ (void)emptyViewWithImageName:(NSString *)imageName
                        inview:(UIView *)superView ;

+ (void)emptyViewWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                    inview:(UIView *)superView  ;

+ (void)emptyViewWithtitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                 imageName:(NSString *)imageName
                    inview:(UIView *)superView;

+ (void)emptyViewWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                 imageName:(NSString *)imageName
                    inview:(UIView *)superView
                  callback:(emptyViewCallback)callback;

+ (void)emptyViewWithTitle:(NSString *)title
                  subTitle:(NSString *)subTitle
                 imageName:(NSString *)imageName
          buttonTitleArray:(NSArray *)buttonTitleArray
                    inview:(UIView *)superView
                  callback:(emptyViewCallback)callback;



+ (void)emptyViewLodingWithTitle:(NSString *)title
                        callback:(emptyViewCallback)callback ;

+ (void)emptyViewLodingWithImageName:(NSString *)imageName
                            callback:(emptyViewCallback)callback ;

+ (void)hiddenEmptyView:(UIView *)superView ;

@end
