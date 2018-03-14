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
#import "EasyShowOptions.h"
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
        [self setFrame:CGRectMake((superView.width-showFrame.size.width)/2, showFrame.origin.y, showFrame.size.width, showFrame.size.height)];
        //显示视图的bgview的frame的位置为{0，0}
        showFrame.origin.y = 0 ;
    }
    else{
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        [self setFrame: CGRectMake(0, 0, superView.width, superView.height)] ;
    }
    
    
    self.showBgView = [[EasyTextBgView alloc]initWithFrame:showFrame
                                                        status:self.showTextStatus
                                                          text:self.showText
                                                         imageName:self.showImageName config:self.showTextConfig];
    [self addSubview:self.showBgView];
    
    
    [self showSelfToSuperView:superView];
    
    if (self.showTextConfig.shadowColor && self.showTextConfig.shadowColor!=[UIColor clearColor]) {
        CGFloat afterStart = self.showTextConfig.animationType==TextAnimationTypeBounce ? EasyShowAnimationTime : EasyShowAnimationTime/2 ;
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
                self.y = 0 ;
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
                self.y = 0 ;
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
                self.y = - self.height ;
                [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                    self.y = 0 ;
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
        [self hiddenBackgrouldsubLayer];
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
                    self.y = -self.height ;
                    [self.showBgView showWindowYToPoint:-self.height ];
                }completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }] ;
            }
            else{
                [self.showBgView showEndAnimationWithDuration:EasyShowAnimationTime];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(EasyShowAnimationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
                          config:(EasyTextConfig *)config
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
    
    //显示之前隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [config.superView.subviews reverseObjectEnumerator];
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

    showView.showTextConfig = [self changeConfigWithConfig:config] ;
    
    showView.timerShowTime = 0 ;
    [showView showViewWithSuperView:config.superView];
    
    [showView.removeTimer fire];
}


- (CGRect)showRectWithSpuerView:(UIView *)superView
{
    //显示图片的高度。
    CGFloat imageH = self.showTextStatus==ShowTextStatusPureText ?:(EasyDrawImageWH + EasyDrawImageEdge) ;
    
    //显示区域的宽高
    CGFloat backGroundH = 0 ;
    CGFloat backGroundW = SCREEN_WIDTH_S ;
    switch (self.showTextConfig.textStatusType) {
        case ShowTextStatusTypeStatusBar://如果是在statusbar上，则高固定，不需要计算
            backGroundH = STATUSBAR_HEIGHT_S ;
            break;
        case ShowTextStatusTypeNavigation:
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
    CGFloat showFrameY = (superView.height-backGroundH)/2  ;//默认显示在中间
    //    if (self.showTextStatus != ShowStatusLoding) {
    switch (self.showTextConfig.textStatusType ) {
        case ShowTextStatusTypeNavigation:
        case ShowTextStatusTypeStatusBar:
            showFrameY = 0 ;
            break ;
        case ShowTextStatusTypeTop:
            showFrameY = NAVIGATION_HEIGHT_S + EasyTextShowEdge ;
            break;
        case ShowTextStatusTypeBottom:
            showFrameY = SCREEN_HEIGHT_S - backGroundH - EasyTextShowEdge ;
            break ;
        default: break;
    }
    //    }
    
    //显示区域的frame
    CGRect showFrame = CGRectMake(0, showFrameY, backGroundW, backGroundH);
    
    if (!self.showTextConfig.superReceiveEvent) {
        showFrame.origin = CGPointMake((superView.width-backGroundW)/2, showFrameY) ;
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
    return self.showTextConfig.textStatusType==ShowTextStatusTypeStatusBar ;
}
//是否正在显示在navigation上
- (BOOL)isShowOnNavigation
{
    return self.showTextConfig.textStatusType==ShowTextStatusTypeNavigation ;
}

#pragma - 工具

+ (EasyTextConfig *)changeConfigWithConfig:(EasyTextConfig *)config
{
    BOOL isUseGlobalConfig = [EasyTextGlobalConfig isUseTextGlobalConfig];
    EasyTextGlobalConfig *globalConfig = nil ;
    if (isUseGlobalConfig) {
        globalConfig = [EasyTextGlobalConfig shared];
    }
    
    if (!config.superView) {
        if (isUseGlobalConfig && globalConfig.showOnWindow) {
            config.superView = kEasyShowKeyWindow ;
        }
        else{
            config.superView = [EasyShowUtils easyShowViewTopViewController].view;
        }
    }
    
    if (config.superReceiveEvent == EasyUndefine) {
        config.superReceiveEvent = globalConfig.superViewReceiveEvent ;
    }
    if (config.animationType == TextAnimationTypeUndefine) {
        config.animationType = globalConfig.animationType ;
    }
    if (config.textStatusType == ShowTextStatusTypeUndefine) {
        config.textStatusType =  globalConfig.textStatusType ;
    }
    if (!config.titleFont) {
        config.titleFont = globalConfig.titleFont  ;
    }
    if (!config.titleColor) {
        config.titleColor =  globalConfig.titleColor ;
    }
    if (!config.bgColor) {
        config.bgColor = globalConfig.bgColor ;
    }
    if (!config.shadowColor) {
        config.shadowColor =  globalConfig.shadowColor ;
    }
    
    if (!config.textShowTimeBlock) {
        
        if (isUseGlobalConfig && globalConfig.textShowTimeBlock) {
            config.textShowTimeBlock = globalConfig.textShowTimeBlock ;
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
            config.textShowTimeBlock = textShowTime ;
        }
    }
    return config ;
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
                            config:config?config():nil];
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
                            config:config?config():nil];
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
                            config:config?config():nil];
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
                            config:config?config():nil];
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
                            config:config?config():nil];
}


@end
