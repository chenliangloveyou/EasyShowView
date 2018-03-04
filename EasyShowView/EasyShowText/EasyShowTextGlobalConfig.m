//
//  EasyShowTextGlobalConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyShowTextGlobalConfig.h"

@implementation EasyShowTextGlobalConfig

static EasyShowTextGlobalConfig *_showInstance;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showInstance = [super allocWithZone:zone];
    });
    return _showInstance;
}
+ (instancetype)sharedEasyShowTextGlobalConfig {
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

- (instancetype)init
{
    if (self = [super init]) {
        
        _textSuperViewReceiveEvent = YES ;

        _textAnimationType = TextAnimationTypeBounce ;
        _textStatusType = ShowTextStatusTypeMidden  ;
        
        _textTitleFount = [UIFont systemFontOfSize:15];
        _textTitleColor = [[UIColor whiteColor]colorWithAlphaComponent:1.7];
        _textBackGroundColor = [UIColor blackColor];
        _textShadowColor = [UIColor blueColor];
        
        
    }
    return self ;
}

+ (BOOL)isUseTextGlobalConfig
{
    return _showInstance!=nil ? YES : NO ;
}
@end
