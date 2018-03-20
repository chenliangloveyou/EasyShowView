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

NS_ASSUME_NONNULL_BEGIN

@interface EasyEmptyGlobalConfig : NSObject

@property (nonatomic,strong)UIColor *bgColor UI_APPEARANCE_SELECTOR ;   //背景颜色

@property (nonatomic,strong)UIFont  *tittleFont UI_APPEARANCE_SELECTOR ; //标题字体大小
@property (nonatomic,strong)UIColor *titleColor UI_APPEARANCE_SELECTOR ;//标题字体颜色

@property (nonatomic,strong)UIFont  *subtitleFont UI_APPEARANCE_SELECTOR ;  //副标题字体大小
@property (nonatomic,strong)UIColor *subTitleColor UI_APPEARANCE_SELECTOR ;//副标题字体颜色

@property (nonatomic,strong)UIFont  *buttonFont UI_APPEARANCE_SELECTOR ;    //按钮字体大小
@property (nonatomic,strong)UIColor *buttonColor UI_APPEARANCE_SELECTOR ;  //按钮字体亚瑟
@property (nonatomic,strong)UIColor *buttonBgColor UI_APPEARANCE_SELECTOR ;//按钮背景颜色

@property (nonatomic,assign)UIEdgeInsets buttonEdgeInsets UI_APPEARANCE_SELECTOR ; //按钮往内缩的边距（按钮四边边缘距离文字的距离）

@property (nonatomic,assign)BOOL scrollVerticalEnable ;//是否可以上下滚动


easyShowView_singleton_interface


@end

NS_ASSUME_NONNULL_END

