//
//  EasyShowOptions.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowOptions.h"

@implementation EasyShowOptions

- (instancetype)init
{
    if (self = [super init]) {
        _textFount = [UIFont systemFontOfSize:17];
        _maxWidthScale = 0.8 ;
        _superViewReceiveEvent = YES ;
        _textStatusType = 0.4 ;
        _showStartAnimation = YES ;
        _showEndAnimation = YES ;
        _showAnimationDuration = 0.4 ;
    }
    return self ;
}
//- (void)setTextStatusType:(ShowStatusTextType)textStatusType
//{
//    textStatusType = textStatusType ;
//}
//- (ShowStatusTextType)textStatusType
//{
//    return _textStatusType ;
//}

+ (instancetype)shareInstance
{
    return [[self alloc]init];
}
static EasyShowOptions *_shareEasyOptions = nil ;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _shareEasyOptions = [super allocWithZone:zone];
    });
    return _shareEasyOptions;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _shareEasyOptions;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _shareEasyOptions;
}

@end
