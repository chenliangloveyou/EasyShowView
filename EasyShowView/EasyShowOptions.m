//
//  EasyShowOptions.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowOptions.h"

@implementation EasyShowOptions

@synthesize textStatusType = _textStatusType ;




//- (void)setTextStatusType:(ShowStatusTextType)textStatusType
//{
//    NSLog(@"%p ",self);
//    _textStatusType = textStatusType ;
//}
//- (ShowStatusTextType)textStatusType
//{
//    NSLog(@"%p ",self);
//    return _textStatusType ;
//}


static EasyShowOptions *_shareEasyOptions = nil ;

- (instancetype)init
{
    if (self = [super init]) {
        _textFount = [UIFont systemFontOfSize:17];
        _maxWidthScale = 0.8 ;
        _superViewReceiveEvent = NO ;
        _textStatusType = ShowStatusTextTypeBottom  ;
        _showStartAnimation = YES ;
        _showEndAnimation = YES ;
        _showAnimationDuration = 0.4 ;
        
    }
    return self ;
}
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareEasyOptions = [[EasyShowOptions alloc] init];
    });
    return _shareEasyOptions;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
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
