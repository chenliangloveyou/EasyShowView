//
//  EFShowView.m
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//


#import "EasyShowView.h"
#import "UIView+EasyShowExt.h"
#import "EasyShowOptions.h"

@interface EasyShowView()<CAAnimationDelegate>


@end

@implementation EasyShowView

- (void)dealloc
{
    NSLog(@"%p EasyShowView dealloc",self );
}


//+ (void)showLodingWithText:(NSString *)text inView:(UIView *)superView image:(UIImage *)image
//{
//    [EasyShowView showText:text inView:superView image:image textStatus:-1 showType:ShowTypeLoding];
//}
//+ (void)showToastWithText:(NSString *)text inView:(UIView *)view image:(UIImage *)image stauts:(ShowTextStatus)status
//{
//    [EasyShowView showText:text inView:view image:image textStatus:status showType:ShowTypeText];
//}

- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
}

@end















