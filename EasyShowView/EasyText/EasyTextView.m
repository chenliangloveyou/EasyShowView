//
//  EasyTextView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyTextView.h"
#import "UIView+EasyShowExt.h"

#import "EasyTextBgView.h"

#import "EasyTextGlobalConfig.h"

@interface EasyTextView()<CAAnimationDelegate>

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)NSString *showImageName ;//展示的图片
@property (nonatomic,assign)ShowTextStatus showTextStatus ;//展示的类型
@property (nonatomic,strong)EasyTextConfig *showTextConfig ;//配置信息

@property (nonatomic,assign)BOOL isShowOnStatusBar ;
@property (nonatomic,assign)BOOL isShowOnNavigation ;

@property (nonatomic,strong)EasyTextBgView *showBgView ;//用于放图片和文字的背景


- (void)showViewWithSuperView:(UIView *)superView ;
- (void)removeSelfFromSuperView ;

@property (nonatomic,strong)NSTimer *removeTimer ;
@property CGFloat timerShowTime ;//定时器走动的时间

@end

@implementation EasyTextView

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self ;
}


- (void)showViewWithSuperView:(UIView *)superView
{
    //展示视图的frame
    CGRect showFrame = [self showRectWithSpuerView:superView] ;
    
    if (self.showTextConfig.superReceiveEvent) {//父视图能接受事件
        //self的大小为显示区域的大小
        [self setFrame:CGRectMake((superView.easyS_width-showFrame.size.width)/2, showFrame.origin.y, showFrame.size.width, showFrame.size.height)];
        //显示视图的bgview的frame的位置为{0，0}
        showFrame.origin.y = 0 ;
    }
    else{
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        [self setFrame: CGRectMake(0, 0, superView.easyS_width, superView.easyS_height)] ;
    }
    
    
    self.showBgView = [[EasyTextBgView alloc]initWithFrame:showFrame
                                                        status:self.showTextStatus
                                                          text:self.showText
                                                         imageName:self.showImageName config:self.showTextConfig];
    [self addSubview:self.showBgView];
    
    
    [self showSelfToSuperView:superView];
    
    if (self.showTextConfig.shadowColor && self.showTextConfig.shadowColor!=[UIColor clearColor]) {
        CGFloat afterStart = self.showTextConfig.animationType==TextAnimationTypeBounce ? EasyShowAnimationTime : EasyShowAnimationTime/2 ;
        if (afterStart > 0.1) {
            afterStart -=0.1 ;
        }
        dispatch_queue_after_S(afterStart, ^{
            [self showBackgrouldsubLayer];
        });
    }
}
- (void)showBackgrouldsubLayer
{
    CALayer *addSubLayer=[CALayer layer];
    addSubLayer.frame= self.showBgView.frame;
    addSubLayer.cornerRadius=8;
    addSubLayer.backgroundColor=self.showTextConfig.bgColor.CGColor;
    addSubLayer.masksToBounds=NO;
    addSubLayer.name = @"backgrouldsubLayer";
    addSubLayer.shadowColor = self.showTextConfig.shadowColor.CGColor;
    addSubLayer.shadowOffset = CGSizeMake(0.5,1);
    addSubLayer.shadowOpacity = 0.6;
    addSubLayer.shadowRadius = 3;
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
    switch (self.showTextConfig.animationType) {
        case TextAnimationTypeNone:
        {
            if ( (self.isShowOnStatusBar || self.isShowOnNavigation)) {
                self.easyS_y = 0 ;
                [self.showBgView showWindowYToPoint:0];

                [superView addSubview:self];

            }
            else{
//                self.alpha = 0.1 ;
//                [UIView animateWithDuration:EasyShowAnimationTime animations:^{
//                    self.alpha = 1.0 ;
//                } completion:^(BOOL finished) {
                    [superView addSubview:self];
//                }];
            }
        }break;
        case TextAnimationTypeFade:
        {
            if ( (self.isShowOnStatusBar || self.isShowOnNavigation)) {
                self.easyS_y = 0 ;
                [self.showBgView showWindowYToPoint:0];

                [superView addSubview:self];
            }
            else{
                self.alpha = 0.1 ;
                [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                    self.alpha = 1.0 ;
                } completion:^(BOOL finished) {
                }];
                [superView addSubview:self];
            }
        }break ;
        case TextAnimationTypeBounce:
        {
            if ( (self.isShowOnStatusBar || self.isShowOnNavigation)) {
                self.easyS_y = - self.easyS_height ;
                [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                    self.easyS_y = 0 ;
                    [self.showBgView showWindowYToPoint:0];
                }] ;
            }
            else{
                [self.showBgView showStartAnimationWithDuration:EasyShowAnimationTime];
            }
            
            [superView addSubview:self];
        }break ;
        default:
            break;
    }
    
}
- (void)removeSelfFromSuperView
{
    
    //移除阴影
    if (self.showTextConfig.shadowColor && self.showTextConfig.shadowColor!=[UIColor clearColor]) {
        dispatch_queue_after_S(0.1, ^{
            [self hiddenBackgrouldsubLayer];
        });
    }
    
    switch (self.showTextConfig.animationType) {
        case TextAnimationTypeNone:
        {
            [self removeFromSuperview];
        }break ;
        case TextAnimationTypeFade:
        {
            [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                self.alpha = 0.1 ;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }] ;
        }break ;
        case TextAnimationTypeBounce:
        {
            
            if ( (self.isShowOnStatusBar || self.isShowOnNavigation)) {
                
                [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                    self.easyS_y = -self.easyS_height ;
                    [self.showBgView showWindowYToPoint:-self.easyS_height ];
                }completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }] ;
            }
            else{
                [self.showBgView showEndAnimationWithDuration:EasyShowAnimationTime];
                dispatch_queue_after_S(EasyShowAnimationTime, ^{
                    [self removeFromSuperview];
                });
            }
        }
            break ;
        default:
            break ;
    }
    
    
}

