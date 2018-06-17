//
//  EasyLoadingGlobalConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/4.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyLoadingGlobalConfig.h"

@implementation EasyLoadingGlobalConfig

easyShowView_singleton_implementation(EasyLoadingGlobalConfig)

- (instancetype)init
{
    if (self = [super init]) {
        
        _LoadingType = LoadingShowTypeTurnAround ;
        _animationType = LoadingAnimationTypeBounce ;
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
