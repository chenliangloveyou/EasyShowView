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
        
        _tintColor = [UIColor groupTableViewBackgroundColor];
        _titleColor = [UIColor darkTextColor];
        _subtitleColor = [UIColor lightGrayColor];
        _twoItemHorizontal = NO ;
        _animationType = AlertAnimationTypeBounce ;
        _effectType = AlertBgEffectTypeWoolGlass ;
        _bgViewEvent  = YES ;
        _alertViewMaxNum = 2 ;
    }
    return self ;
}
@end
