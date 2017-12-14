//
//  EasyShowAlertView.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowView.h"

typedef void (^alertItemCallback)(EasyShowView *showview);


@interface EasyShowAlertView : EasyShowView


+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                 message:(NSString *)message ;

+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message ;

- (void)addItemWithTitle:(NSString *)title
                itemType:(ShowAlertItemType)itemType
                callback:(alertItemCallback)callback;
- (void)show ;


@end
