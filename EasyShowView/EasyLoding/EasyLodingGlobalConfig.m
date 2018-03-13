//
//  EasyLodingGlobalConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/4.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyLodingGlobalConfig.h"

@implementation EasyLodingGlobalConfig


static EasyLodingGlobalConfig *_showInstance;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showInstance = [super allocWithZone:zone];
    });
    return _showInstance;
}
+ (instancetype)sharedEasyLodingGlobalConfig {
    if (nil == _showInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _showInstance = [[[self class] alloc] init];
        });
    }
    return _showInstance;
}

- (id)copyWithZone:(NSZone *)zone{
    return _showInstance;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _showInstance;
}
//是否已经使用了globalConfig，库内部使用
+ (BOOL)isUseLoeingGlobalConfig
{
    return _showInstance!=nil ? YES : NO ;
}

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
