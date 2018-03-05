//
//  EasyShowEmptyConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EasyShowEmptyConfig : NSObject


//背景颜色
@property (nonatomic,strong)UIColor *emptyViewBackgroundColor ;

//标题的文字大小、颜色
@property (nonatomic,strong)UIFont *emptyTitleFount ;
@property (nonatomic,strong)UIColor *emptyTitleColor ;

//副标题的文字大小 颜色
@property (nonatomic,strong)UIFont *emptySubTitleFount ;
@property (nonatomic,strong)UIColor *emptySubTitleColor ;

//按钮的文字背景 颜色 大小
@property (nonatomic,strong)UIFont *emptyButtonFount ;
@property (nonatomic,strong)UIColor *emptyButtonColor ;
@property (nonatomic,strong)UIColor *emptyButtonBackgroundColor ;
//按钮往内缩的边距（按钮四边边缘距离文字的距离）
@property (nonatomic,assign)UIEdgeInsets emptyButtonEdgeInsets ;


/**
 * 标题 副标题 图片 按钮 回调
 */
//+ (void)showEmptyViewWithTitle:(NSString *)title
//                        inview:(UIView *)superView
//                      callback:(emptyViewCallback)callback;
+ (instancetype)configWithBgColor:(UIColor *)bgColor ;
+ (instancetype)configWithBgColor:(UIColor *)bgColor titleFount:(UIFont *)titleFount ;


@end