+ (void)EasyTextViewWithText:(NSString *)text
                       imageName:(NSString *)imageName
                          status:(ShowTextStatus)status
                          config:(EasyTextConfig *(^)(void))config
{
    if (status==ShowTextStatusPureText && ISEMPTY_S(text)) {//
        NSAssert(NO, @"you should set a text for showView !");
        return ;
    }
    
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    EasyTextConfig *tempConfig = [self changeConfigWithConfig:config] ;
    
    //显示之前隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [tempConfig.superView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyTextView *showView = (EasyTextView *)subview ;
            [showView removeSelfFromSuperView];
        }
    }
    
    EasyTextView *showView = [[EasyTextView alloc] initWithFrame:CGRectZero];
    showView.showText = text ;
    showView.showImageName = imageName ;
    
    showView.showTextStatus = status ;

    showView.showTextConfig = tempConfig ;
    
    showView.timerShowTime = 0 ;
    [showView showViewWithSuperView:tempConfig.superView];
    
    [showView.removeTimer fire];
}


- (CGRect)showRectWithSpuerView:(UIView *)superView
{
    //显示图片的高度。
    CGFloat imageH = self.showTextStatus==ShowTextStatusPureText ?:(EasyDrawImageWH + EasyDrawImageEdge) ;
    
    //显示区域的宽高
    CGFloat backGroundH = 0 ;
    CGFloat backGroundW = SCREEN_WIDTH_S ;
    switch (self.showTextConfig.statusType) {
        case TextStatusTypeStatusBar://如果是在statusbar上，则高固定，不需要计算
            backGroundH = STATUSBAR_HEIGHT_S ;
            break;
        case TextStatusTypeNavigation:
            backGroundH = NAVIGATION_HEIGHT_S ;
            break ;
        default:{
            CGSize textSize = CGSizeZero ;
            if (!ISEMPTY_S(self.showText)) {
                textSize = [EasyShowUtils textWidthWithStirng:self.showText
                                                         font:self.showTextConfig.titleFont
                                                     maxWidth:TextShowMaxWidth];
            }
            backGroundH = (textSize.height?(textSize.height+30):0) + imageH ;
            backGroundW = textSize.width?(textSize.width+40):0  ;
            
            if (backGroundW < EasyShowViewMinWidth) {
                backGroundW = EasyShowViewMinWidth  ;
            }
        } break;
    }
    
    //显示区域的y值
    CGFloat showFrameY = (superView.easyS_height-backGroundH)/2  ;//默认显示在中间
    //    if (self.showTextStatus != ShowStatusLoading) {
    switch (self.showTextConfig.statusType ) {
        case TextStatusTypeNavigation:
        case TextStatusTypeStatusBar:
            showFrameY = 0 ;
            break ;
        case TextStatusTypeTop:
            showFrameY = NAVIGATION_HEIGHT_S + EasyTextShowEdge ;
            break;
        case TextStatusTypeBottom:
            showFrameY = SCREEN_HEIGHT_S - backGroundH - EasyTextShowEdge ;
            break ;
        default: break;
    }
    //    }
    
    //显示区域的frame
    CGRect showFrame = CGRectMake(0, showFrameY, backGroundW, backGroundH);
    
    if (!self.showTextConfig.superReceiveEvent) {
        showFrame.origin = CGPointMake((superView.easyS_width-backGroundW)/2, showFrameY) ;
    }
    
    return showFrame ;
}



- (void)timerAction
{
    if (_timerShowTime >= self.showTextConfig.textShowTimeBlock(self.showText) ) {
        //移除定时器
        _timerShowTime = 0 ;
        if (_removeTimer) {
            [_removeTimer invalidate];
            _removeTimer = nil ;
        }
        //移除自己
        [self removeSelfFromSuperView];
    }
    _timerShowTime++ ;
}
- (NSTimer *)removeTimer
{
    if (nil == _removeTimer) {
        _removeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_removeTimer forMode:NSRunLoopCommonModes];
    }
    return _removeTimer ;
}


