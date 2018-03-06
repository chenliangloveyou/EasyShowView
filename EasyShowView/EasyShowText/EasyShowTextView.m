//
//  EasyShowTextView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowTextView.h"
#import "UIView+EasyShowExt.h"

#import "EasyShowTextBgView.h"

#import "EasyShowTextGlobalConfig.h"
#import "EasyShowTypes.h"

@interface EasyShowTextView()<CAAnimationDelegate>

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)NSString *showImageName ;//展示的图片
@property (nonatomic,assign)ShowTextStatus showTextStatus ;//展示的类型
@property (nonatomic,strong)EasyShowTextConfig *showTextConfig ;//配置信息

@property (nonatomic,assign)BOOL isShowOnStatusBar ;
@property (nonatomic,assign)BOOL isShowOnNavigation ;

@property (nonatomic,strong)EasyShowTextBgView *showBgView ;//用于放图片和文字的背景


- (void)showViewWithSuperView:(UIView *)superView ;
- (void)removeSelfFromSuperView ;

@property (nonatomic,strong)NSTimer *removeTimer ;
@property CGFloat timerShowTime ;//定时器走动的时间

@end

@implementation EasyShowTextView

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
    
    if (self.showTextConfig.superViewReceiveEvent) {//父视图能接受事件
        //self的大小为显示区域的大小
        [self setFrame:CGRectMake((superView.width-showFrame.size.width)/2, showFrame.origin.y, showFrame.size.width, showFrame.size.height)];
        //显示视图的bgview的frame的位置为{0，0}
        showFrame.origin.y = 0 ;
    }
    else{
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        [self setFrame: CGRectMake(0, 0, superView.width, superView.height)] ;
    }
    
    
    self.showBgView = [[EasyShowTextBgView alloc]initWithFrame:showFrame
                                                        status:self.showTextStatus
                                                          text:self.showText
                                                         imageName:self.showImageName];
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

+ (void)easyShowTextViewWithText:(NSString *)text
                       imageName:(NSString *)imageName
                          status:(ShowTextStatus)status
                          config:(EasyShowTextConfig *)config
{
    if (status==ShowTextStatusPureText && ISEMPTY_S(text)) {//
        NSAssert(NO, @"you should set a text for showView !");
        return ;
    }
    if (nil == config.superView) {
        NSAssert(NO, @"there shoud have a superview");
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
            EasyShowTextView *showView = (EasyShowTextView *)subview ;
            [showView removeSelfFromSuperView];
        }
    }
    
    EasyShowTextView *showView = [[EasyShowTextView alloc] initWithFrame:CGRectZero];
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
    
    if (!self.showTextConfig.superViewReceiveEvent) {
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

+ (EasyShowTextConfig *)changeConfigWithConfig:(EasyShowTextConfig *)config
{
    EasyShowOptions *options = [EasyShowOptions sharedEasyShowOptions];
    
    BOOL isUseGlobalConfig = [EasyShowTextGlobalConfig isUseTextGlobalConfig];
    EasyShowTextGlobalConfig *globalConfig = nil ;
    if (isUseGlobalConfig) {
        globalConfig = [EasyShowTextGlobalConfig shared];
    }
    
    if (config.superViewReceiveEvent == SuperReceiveEventUndefine) {
        config.superViewReceiveEvent = isUseGlobalConfig ? globalConfig.superViewReceiveEvent : options.textSuperViewReceiveEvent ;
    }
    if (config.animationType == TextAnimationTypeUndefine) {
        config.animationType = isUseGlobalConfig ? globalConfig.animationType : options.textAnimationType ;
    }
    if (config.textStatusType == ShowTextStatusTypeUndefine) {
        config.textStatusType =  isUseGlobalConfig ? globalConfig.textStatusType : options.textStatusType ;
    }
    if (!config.titleFont) {
        config.titleFont =  isUseGlobalConfig ? globalConfig.titleFont : options.textTitleFount ;
    }
    if (!config.titleColor) {
        config.titleColor = isUseGlobalConfig ? globalConfig.titleColor : options.textTitleColor ;
    }
    if (!config.bgColor) {
        config.bgColor =  isUseGlobalConfig ? globalConfig.bgColor : options.textBackGroundColor ;
    }
    if (!config.shadowColor) {
        config.shadowColor =  isUseGlobalConfig ? globalConfig.shadowColor : options.textShadowColor ;
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
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = showView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showText:text config:configTemp];
}
+ (void)showText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config
{
    [self easyShowTextViewWithText:text
                         imageName:nil
                            status:ShowTextStatusPureText 
                            config:config?config():nil];
}


+ (void)showSuccessText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = showView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showSuccessText:text config:configTemp];
}
+ (void)showSuccessText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config
{
    [self easyShowTextViewWithText:text
                         imageName:nil
                            status:ShowTextStatusSuccess
                            config:config?config():nil];
}


+ (void)showErrorText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = showView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showErrorText:text config:configTemp];
}
+ (void)showErrorText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config
{
    [self easyShowTextViewWithText:text
                         imageName:nil
                            status:ShowTextStatusError
                            config:config?config():nil];
}


+ (void)showInfoText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = showView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showInfoText:text config:configTemp];
}
+ (void)showInfoText:(NSString *)text config:(EasyShowTextConfig *(^)(void))config
{
    [self easyShowTextViewWithText:text
                         imageName:nil
                            status:ShowTextStatusInfo
                            config:config?config():nil];
}


+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = showView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showImageText:text imageName:imageName config:configTemp] ;
}
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName config:(EasyShowTextConfig *(^)(void))config
{
    [self easyShowTextViewWithText:text
                         imageName:imageName
                            status:ShowTextStatusImage
                            config:config?config():nil];
}


#pragma mark - 过期方法
+ (void)showText:(NSString *)text inView:(UIView *)view
{
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = view ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showText:text config:configTemp];
}
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView
{
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = superView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showSuccessText:text config:configTemp];
}
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView
{
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = superView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showErrorText:text config:configTemp];
}
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView
{
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = superView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showInfoText:text config:configTemp];
}
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName inView:(UIView *)superView
{
    __block EasyShowTextConfig *config = [[EasyShowTextConfig alloc]init];
    config.superView = superView ;
    EasyShowTextConfig *(^configTemp)(void) = ^EasyShowTextConfig *{
        return config ;
    };
    [self showImageText:text imageName:imageName config:configTemp] ;
}

@end
