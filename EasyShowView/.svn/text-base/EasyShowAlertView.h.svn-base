//
//  EasyShowAlertView.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyShowTypes.h"
@class EasyShowAlertView ;
typedef void (^alertItemCallback)(EasyShowAlertView *showview);


@interface EasyShowAlertView : UIView


/**
 * 第一步：创建一个自定义的Alert/ActionSheet
 * title/message 不能同时为空
 */
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message ;
+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                 message:(NSString *)message ;
/**
 * 第二步：往创建的alert上面添加事件
 */
- (void)addItemWithTitle:(NSString *)title
                itemType:(ShowAlertItemType)itemType
                callback:(alertItemCallback)callback;

// 第三步：展示alert
- (void)show ;


#pragma mark - 以下是系统创建系统自带的alert

/**
 * 第一步：创建一个系统提供的Alert/ActionSheet
 */
+ (instancetype)showSystemActionSheetWithTitle:(NSString *)title
                                       message:(NSString *)message ;
+ (instancetype)showSystemAlertWithTitle:(NSString *)title
                                 message:(NSString *)message ;

/**
 * 第二步：往创建的alert上面添加事件
 */
- (void)addSystemItemWithTitle:(NSString *)title
                      itemType:(UIAlertActionStyle)itemType
                      callback:(alertItemCallback)callback;
// 第三步：展示alert
- (void)systemShow ;





@end











