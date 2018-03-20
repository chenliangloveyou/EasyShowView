//
//  EasyEmptyGlobalConfig.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyEmptyGlobalConfig.h"

@implementation EasyEmptyGlobalConfig

easyShowView_singleton_implementation(EasyEmptyGlobalConfig)

- (instancetype)init
{
    if (self = [super init]) {
        
        _bgColor = [UIColor blackColor];
        _tittleFont = [UIFont systemFontOfSize:17];
        _titleColor = [UIColor blackColor];
        _subtitleFont = [UIFont systemFontOfSize:15];
        _subTitleColor = [UIColor lightGrayColor];
        _buttonFont = [UIFont systemFontOfSize:13];
        _buttonColor = [UIColor blueColor];
        _buttonBgColor = [UIColor whiteColor];
        _buttonEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        _scrollVerticalEnable = YES ;
    }
    return self ;
}
@end
