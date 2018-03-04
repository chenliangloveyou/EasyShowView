//
//  EasyShowTextConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/3.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyShowTextConfig.h"
@interface EasyShowTextConfig()

//@property (nonatomic,strong)UIView *superView ;
//@property (nonatomic,assign)ShowTextSuperReceiveEvent superViewReceiveEvent;
//@property (nonatomic,assign)TextAnimationType animationType ;

@end

@implementation EasyShowTextConfig

+ (instancetype)configWithSuperView:(UIView *)superView
{
    return [EasyShowTextConfig configWithSuperView:superView
                                 superReceiveEvent:ShowTextSuperReceiveEventUndefine
                                     animationType:TextAnimationTypeUndefine ];
}
+ (instancetype)configWithSuperView:(UIView *)superView superReceiveEvent:(ShowTextSuperReceiveEvent)receive
{
    return [EasyShowTextConfig configWithSuperView:superView
                                 superReceiveEvent:receive
                                     animationType:TextAnimationTypeUndefine ];

}
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(ShowTextSuperReceiveEvent)receive
                      animationType:(TextAnimationType)animationType
{
    return [EasyShowTextConfig configWithSuperView:superView
                                 superReceiveEvent:receive
                                     animationType:TextAnimationTypeUndefine
                                    textStatusType:ShowTextStatusTypeUndefine];
}
+ (instancetype)configWithSuperView:(UIView *)superView
                  superReceiveEvent:(ShowTextSuperReceiveEvent)receive
                      animationType:(TextAnimationType)animationType
                     textStatusType:(ShowTextStatusType)statusType
{
    EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = superView ;
    config.superViewReceiveEvent = receive ;
    config.animationType = animationType ;
    config.textStatusType = statusType ;
    return config ;
}
@end
