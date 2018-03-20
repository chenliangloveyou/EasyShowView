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

@interface UIView (EasyShowExt)

@property(nonatomic) CGFloat easyS_x;
@property(nonatomic) CGFloat easyS_y;
@property(nonatomic) CGFloat easyS_width;
@property(nonatomic) CGFloat easyS_height;

@property(nonatomic) CGFloat easyS_centerX;
@property(nonatomic) CGFloat easyS_centerY;

@property(nonatomic) CGFloat easyS_left;
@property(nonatomic) CGFloat easyS_top;
@property(nonatomic) CGFloat easyS_right;
@property(nonatomic) CGFloat easyS_bottom;


- (void)setRoundedCorners:(CGFloat)corners ;

- (void)setRoundedCorners:(UIRectCorner)corners
              borderWidth:(CGFloat)borderWidth
              borderColor:(UIColor *)borderColor
               cornerSize:(CGSize)size ;
@end
