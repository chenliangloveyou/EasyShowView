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

- (instancetype)initWithFrame:(CGRect)frame status:(ShowTextStatus)status text:(NSString *)text image:(UIImage *)image ;

- (void)showWindowYToPoint:(CGFloat)toPoint ;

- (void)showStartAnimationWithDuration:(CGFloat)duration ;
- (void)showEndAnimationWithDuration:(CGFloat)duration  ;

@end
