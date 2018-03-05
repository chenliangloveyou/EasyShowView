//
//  EasyShowLodingConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/4.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyShowTypes.h"

@interface EasyShowLodingConfig : NSObject

+ (instancetype)configInView:(UIView *)superView ;

+ (instancetype)configInView:(UIView *)superView
                superReceive:(BOOL)receive ;

+ (instancetype)configInView:(UIView *)superView
                superReceive:(BOOL)receive
                    showType:(LodingShowType)showType ;

+ (instancetype)configInView:(UIView *)superView
                superReceive:(BOOL)receive
                    showType:(LodingShowType)showType
               animationType:(lodingAnimationType)animationType ;


/**
 * 显示的superview
 */
@property (nonatomic,strong)UIView *superView ;
/**
 * 加载框的显示样式
 */
@property LodingShowType lodingShowType ;

/**
 * 显示/隐藏 加载框的动画
 */
@property lodingAnimationType lodingAnimationType ;

/**
 * 在显示加载框的时候，superview能否接收事件。默认为NO
 */
@property BOOL lodingSuperViewReceiveEvent ;

/**
 * 是否将加载框显示到window上面。默认为NO（此属性只有在不传superview的时候有效）
 * 当为NO： 加载框会遮盖住最上面一个controller的大小。如果lodingSuperViewReceiveEvent为NO,那么superview不接受事件，返回按钮会有效。
 * 当为YES：加载框会在盖住整个window的大小。如果lodingSuperViewReceiveEvent为NO,那么在不隐藏加载框的时候返回事件都会被遮住。
 *
 */
@property BOOL lodingShowOnWindow ;

/**
 * 圆角大小
 */
@property (nonatomic,assign)CGFloat lodingCycleCornerWidth ;

/**
 *  文字/图片颜色、文字大小、背景颜色
 */
@property (nonatomic,strong)UIColor * lodingTintColor ;
@property (nonatomic,strong)UIFont  * lodingTextFount ;
@property (nonatomic,strong)UIColor * lodingBackgroundColor ;

/**
 * 加载框为数组动画的时候，这里是传入图片的数据
 */
@property (nonatomic,strong)NSArray * lodingPlayImagesArray ;


@end
