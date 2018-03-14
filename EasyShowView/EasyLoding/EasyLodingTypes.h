//
//  EasyLodingTypes.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/13.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 加载框的样式
 */
typedef NS_ENUM(NSInteger , LodingShowType) {
    
    LodingShowTypeUnDefine = 0 , /** 未定义 */
    LodingShowTypeTurnAround     = 1 ,  //默认转圈样式
    LodingShowTypeTurnAroundLeft = 2 ,  //默认在左边转圈样式
    
    LodingShowTypeIndicator      = 3 ,  //菊花样式
    LodingShowTypeIndicatorLeft  = 4 ,  //菊花在左边的样式
    
    LodingShowTypePlayImages     = 5 ,  //以一个图片数组轮流播放（需添加一组图片）
    LodingShowTypePlayImagesLeft = 6 ,  //以一个图片数组轮流播放需添加一组图片）
    
    LodingShowTypeImageUpturn    = 7 ,//自定义图片翻转样式
    LodingShowTypeImageUpturnLeft= 8 ,//自动以图片左边翻转样式
    
    LodingShowTypeImageAround    = 9 ,//自定义图片边缘转圈样式
    LodingShowTypeImageAroundLeft= 10 ,//自动以图片左边边缘转圈样式
};

/**
 * 动画类型
 */
typedef NS_ENUM(NSInteger , LodingAnimationType) {
    LodingAnimationTypeUndefine = 0 , /** 未定义 */
    LodingAnimationTypeNone ,//无动画
    LodingAnimationTypeFade,//alpha改变
    LodingAnimationTypeBounce ,//抖动
} ;


UIKIT_EXTERN const CGFloat EasyShowLodingMaxWidth  ;     //显示文字的最大宽度（高度已限制死）
UIKIT_EXTERN const CGFloat EasyShowLodingImageEdge ;    //加载框图片的边距
UIKIT_EXTERN const CGFloat EasyShowLodingImageWH  ;      //加载框图片的大小
UIKIT_EXTERN const CGFloat EasyShowLodingImageMaxWH  ;   //加载框图片的最大宽度

@interface EasyLodingTypes : NSObject

@end
