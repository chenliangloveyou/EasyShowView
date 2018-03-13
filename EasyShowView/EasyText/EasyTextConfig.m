//
//  EasyTextConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyTextConfig.h"


@implementation EasyTextConfig

+ (instancetype)shared
{
    return [[self alloc]init];
}

- (EasyTextConfig *(^)(UIView *))setSuperView{
    return ^EasyTextConfig *(UIView *superView){
        self.superView = superView ;
        return self ;
    } ;
}
- (EasyTextConfig *(^)(ShowTextStatusType))setTextStatusType{
    return ^EasyTextConfig *(ShowTextStatusType statusType){
        self.textStatusType = statusType ;
        return self ;
    } ;
}
- (EasyTextConfig *(^)(TextAnimationType))setAnimationType{
    return ^EasyTextConfig *(TextAnimationType animationType){
        self.animationType = animationType ;
        return self ;
    };
}
- (EasyTextConfig *(^)(ShowTextEvent))setSuperReceiveEvent{
    return ^EasyTextConfig *(ShowTextEvent receive){
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
    return [EasyTextConfig configWithSuperView:superView
                                 superReceiveEvent:ShowTextEventUndefine
                                     animationType:TextAnimationTypeUndefine ];
}
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(ShowTextEvent)receive
{
    return [EasyTextConfig configWithSuperView:superView
                                 superReceiveEvent:receive
                                     animationType:TextAnimationTypeUndefine ];

}
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(ShowTextEvent)receive
                      animationType:(TextAnimationType)animationType
{
    return [EasyTextConfig configWithSuperView:superView
                                 superReceiveEvent:receive
                                     animationType:TextAnimationTypeUndefine
                                    textStatusType:ShowTextStatusTypeUndefine];
}
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(ShowTextEvent)receive
                      animationType:(TextAnimationType)animationType
                     textStatusType:(ShowTextStatusType)statusType
{
    EasyTextConfig *config = [self shared];
    config.superView = superView ;
    config.superReceiveEvent = receive ;
    config.animationType = animationType ;
    config.textStatusType = statusType ;
    return config ;
}
@end
