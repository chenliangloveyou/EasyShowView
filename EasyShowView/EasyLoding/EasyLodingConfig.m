//
//  EasyLodingConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/4.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyLodingConfig.h"
#import "EasyShowUtils.h"
#import "EasyLodingGlobalConfig.h"

@implementation EasyLodingConfig

+ (instancetype)shared
{
    return [[self alloc]init];
}
- (instancetype)init
{
    if (self = [super init]) {
        EasyLodingGlobalConfig *golbalC = [EasyLodingGlobalConfig shared];
        _lodingType = golbalC.lodingType ;
        _animationType = golbalC.animationType ;
        _superReceiveEvent = golbalC.superReceiveEvent ;
        _showOnWindow = golbalC.showOnWindow ;
    }
    return self ;
}

- (EasyLodingConfig *(^)(UIView *))setSuperView {
    return ^EasyLodingConfig *(UIView *spuerView){
        self.superView = spuerView ;
        return self ;
    };
}
- (EasyLodingConfig *(^)(BOOL))setSuperReceiveEvent{
    return ^EasyLodingConfig *(BOOL receive){
        self.superReceiveEvent = receive ;
        return self ;
    } ;
}
- (EasyLodingConfig *(^)(LodingShowType))setLodingType {
    return ^EasyLodingConfig *(LodingShowType showtype){
        self.lodingType = showtype ;
        return self ;
    };
}
- (EasyLodingConfig *(^)(LodingAnimationType))setAnimationType {
    return ^EasyLodingConfig *(LodingAnimationType animationtype){
        self.animationType = animationtype ;
        return self ;
    };
}
- (EasyLodingConfig *(^)(BOOL))setShowOnWindow {
    return ^EasyLodingConfig *(BOOL showOnWindow){
        self.showOnWindow = showOnWindow ;
        return self ;
    };
}
- (EasyLodingConfig *(^)(CGFloat))setCycleCornerWidth{
    return ^EasyLodingConfig *(CGFloat cornerWidth){
        self.cycleCornerWidth = cornerWidth ;
        return self ;
    };
}

- (EasyLodingConfig *(^)(UIColor *))setTintColor{
    return ^EasyLodingConfig *(UIColor *titleColor){
        self.tintColor = titleColor ;
        return self ;
    };
}
- (EasyLodingConfig *(^)(UIFont *))setTextFont {
    return ^EasyLodingConfig *(UIFont *textFont){
        self.textFont = textFont ;
        return self ;
    };
}
- (EasyLodingConfig *(^)(UIColor *))setBgColor {
    return ^EasyLodingConfig *(UIColor *bgcolor){
        self.bgColor = bgcolor ;
        return self ;
    };
}
- (EasyLodingConfig *(^)(NSArray<UIImage *> *))setPlayImagesArray
{
    return ^EasyLodingConfig *(NSArray<UIImage *> *playImagesArray){
        self.playImagesArray = playImagesArray ;
        return self ;
    };
}



+ (instancetype)configInView:(UIView *)superView
{
    return [EasyLodingConfig configInView:superView
                                 showType:LodingShowTypeUnDefine];
}

+ (instancetype)configInView:(UIView *)superView
                    showType:(LodingShowType)showType
{
    return [self configInView:superView
                     showType:showType
                animationType:LodingAnimationTypeUndefine];
}

+ (instancetype)configInView:(UIView *)superView
                    showType:(LodingShowType)showType
               animationType:(LodingAnimationType)animationType
{
    return [self configInView:superView
                     showType:showType
                animationType:animationType
                 superReceive:[EasyLodingGlobalConfig shared].superReceiveEvent];
}

+ (instancetype)configInView:(UIView *)superView
                    showType:(LodingShowType)showType
               animationType:(LodingAnimationType)animationType
                superReceive:(BOOL)receive
{
    EasyLodingConfig *config = [[EasyLodingConfig alloc]init];
    config.superView = superView ;
    config.superReceiveEvent = receive ;
    config.lodingType = showType ;
    config.animationType = animationType ;
    return config ;
}
@end
