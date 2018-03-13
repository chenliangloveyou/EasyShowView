//
//  EasyLodingTypes.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/13.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * 加载框的样式
 */
typedef NS_ENUM(NSInteger , LodingShowType) {
    
    LodingShowTypeUnDefine = 0 , /** 未定义 */
    LodingShowTypeTurnAround     = 1 ,  //默认转圈样式
    LodingShowTypeTurnAroundLeft = 2 ,  //默认在左边转圈样式
    
    LodingShowTypeIndicator      = 3 ,  //菊花样式
    LodingShowTypeIndicatorLeft  = 4 ,  //菊花在左边的样式
    
    LodingShowTypePlayImages     = 5 ,  //以一个图片数组轮流播放（需添加一组图片，在EasyShowOptions中添加）
    LodingShowTypePlayImagesLeft = 6 ,  //以一个图片数组轮流播放需添加一组图片）
    
    LodingShowTypeImageUpturn    = 7 ,//自定义图片翻转样式
    LodingShowTypeImageUpturnLeft= 8 ,//自动以图片左边翻转样式
    
    LodingShowTypeImageAround    = 9 ,//自定义图片边缘转圈样式
    LodingShowTypeImageAroundLeft= 10 ,//自动以图片左边边缘转圈样式
};

/**
 * 动画类型
 */
typedef NS_ENUM(NSInteger , lodingAnimationType) {
    lodingAnimationTypeUndefine = 0 , /** 未定义 */
    lodingAnimationTypeNone ,//无动画
    lodingAnimationTypeFade,//alpha改变
    lodingAnimationTypeBounce ,//抖动
} ;



@interface EasyLodingTypes : NSObject

@end
