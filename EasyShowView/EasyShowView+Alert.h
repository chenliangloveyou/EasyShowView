//
//  EasyShowView+Alert.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/30.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowView.h"

typedef void (^showAlertCallback)(NSUInteger index);
@interface EasyShowView (Alert)

+ (void)showAlertWithTitle:(NSString *)title
                      desc:(NSString *)desc
               buttonArray:(NSArray *)buttonArray
                  callBack:(showAlertCallback)callback ;

+ (void)showAlertSystemWithTitle:(NSString *)title
                            desc:(NSString *)desc
                     buttonArray:(NSArray *)buttonArray
                        callBack:(showAlertCallback)callback ;
@end
