//
//  EasyShowOptions.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowOptions.h"

const CGFloat EasyDrawImageWH  = 40 ;   //显示图片的宽高
const CGFloat EasyDrawImageEdge = 20 ;  //显示图片的边距
const CGFloat EasyTextShowEdge = 50 ;   //显示纯文字时，当设置top和bottom的时候，距离屏幕上下的距离
const CGFloat EasyShowViewMinWidth = 60 ;//视图最小的宽度

NSString *const EasyShowViewDidlDismissNotification = @"EasyShowViewDidlDismissNotification" ; //当EasyShowView消失的时候会发送此通知。


@interface EasyShowOptions()
@end

@implementation EasyShowOptions

singleton_implementation(EasyShowOptions)

- (instancetype)init
{
    if (self = [super init]) {
        _textFount = [UIFont systemFontOfSize:17];
        _backGroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.9];
        _textColor = [UIColor whiteColor];
        
        _showShadow = YES ;
        _shadowColor = [UIColor redColor];
        
        _maxWidthScale = 0.8 ;
        _maxShowTime = 6.0f ;
        _superViewReceiveEvent = NO ;
        _textStatusType = ShowStatusTextTypeBottom  ;
        _showStartAnimation = YES ;
        _showEndAnimation = NO ;
        _showAnimationDuration = 0.4 ;
        
        _showLodingType = ShowLodingTypeImage ;
    }
    return self ;
}


@end
