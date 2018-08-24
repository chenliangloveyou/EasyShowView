//
//  EasyLoadingConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/4.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyLoadingConfig.h"
#import "EasyShowUtils.h"
#import "EasyLoadingGlobalConfig.h"

@implementation EasyLoadingConfig

+ (instancetype)shared
{
    return [[self alloc]init];
}
- (instancetype)init
{
    if (self = [super init]) {
        EasyLoadingGlobalConfig *golbalC = [EasyLoadingGlobalConfig shared];
        _LoadingType = golbalC.LoadingType ;
        _animationType = golbalC.animationType ;
        _superReceiveEvent = golbalC.superReceiveEvent ;
        _showOnWindow = golbalC.showOnWindow ;
    }
    return self ;
}

- (EasyLoadingConfig *(^)(UIView *))setSuperView {
    return ^EasyLoadingConfig *(UIView *spuerView){
        self.superView = spuerView ;
        return self ;
    };
}
- (EasyLoadingConfig *(^)(BOOL))setSuperReceiveEvent{
    return ^EasyLoadingConfig *(BOOL receive){
        self.superReceiveEvent = receive ;
        return self ;
    } ;
}
- (EasyLoadingConfig *(^)(LoadingShowType))setLoadingType {
    return ^EasyLoadingConfig *(LoadingShowType showtype){
        self.LoadingType = showtype ;
        return self ;
    };
}
- (EasyLoadingConfig *(^)(LoadingAnimationType))setAnimationType {
    return ^EasyLoadingConfig *(LoadingAnimationType animationtype){
        self.animationType = animationtype ;
        return self ;
    };
}
- (EasyLoadingConfig *(^)(BOOL))setShowOnWindow {
    return ^EasyLoadingConfig *(BOOL showOnWindow){
        self.showOnWindow = showOnWindow ;
        return self ;
    };
}
- (EasyLoadingConfig *(^)(CGFloat))setCycleCornerWidth{
    return ^EasyLoadingConfig *(CGFloat cornerWidth){
        self.cycleCornerWidth = cornerWidth ;
        return self ;
    };
}

- (EasyLoadingConfig *(^)(UIColor *))setTintColor{
    return ^EasyLoadingConfig *(UIColor *titleColor){
        self.tintColor = titleColor ;
        return self ;
    };
}
- (EasyLoadingConfig *(^)(UIFont *))setTextFont {
    return ^EasyLoadingConfig *(UIFont *textFont){
        self.textFont = textFont ;
        return self ;
    };
}
- (EasyLoadingConfig *(^)(UIColor *))setBgColor {
    return ^EasyLoadingConfig *(UIColor *bgcolor){
        self.bgColor = bgcolor ;
        return self ;
    };
}
- (EasyLoadingConfig *(^)(NSArray<UIImage *> *))setPlayImagesArray
{
    return ^EasyLoadingConfig *(NSArray<UIImage *> *playImagesArray){
        self.playImagesArray = playImagesArray ;
        return self ;
    };
}



+ (instancetype)configInView:(UIView *)superView
{
    return [EasyLoadingConfig configInView:superView
                                 showType:LoadingShowTypeUnDefine];
}

+ (instancetype)configInView:(UIView *)superView
                    showType:(LoadingShowType)showType
{
    return [self configInView:superView
                     showType:showType
                animationType:LoadingAnimationTypeUndefine];
}

+ (instancetype)configInView:(UIView *)superView
                    showType:(LoadingShowType)showType
               animationType:(LoadingAnimationType)animationType
{
    return [self configInView:superView
                     showType:showType
                animationType:animationType
                 superReceive:[EasyLoadingGlobalConfig shared].superReceiveEvent];
}

+ (instancetype)configInView:(UIView *)superView
                    showType:(LoadingShowType)showType
               animationType:(LoadingAnimationType)animationType
                superReceive:(BOOL)receive
{
    EasyLoadingConfig *config = [[EasyLoadingConfig alloc]init];
    config.superView = superView ;
    config.superReceiveEvent = receive ;
    config.LoadingType = showType ;
    config.animationType = animationType ;
    return config ;
}
@end
