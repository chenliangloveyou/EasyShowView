//
//  EasyEmptyView.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/1/16.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyEmptyPart.h"
#import "EasyEmptyConfig.h"
#import "EasyEmptyTypes.h"

@interface EasyEmptyView : UIScrollView

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                              part:(EasyEmptyPart *(^)(void))part ;

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                              part:(EasyEmptyPart *(^)(void))part
                            config:(EasyEmptyConfig *(^)(void))config ;

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                              part:(EasyEmptyPart *(^)(void))part
                            config:(EasyEmptyConfig *(^)(void))config
                          callback:(emptyViewCallback)callback ;


+ (void)hiddenEmptyInView:(UIView *)superView ;
+ (void)hiddenEmptyView:(EasyEmptyView *)emptyView ;


@end
