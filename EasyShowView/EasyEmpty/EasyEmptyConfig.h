//
//  EasyEmptyConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EasyEmptyConfig : NSObject


@property (nonatomic,strong)UIColor *bgColor ;   //背景颜色

@property (nonatomic,strong)UIFont  *tittleFont ; //标题字体大小
@property (nonatomic,strong)UIColor *titleColor ;//标题字体颜色

@property (nonatomic,strong)UIFont  *subtitleFont ;  //副标题字体大小
@property (nonatomic,strong)UIColor *subTitleColor ;//副标题字体颜色

@property (nonatomic,strong)UIFont  *buttonFont ;    //按钮字体大小
@property (nonatomic,strong)UIColor *buttonColor ;  //按钮字体亚瑟
@property (nonatomic,strong)UIColor *buttonBgColor ;//按钮背景颜色

@property (nonatomic,assign)UIEdgeInsets easyViewEdgeInsets ;//整个emptyview往内缩的距离(如果为负数，则会超出边界)
@property (nonatomic,assign)UIEdgeInsets buttonEdgeInsets ; //按钮往内缩的边距（按钮四边边缘距离文字的距离）
@property (nonatomic,assign)BOOL scrollVerticalEnable ;//是否可以上下滚动

+ (instancetype)shared ;
- (EasyEmptyConfig *(^)(UIColor *))setBgColor ;
- (EasyEmptyConfig *(^)(UIFont *))setTitleFont ;
- (EasyEmptyConfig *(^)(UIColor *))setTitleColor ;
- (EasyEmptyConfig *(^)(UIFont *))setSubtitleFont ;
- (EasyEmptyConfig *(^)(UIColor *))setSubtitleColor ;
- (EasyEmptyConfig *(^)(UIFont *))setButtonFont ;
- (EasyEmptyConfig *(^)(UIColor *))setButtonColor ;
- (EasyEmptyConfig *(^)(UIColor *))setButtonBgColor ;
- (EasyEmptyConfig *(^)(UIEdgeInsets))setEasyViewEdgeInsets ;
- (EasyEmptyConfig *(^)(UIEdgeInsets))setButtonEdgeInsets ;
- (EasyEmptyConfig *(^)(BOOL))setScrollVerticalEnable ;


+ (instancetype)configWithBgColor:(UIColor *)bgColor ;
+ (instancetype)configWithBgColor:(UIColor *)bgColor titleFount:(UIFont *)titleFount ;


@end

NS_ASSUME_NONNULL_END
