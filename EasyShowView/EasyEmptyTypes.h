//
//  EasyEmptyTypes.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/13.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , callbackType) {
    callbackTypeBgView   = 0,
    callbackTypeButton_1 = 1,
    callbackTypeButton_2 = 2,
};

//typedef NS_ENUM(NSUInteger , emptyViewType) {
//    emptyViewTypeLoading ,
//    emptyViewTypeNoData ,
//    emptyViewTypeNetError ,
////    emptyViewTypeCustom ,
//};

@class EasyEmptyView ;

typedef void (^emptyViewCallback)(EasyEmptyView *view , UIButton *button , callbackType callbackType);



@interface EasyEmptyTypes : NSObject

@end
