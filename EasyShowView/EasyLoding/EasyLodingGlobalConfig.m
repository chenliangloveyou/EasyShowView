//
//  EasyLodingGlobalConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/4.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyLodingGlobalConfig.h"

@implementation EasyLodingGlobalConfig

easyShowView_singleton_implementation(EasyLodingGlobalConfig)

- (instancetype)init
{
    if (self = [super init]) {
        
        _lodingType = LodingShowTypeTurnAround ;
        _animationType = lodingAnimationTypeBounce ;
        _textFont = [UIFont systemFontOfSize:15];
        _tintColor = [UIColor blackColor];
        _bgColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.05];
        _superReceiveEvent = YES ;
        _showOnWindow = NO ;
        _cycleCornerWidth = 5 ;
        
    }
    return self ;
}
@end
