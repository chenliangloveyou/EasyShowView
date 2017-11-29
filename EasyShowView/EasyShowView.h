//
//  EFShowView.h
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "EasyShowUtils.h"
#import "EasyShowBgView.h"

@interface EasyShowView : UIView


#pragma mark - pravite

+ (void)showText:(NSString *)text inView:(UIView *)view image:(UIImage *)image stauts:(ShowStatus)status ;

- (void)clearCurrentShow ;

@end
