//
//  EasyShowLodingGlobalConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/4.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyShowTypes.h"
@interface EasyShowLodingGlobalConfig : NSObject

+ (instancetype)sharedEasyShowLodingGlobalConfig ;

//是否已经使用了globalConfig，库内部使用
+ (BOOL)isUseLoeingGlobalConfig ;


/** 显示loding所需要的父视图 **/
//@property (nonatomic,strong)UIView *superView ;

/** 加载框所显示的类型 **/
@property LodingShowType lodingType ;

/** 显示/隐藏 加载框的动画 **/
@property lodingAnimationType animationType ;

/** 在显示加载框的时候，superview能否接收事件。默认为NO **/
@property BOOL superReceiveEvent ;

/**
 * 是否将加载框显示到window上面。默认为NO（此属性只有在不传superview的时候有效）
 * 当为NO： 加载框会遮盖住最上面一个controller的大小。如果lodingSuperViewReceiveEvent为NO,那么superview不接受事件，返回按钮会有效。
 * 当为YES：加载框会在盖住整个window的大小。如果lodingSuperViewReceiveEvent为NO,那么在不隐藏加载框的时候返回事件都会被遮住。
 *
 */
@property BOOL showOnWindow ;


/** 圆角大小 **/
@property (nonatomic,assign)CGFloat cycleCornerWidth ;

/** 加载框主体颜色 **/
@property (nonatomic,strong)UIColor * tintColor ;

/** 文字字体大小 **/
@property (nonatomic,strong)UIFont  * textFont ;

/** 背景颜色 **/
@property (nonatomic,strong)UIColor * bgColor ;

/** 图片动画类型 所需要的图片数组 **/
@property (nonatomic,strong)NSArray<UIImage *> * playImagesArray ;


@end
