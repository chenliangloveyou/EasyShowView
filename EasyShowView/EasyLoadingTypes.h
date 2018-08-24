//
//  EasyLoadingTypes.h
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
typedef NS_ENUM(NSInteger , LoadingShowType) {
    
    LoadingShowTypeUnDefine = 0 , /** 未定义 */
    LoadingShowTypeTurnAround     = 1 ,  //默认转圈样式
    LoadingShowTypeTurnAroundLeft = 2 ,  //默认在左边转圈样式
    
    LoadingShowTypeIndicator      = 3 ,  //菊花样式
    LoadingShowTypeIndicatorLeft  = 4 ,  //菊花在左边的样式
    
    LoadingShowTypePlayImages     = 5 ,  //以一个图片数组轮流播放（需添加一组图片）
    LoadingShowTypePlayImagesLeft = 6 ,  //以一个图片数组轮流播放需添加一组图片）
    
    LoadingShowTypeImageUpturn    = 7 ,//自定义图片翻转样式
    LoadingShowTypeImageUpturnLeft= 8 ,//自动以图片左边翻转样式
    
    LoadingShowTypeImageAround    = 9 ,//自定义图片边缘转圈样式
    LoadingShowTypeImageAroundLeft= 10 ,//自动以图片左边边缘转圈样式
};

/**
 * 动画类型
 */
typedef NS_ENUM(NSInteger , LoadingAnimationType) {
    LoadingAnimationTypeUndefine = 0 , /** 未定义 */
    LoadingAnimationTypeNone ,//无动画
    LoadingAnimationTypeFade,//alpha改变
    LoadingAnimationTypeBounce ,//抖动
} ;


UIKIT_EXTERN const CGFloat EasyShowLoadingMaxWidth  ;     //显示文字的最大宽度（高度已限制死）
UIKIT_EXTERN const CGFloat EasyShowLoadingImageEdge ;    //加载框图片的边距
UIKIT_EXTERN const CGFloat EasyShowLoadingImageWH  ;      //加载框图片的大小
UIKIT_EXTERN const CGFloat EasyShowLoadingImageMaxWH  ;   //加载框图片的最大宽度

@interface EasyLoadingTypes : NSObject

@end
