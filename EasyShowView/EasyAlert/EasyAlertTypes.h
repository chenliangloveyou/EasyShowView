//
//  EasyAlertTypes.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/13.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 添加一个item的样式，只有color和blod可选
 */
typedef NS_ENUM(NSInteger, ShowAlertItemType) {
    ShowAlertItemTypeBlack = 1,  // 黑色字体
    ShowAlertItemTypeBlodBlack , // 黑色加粗字体
    ShowAlertItemTypeBlue,       // 蓝色字体
    ShowAlertItemTypeBlodBlue,   // 蓝色加粗字体
    ShowAlertItemTypeRed   ,     // 红色字体
    ShowAlertItemTypeBlodRed ,   // 红色加粗字体
    ShowStatusTextTypeCustom     //自定义的一种自己，需要在EasyShowOptions中配置，如果不配置将会是第一种(黑色字体)
};

/**
 * alertView的动画形式
 */
typedef NS_ENUM(NSInteger , alertAnimationType) {
    alertAnimationTypeNone ,//无动画
    alertAnimationTypeFade,//alpha改变
    alertAnimationTypeBounce ,//抖动
    alertAnimationTypeZoom, //放大缩小
    alertAnimationTypePush ,//向上push
};


@interface EasyAlertTypes : NSObject

@end