#pragma mark - getter
//是否显示在statusbar上
- (BOOL)isShowOnStatusBar
{
    return self.showTextConfig.statusType==TextStatusTypeStatusBar ;
}
//是否正在显示在navigation上
- (BOOL)isShowOnNavigation
{
    return self.showTextConfig.statusType==TextStatusTypeNavigation ;
}

#pragma - 工具

+ (EasyTextConfig *)changeConfigWithConfig:(EasyTextConfig *(^)(void))config
{
    
    EasyTextConfig *tempConfig = config ? config() : nil ;
    if (!tempConfig) {
        tempConfig = [EasyTextConfig shared] ;
    }
    EasyTextGlobalConfig *globalConfig = [EasyTextGlobalConfig shared];
    
    if (!tempConfig.superView) {
        if (globalConfig.showOnWindow) {
            tempConfig.superView = kEasyShowKeyWindow ;
        }
        else{
            tempConfig.superView = [EasyShowUtils easyShowViewTopViewController].view;
        }
    }
    
    if (tempConfig.animationType == TextAnimationTypeUndefine) {
        tempConfig.animationType = globalConfig.animationType ;
    }
    if (tempConfig.statusType == TextStatusTypeUndefine) {
        tempConfig.statusType =  globalConfig.statusType ;
    }
    if (!tempConfig.titleFont) {
        tempConfig.titleFont = globalConfig.titleFont  ;
    }
    if (!tempConfig.titleColor) {
        tempConfig.titleColor =  globalConfig.titleColor ;
    }
    if (!tempConfig.bgColor) {
        tempConfig.bgColor = globalConfig.bgColor ;
    }
    if (!tempConfig.shadowColor) {
        tempConfig.shadowColor =  globalConfig.shadowColor ;
    }
    
    if (!tempConfig.textShowTimeBlock) {
        
        if (globalConfig.textShowTimeBlock) {
            tempConfig.textShowTimeBlock = globalConfig.textShowTimeBlock ;
        }else{
            float(^textShowTime)(NSString *text) = ^float(NSString *text){
                CGFloat time = 1 + text.length*0.15 ;
                if (time > TextShowMaxTime) {
                    time = TextShowMaxTime ;
                }
                if (time < 2) {
                    time = 2 ;
                }
                return time ;
            };
            tempConfig.textShowTimeBlock = textShowTime ;
        }
    }
    return tempConfig ;
}


#pragma mark - 类方法

+ (void)showText:(NSString *)text
{
    EasyTextConfig *(^configTemp)(void) = ^EasyTextConfig *{
        return [EasyTextConfig shared] ;
    };
    [self showText:text config:configTemp];
}
+ (void)showText:(NSString *)text config:(EasyTextConfig *(^)(void))config
{
    [self EasyTextViewWithText:text
                         imageName:nil
                            status:ShowTextStatusPureText 
                            config:config];
}


+ (void)showSuccessText:(NSString *)text
{
    EasyTextConfig *(^configTemp)(void) = ^EasyTextConfig *{
        return [EasyTextConfig shared] ;
    };
    [self showSuccessText:text config:configTemp];
}
+ (void)showSuccessText:(NSString *)text config:(EasyTextConfig *(^)(void))config
{
    [self EasyTextViewWithText:text
                         imageName:nil
                            status:ShowTextStatusSuccess
                            config:config];
}


+ (void)showErrorText:(NSString *)text
{
    EasyTextConfig *(^configTemp)(void) = ^EasyTextConfig *{
        return [EasyTextConfig shared] ;
    };
    [self showErrorText:text config:configTemp];
}
+ (void)showErrorText:(NSString *)text config:(EasyTextConfig *(^)(void))config
{
    [self EasyTextViewWithText:text
                         imageName:nil
                            status:ShowTextStatusError
                            config:config];
}


+ (void)showInfoText:(NSString *)text
{
    EasyTextConfig *(^configTemp)(void) = ^EasyTextConfig *{
        return [EasyTextConfig shared] ;
    };
    [self showInfoText:text config:configTemp];
}
+ (void)showInfoText:(NSString *)text config:(EasyTextConfig *(^)(void))config
{
    [self EasyTextViewWithText:text
                         imageName:nil
                            status:ShowTextStatusInfo
                            config:config];
}


+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName
{
    EasyTextConfig *(^configTemp)(void) = ^EasyTextConfig *{
        return [EasyTextConfig shared] ;
    };
    [self showImageText:text imageName:imageName config:configTemp] ;
}
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName config:(EasyTextConfig *(^)(void))config
{
    [self EasyTextViewWithText:text
                         imageName:imageName
                            status:ShowTextStatusImage
                            config:config];
}


@end
