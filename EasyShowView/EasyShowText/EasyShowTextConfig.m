//
//  EasyShowTextConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyShowTextConfig.h"


@implementation EasyShowTextConfig

+ (instancetype)shared
{
    return [[self alloc]init];
}

- (EasyShowTextConfig *(^)(UIView *))setSuperView{
    return ^EasyShowTextConfig *(UIView *superView){
        self.superView = superView ;
        return self ;
    } ;
}
- (EasyShowTextConfig *(^)(ShowTextStatusType))setTextStatusType{
    return ^EasyShowTextConfig *(ShowTextStatusType statusType){
        self.textStatusType = statusType ;
        return self ;
    } ;
}
- (EasyShowTextConfig *(^)(TextAnimationType))setAnimationType{
    return ^EasyShowTextConfig *(TextAnimationType animationType){
        self.animationType = animationType ;
        return self ;
    };
}
- (EasyShowTextConfig *(^)(SuperReceiveEvent))setSuperViewReceiveEvent{
    return ^EasyShowTextConfig *(SuperReceiveEvent receive){
        self.superViewReceiveEvent = receive ;
        return self ;
    };
}
- (EasyShowTextConfig *(^)(UIFont *))setTitleFont {
    return ^EasyShowTextConfig *(UIFont *titleFont){
        self.titleFont = titleFont ;
        return self ;
    };
}
- (EasyShowTextConfig *(^)(UIColor *))setTitleColor{
    return ^EasyShowTextConfig *(UIColor *titleColor){
        self.titleColor = titleColor ;
        return self ;
    };
}
- (EasyShowTextConfig *(^)(UIColor *))setBgColor{
    return ^EasyShowTextConfig *(UIColor *bgcolor){
        self.bgColor = bgcolor ;
        return self ;
    };
}
- (EasyShowTextConfig *(^)(UIColor *))setShadowColor{
    return ^EasyShowTextConfig *(UIColor *shadowColor){
        self.shadowColor = shadowColor ;
        return self ;
    };
}


+ (instancetype)configWithSuperView:(UIView *)superView
{
    return [EasyShowTextConfig configWithSuperView:superView
                                 superReceiveEvent:SuperReceiveEventUndefine
                                     animationType:TextAnimationTypeUndefine ];
}
+ (instancetype)configWithSuperView:(UIView *)superView superReceiveEvent:(SuperReceiveEvent)receive
{
    return [EasyShowTextConfig configWithSuperView:superView
                                 superReceiveEvent:receive
                                     animationType:TextAnimationTypeUndefine ];

}
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(SuperReceiveEvent)receive
                      animationType:(TextAnimationType)animationType
{
    return [EasyShowTextConfig configWithSuperView:superView
                                 superReceiveEvent:receive
                                     animationType:TextAnimationTypeUndefine
                                    textStatusType:ShowTextStatusTypeUndefine];
}
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(SuperReceiveEvent)receive
                      animationType:(TextAnimationType)animationType
                     textStatusType:(ShowTextStatusType)statusType
{
    EasyShowTextConfig *config = [self shared];
    config.superView = superView ;
    config.superViewReceiveEvent = receive ;
    config.animationType = animationType ;
    config.textStatusType = statusType ;
    return config ;
}
@end
