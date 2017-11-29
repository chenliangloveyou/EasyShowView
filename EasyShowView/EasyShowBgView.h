//
//  EasyShowBgView.h
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EasyShowOptions.h"

@interface EasyShowBgView : UIView

- (instancetype)initWithFrame:(CGRect)frame status:(ShowStatus)status text:(NSString *)text image:(UIImage *)image ;

- (void)showStartAnimationWithDuration:(CGFloat)duration ;
- (void)showEndAnimationWithDuration:(CGFloat)duration  ;

@end
