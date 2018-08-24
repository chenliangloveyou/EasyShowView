//
//  EasyTextTypes.m
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/13.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyTextTypes.h"


const CGFloat TextShowMaxTime = 8.0f;//最大的显示时长。显示的时长为字符串长度成比例。但是不会超过设置的此时间长度(默认为6秒)
const CGFloat TextShowMaxWidth = 300;//文字显示的最大宽度


const CGFloat EasyDrawImageWH  = 30 ;   //显示图片的宽高
const CGFloat EasyDrawImageEdge = 15 ;  //显示图片的边距
const CGFloat EasyTextShowEdge = 40 ;   //显示纯文字时，当设置top和bottom的时候，距离屏幕上下的距离
const CGFloat EasyShowViewMinWidth = 50 ;//视图最小的宽度


NSString *const EasyShowViewDidlDismissNotification = @"EasyShowViewDidlDismissNotification" ; //当EasyShowView消失的时候会发送此通知。


@implementation EasyTextTypes

@end
