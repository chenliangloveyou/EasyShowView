//
//  EasyAlertView.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyAlertTypes.h"
#import "EasyAlertConfig.h"
#import "EasyAlertItem.h"
#import "EasyAlertPart.h"

@interface EasyAlertView : UIView



/**
 *  快速创建AlertView的方法 
 *
 * part        alertView的组成部分 标题，副标题，显示类型
 * config      配置信息（如果为空，就是使用EasyAlertGlobalConfig中的属性值）
 * buttonArray 所以需要显示的按钮
 * callback    点击按钮回调
 */
+ (EasyAlertView *)alertViewWithPart:(EasyAlertPart *(^)(void))part
                              config:(EasyAlertConfig *(^)(void))config
                         buttonArray:(NSArray<NSString *> *(^)(void))buttonArray
                            callback:(AlertCallback)callback ;



/**
 * 第一步：创建一个自定义的Alert/ActionSheet
 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                          subtitle:(NSString *)subtitle
                     AlertViewType:(AlertViewType)alertType
                            config:(EasyAlertConfig *(^)(void))config  ;

+ (instancetype)alertViewWithPart:(EasyAlertPart *(^)(void))part
                           config:(EasyAlertConfig *(^)(void))config
                         callback:(AlertCallback)callback ;

/**
 * 第二步：往创建的alert上面添加事件
 */
- (void)addAlertItemWithTitle:(NSString *)title
                         type:(AlertItemType)type
                     callback:(AlertCallback)callback;
- (void)addAlertItem:(EasyAlertItem *(^)(void))item ;
- (void)addAlertItemWithTitleArray:(NSArray *)titleArray
                          callback:(AlertCallback)callbck ;

/**
 * 第三步：展示alert
 */
- (void)showAlertView ;


// 移除alertview
- (void)removeAlertView ;



@end











