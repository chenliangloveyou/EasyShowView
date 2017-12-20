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

#import "EasyShowBgView.h"

@interface EasyShowView()<CAAnimationDelegate>

@property (nonatomic,strong)EasyShowBgView *showBgView ;//用于放图片和文字的背景

@end

@implementation EasyShowView

- (void)dealloc
{
    NSLog(@"%p EasyShowView dealloc",self );
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =  [[UIColor lightGrayColor] colorWithAlphaComponent:0.02]; // [UIColor greenColor] ;//
    }
    return self ;
}



-(CGRect)showRectWithSpuerView:(UIView *)superView
{
    NSAssert(NO, @"the child class should ") ;
    return CGRectZero ;
}
- (void)showViewWithSuperView:(UIView *)superView
{
    //展示视图的frame
    CGRect showFrame = [self showRectWithSpuerView:superView] ;
 
    if (self.options.superViewReceiveEvent) {//父视图能接受事件
        //self的大小为显示区域的大小
        [self setFrame:CGRectMake((SCREEN_WIDTH-showFrame.size.width)/2, showFrame.origin.y, showFrame.size.width, showFrame.size.height)];
        //显示视图的bgview的frame的位置为{0，0}
        showFrame.origin.y = 0 ;
    }
    else{
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        [self setFrame: CGRectMake(0, 0, superView.width, superView.height)] ;
    }
    
    
    self.showBgView = [[EasyShowBgView alloc]initWithFrame:showFrame
                                                    status:self.showTextStatus
                                                      text:self.showText
                                                     image:self.showImage];
    [self addSubview:self.showBgView];
  
    
    [self showSelfToSuperView:superView];
    
    if (self.options.showShadow) {
        CGFloat afterStart = self.options.showStartAnimation ? self.options.showAnimationTime :0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterStart * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showBackgrouldsubLayer];
        });
    }
}
- (void)showBackgrouldsubLayer
{
    CALayer *addSubLayer=[CALayer layer];
    addSubLayer.frame= self.showBgView.frame;
    addSubLayer.cornerRadius=8;
    addSubLayer.backgroundColor=self.options.backGroundColor.CGColor;
    addSubLayer.masksToBounds=NO;
    addSubLayer.name = @"backgrouldsubLayer";
    addSubLayer.shadowColor = self.options.shadowColor.CGColor;
    addSubLayer.shadowOffset = CGSizeMake(0.5, 2);
    addSubLayer.shadowOpacity = 0.6;
    addSubLayer.shadowRadius = 4;
    [self.layer insertSublayer:addSubLayer below:self.showBgView.layer];
}
- (void)hiddenBackgrouldsubLayer
{
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer.name isEqualToString:@"backgrouldsubLayer"]) {
            [subLayer removeFromSuperlayer];
            break ;
        }
    }
}

- (void)showSelfToSuperView:(UIView *)superView
{
    if (self.options.showStartAnimation) {
        
        if ( (self.isShowedStatusBar || self.isShowedNavigation)) {
            self.y = - self.height ;
            [UIView animateWithDuration:self.options.showAnimationTime animations:^{
                self.y = 0 ;
                [self.showBgView showWindowYToPoint:0];
            }] ;
        }
        else{
            [self.showBgView showStartAnimationWithDuration:self.options.showAnimationTime];
        }
        
        [superView addSubview:self];
        
    }
    else{
        if ( (self.isShowedStatusBar || self.isShowedNavigation)) {
            self.y = 0 ;
        }
        else{
            self.alpha = 0.1 ;
            [UIView animateWithDuration:self.options.showAnimationTime animations:^{
                self.alpha = 1.0 ;
            } completion:^(BOOL finished) {
                [superView addSubview:self];
            }];
        }
    }
}
- (void)removeSelfFromSuperView
{
    
    //移除阴影
    if (self.options.showShadow) {
        [self hiddenBackgrouldsubLayer];
    }
    
    if (self.options.showEndAnimation) {
        
        if ( (self.isShowedStatusBar || self.isShowedNavigation)) {
            
            [UIView animateWithDuration:self.options.showAnimationTime animations:^{
                self.y = -self.height ;
                [self.showBgView showWindowYToPoint:-self.height ];
                NSLog(@"========= %.2f",self.y);
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }] ;
        }
        else{
            [self.showBgView showEndAnimationWithDuration:self.options.showAnimationTime];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.options.showAnimationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
        }
    }
    else{
        [UIView animateWithDuration:self.options.showAnimationTime animations:^{
            self.alpha = 0.1 ;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }] ;
    }
}


#pragma mark - getter
//是否显示在statusbar上
- (BOOL)isShowedStatusBar
{
    return self.options.textStatusType==ShowTextStatusTypeStatusBar ;
}
//是否正在显示在navigation上
- (BOOL)isShowedNavigation
{
    return self.options.textStatusType==ShowTextStatusTypeNavigation ;
}

- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
}

@end















