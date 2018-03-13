//
//  EasyAlertConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EasyAlertTypes.h"
@interface EasyAlertConfig : NSObject


/**
 *alertview的背景颜色。
 * title/message的字体颜色
 */
@property (nonatomic,strong)UIColor *alertTintColor ;
@property (nonatomic,strong)UIColor *alertTitleColor ;
@property (nonatomic,strong)UIColor *alertMessageColor ;

/**
 * alertView:是两个按钮的时候 横着摆放
 */
@property (nonatomic,assign)BOOL alertTowItemHorizontal ;

/**
 * alertView:展示和消失的动画类型。
 * 当展示的是系统alertview和ActionSheet不起作用
 */
@property (nonatomic,assign)alertAnimationType alertAnimationType ;

/**
 * 点击alertview之外的空白区域，是否销毁alertview。默认为:NO
 *
 * 系统的alert        不可以点击销毁。
 * 系统的ActionSheet  添加UIAlertActionStyleCancel类型就会有点击销毁。没有就不会销毁。
 */
@property (nonatomic,assign)BOOL alertBgViewTapRemove ;



@end
