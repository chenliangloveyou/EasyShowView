//
//  EasyEmptyGlobalConfig.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EasyShowUtils.h"

@interface EasyEmptyGlobalConfig : NSObject


//背景颜色
@property (nonatomic,strong)UIColor *bgColor ;

//标题的文字大小、颜色
@property (nonatomic,strong)UIFont *tittleFont ;
@property (nonatomic,strong)UIColor *titleColor ;

//副标题的文字大小 颜色
@property (nonatomic,strong)UIFont *subtitleFont ;
@property (nonatomic,strong)UIColor *subTitleColor ;

//按钮的文字背景 颜色 大小
@property (nonatomic,strong)UIFont *buttonFont ;
@property (nonatomic,strong)UIColor *buttonColor ;
@property (nonatomic,strong)UIColor *buttonBgColor ;
//按钮往内缩的边距（按钮四边边缘距离文字的距离）
@property (nonatomic,assign)UIEdgeInsets buttonEdgeInsets ;


easyShowView_singleton_interface


@end
