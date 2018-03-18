//
//  EasyAlertGlobalConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyAlertGlobalConfig.h"

@implementation EasyAlertGlobalConfig

easyShowView_singleton_implementation(EasyAlertGlobalConfig)

- (instancetype)init
{
    if (self = [super init]) {
        
        _tintColor = [UIColor cyanColor];
        _titleColor = [UIColor darkTextColor];
        _subtitleColor = [UIColor lightTextColor];
        _twoItemHorizontal = NO ;
        _animationType = AlertAnimationTypeBounce ;
        _bgViewEvent  = YES ;
        _alertViewMaxNum = 2 ;
    }
    return self ;
}
@end
