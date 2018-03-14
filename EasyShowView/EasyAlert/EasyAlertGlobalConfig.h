//
//  EasyAlertGlobalConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyShowUtils.h"
#import "EasyAlertTypes.h"

@interface EasyAlertGlobalConfig : NSObject

@property (nonatomic,strong)UIColor *tintColor ; //alertview的背景颜色

@property (nonatomic,strong)UIColor *titleColor ; //title的字体颜色

@property (nonatomic,strong)UIColor *subtitleColor ;//subtitle的字体颜色

@property (nonatomic,assign)BOOL itemHorizontal ;//当alertview为两个的时候，是否横着摆放

@property (nonatomic,assign)AlertAnimationType animationType;//alertView:展示和消失的动画类型。(只对自定义的alertview起作用)

@property (nonatomic,assign)BOOL bgViewEvent ;    //点击alertview之外的空白区域，是否销毁alertview。默认为:NO

@property (nonatomic,assign)NSUInteger alertViewMaxNum ; //允许出现alertView的最大数量

@property (nonatomic,assign)BOOL isSupportRotating;   //是否支持横屏

easyShowView_singleton_interface

@end
