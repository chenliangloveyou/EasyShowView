//
//  UIView+EasyShowExt.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 * 已iPhone5为标准，宽高都等比例缩放
 *
 * 4/4s         3.5寸   320*480
 * 5/5s/se      4寸     320*568
 * 6/6s/7/8     4.7寸   375*667
 * 6p/6ps/7p/8p 5.5寸   414*736
 * iPhonex      5.8寸   375*812
 */
CG_INLINE CGFloat
AutoWidth_5(CGFloat width){
    return ([[UIScreen mainScreen] bounds].size.width/320.0f)*width ;
}

CG_INLINE CGFloat
AutoHeight_5(CGFloat height){
    return ([[UIScreen mainScreen] bounds].size.height/568.0f)*height ;
}

CG_INLINE CGRect
AutoFrame_5(CGFloat x,CGFloat y,CGFloat width,CGFloat height){
    return CGRectMake(x,y,AutoWidth_5(width), AutoHeight_5(height));
}

CG_INLINE CGSize
AutoSize_5(CGFloat width , CGFloat height){
    return CGSizeMake(AutoWidth_5(width), AutoHeight_5(height));
}

CG_INLINE CGPoint
AutoPoint_5(CGFloat x ,CGFloat y){
    return CGPointMake(AutoWidth_5(x), AutoHeight_5(y)) ;
}


@interface UIView (EasyShowExt)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,assign) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

/**
 * 获取当前view所在的控制器
 */
- (UIViewController *)currentViewController;
//- (UIViewController *)_topViewController:(UIViewController *)vc ;

- (void)setRoundedCorners:(CGFloat)corners ;

- (void)setRoundedCorners:(UIRectCorner)corners
              borderWidth:(CGFloat)borderWidth
              borderColor:(UIColor *)borderColor
               cornerSize:(CGSize)size ;
@end
