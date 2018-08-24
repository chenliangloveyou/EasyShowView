//
//  EasyTextConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyTextConfig.h"
#import "EasyShowUtils.h"
#import "EasyTextGlobalConfig.h"

@implementation EasyTextConfig

+ (instancetype)shared
{
    return [[self alloc]init];
}
- (instancetype)init
{
    if (self = [super init]) {
        
        EasyTextGlobalConfig *globalC = [EasyTextGlobalConfig shared];
        _superReceiveEvent = globalC.superReceiveEvent ;
        _animationType = globalC.animationType ;
        _statusType = globalC.statusType ;
    }
    return self ;
}

- (EasyTextConfig *(^)(UIView *))setSuperView{
    return ^EasyTextConfig *(UIView *superView){
        self.superView = superView ;
        return self ;
    } ;
}
- (EasyTextConfig *(^)(TextStatusType))setStatusType{
    return ^EasyTextConfig *(TextStatusType statusType){
        self.statusType = statusType ;
        return self ;
    } ;
}
- (EasyTextConfig *(^)(TextAnimationType))setAnimationType{
    return ^EasyTextConfig *(TextAnimationType animationType){
        self.animationType = animationType ;
        return self ;
    };
}
- (EasyTextConfig *(^)(BOOL))setSuperReceiveEvent{
    return ^EasyTextConfig *(BOOL receive){
        self.superReceiveEvent = receive ;
        return self ;
    };
}
- (EasyTextConfig *(^)(UIFont *))setTitleFont {
    return ^EasyTextConfig *(UIFont *titleFont){
        self.titleFont = titleFont ;
        return self ;
    };
}
- (EasyTextConfig *(^)(UIColor *))setTitleColor{
    return ^EasyTextConfig *(UIColor *titleColor){
        self.titleColor = titleColor ;
        return self ;
    };
}
- (EasyTextConfig *(^)(UIColor *))setBgColor{
    return ^EasyTextConfig *(UIColor *bgcolor){
        self.bgColor = bgcolor ;
        return self ;
    };
}
- (EasyTextConfig *(^)(UIColor *))setShadowColor{
    return ^EasyTextConfig *(UIColor *shadowColor){
        self.shadowColor = shadowColor ;
        return self ;
    };
}



+ (instancetype)configWithSuperView:(UIView *)superView
{
    return [self configWithSuperView:superView
                       animationType:TextAnimationTypeUndefine];
}

+ (instancetype)configWithSuperView:(UIView *)superView
                      animationType:(TextAnimationType)animationType
{
    return [self configWithSuperView:superView
                       animationType:animationType
                          statusType:TextStatusTypeUndefine];
}

+ (instancetype)configWithSuperView:(UIView *)superView
                      animationType:(TextAnimationType)animationType
                         statusType:(TextStatusType)statusType
{
    return [self configWithSuperView:superView
                       animationType:animationType
                          statusType:statusType
                   superReceiveEvent:[EasyTextGlobalConfig shared].superReceiveEvent];
}

+ (instancetype)configWithSuperView:(UIView *)superView
                      animationType:(TextAnimationType)animationType
                         statusType:(TextStatusType)statusType
                  superReceiveEvent:(BOOL)receive
{
    EasyTextConfig *config = [self shared];
    config.superView = superView ;
    config.superReceiveEvent = receive ;
    config.animationType = animationType ;
    config.statusType = statusType ;
    return config ;
}
@end
