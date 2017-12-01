//
//  EasyShowView+Alert.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/30.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowView.h"

#import "EasyShowOptions.h"


typedef void (^showAlertCallback)(EasyShowView *showView , NSUInteger index);


@interface EasyShowView (Alert)

+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                 message:(NSString *)message ;

- (void)addItemWithTitle:(NSString *)title
                   image:(UIImage *)image
                itemType:(ShowAlertItemType)itemType
                callback:(showAlertCallback)callback;

- (void)show ;


+ (void)showAlertWithTitle:(NSString *)title
                      desc:(NSString *)desc
               buttonArray:(NSArray *)buttonArray
                  callBack:(showAlertCallback)callback ;

+ (void)showAlertSystemWithTitle:(NSString *)title
                            desc:(NSString *)desc
                     buttonArray:(NSArray *)buttonArray
                        callBack:(showAlertCallback)callback ;
@end
