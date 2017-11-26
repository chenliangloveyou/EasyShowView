//
//  EFShowView.h
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "EasyUtils.h"

typedef NS_ENUM(NSInteger, ShowStatus) {
    
    ShowStatusText ,    /** 纯文字 */
    ShowStatusSuccess, /** 成功 */
    ShowStatusError,   /** 失败 */
    ShowStatusInfo,    /** 提示 */
    ShowStatusScore,   /** 积分 */
    ShowStatusImage,   /** 自定义图片 */
    ShwoStatusLoding,  /** 正在加载 */
};

@interface EasyShowView : UIView

+ (void)showLodingText:(NSString *)text ;
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView ;

+ (void)showText:(NSString *)text ;
+ (void)showText:(NSString *)text inView:(UIView *)view ;

+ (void)showSuccessText:(NSString *)text ;
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView ;

+ (void)showErrorText:(NSString *)text ;
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView ;

+ (void)showInfoText:(NSString *)text ;
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView ;
@end
