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

@interface EasyShowTextView()<CAAnimationDelegate>

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)NSString *showImageName ;//展示的图片
@property (nonatomic,assign)ShowTextStatus showTextStatus ;//展示的类型


@property (nonatomic,strong)EasyShowOptions *options ;
@property (nonatomic,assign)BOOL isShowedStatusBar ;
@property (nonatomic,assign)BOOL isShowedNavigation ;

@property (nonatomic,strong)EasyShowTextBgView *showBgView ;//用于放图片和文字的背景


- (void)showViewWithSuperView:(UIView *)superView ;
- (void)removeSelfFromSuperView ;



@property (nonatomic,strong)NSTimer *removeTimer ;
@property (nonatomic,assign)CGFloat showTime ;
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
    
    if (self.options.textSuperViewReceiveEvent) {//父视图能接受事件
        //self的大小为显示区域的大小
        [self setFrame:CGRectMake((SCREEN_WIDTH_S-showFrame.size.width)/2, showFrame.origin.y, showFrame.size.width, showFrame.size.height)];
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
    
    if (self.options.textShadowColor && self.options.textShadowColor!=[UIColor clearColor]) {
        CGFloat afterStart = self.options.textAnimationType==TextAnimationTypeBounce ? EasyShowAnimationTime : EasyShowAnimationTime/2 ;
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
    addSubLayer.backgroundColor=self.options.textBackGroundColor.CGColor;
    addSubLayer.masksToBounds=NO;
    addSubLayer.name = @"backgrouldsubLayer";
    addSubLayer.shadowColor = self.options.textShadowColor.CGColor;
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
    switch (self.options.textAnimationType) {
        case TextAnimationTypeNone:
        {
            if ( (self.isShowedStatusBar || self.isShowedNavigation)) {
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
            if ( (self.isShowedStatusBar || self.isShowedNavigation)) {
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
            if ( (self.isShowedStatusBar || self.isShowedNavigation)) {
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
    if (self.options.textShadowColor && self.options.textShadowColor!=[UIColor clearColor]) {
        [self hiddenBackgrouldsubLayer];
    }
    
    switch (self.options.textAnimationType) {
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
            
            if ( (self.isShowedStatusBar || self.isShowedNavigation)) {
                
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


+ (void)showToastWithText:(NSString *)text
                   inView:(UIView *)view
                    imageName:(NSString *)imageName
                   stauts:(ShowTextStatus)status
{
    if (status==ShowTextStatusPureText && ISEMPTY_S(text)) {//
        NSAssert(NO, @"you should set a text for showView !");
        return ;
    }
    if (nil == view) {
        NSAssert(NO, @"there shoud have a superview");
        return ;
    }
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    //显示之前隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
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
    
    showView.showTime = 1 + text.length*0.15 ;
    if (showView.showTime > TextShowMaxTime) {
        showView.showTime = TextShowMaxTime ;
    }
    if (showView.showTime < 2) {
        showView.showTime = 2 ;
    }
    showView.timerShowTime = 0 ;
    [showView showViewWithSuperView:view];
    
    [showView.removeTimer fire];
}

- (CGRect)showRectWithSpuerView:(UIView *)superView
{
    //显示图片的高度。
    CGFloat imageH = self.showTextStatus==ShowTextStatusPureText ?:(EasyDrawImageWH + EasyDrawImageEdge) ;
    
    //显示区域的宽高
    CGFloat backGroundH = 0 ;
    CGFloat backGroundW = SCREEN_WIDTH_S ;
    switch (self.options.textStatusType) {
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
                                                         font:self.options.textTitleFount
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
    CGFloat showFrameY = (SCREEN_HEIGHT_S-backGroundH)/2  ;//默认显示在中间
    //    if (self.showTextStatus != ShowStatusLoding) {
    switch (self.options.textStatusType ) {
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
    
    if (!self.options.textSuperViewReceiveEvent) {
        showFrame.origin = CGPointMake((superView.width-backGroundW)/2, showFrameY) ;
    }
    
    return showFrame ;
}
//- (EasyShowOptions *)options
//{
//    if (nil == _options) {
//        _options = [EasyShowOptions sharedEasyShowOptions];
//    }
//    return _options ;
//}


- (void)timerAction
{
    if (_timerShowTime >= _showTime ) {
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





+ (void)showText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showText:text inView:showView];
}

+ (void)showText:(NSString *)text inView:(UIView *)view
{
    [self showToastWithText:text inView:view imageName:nil stauts:ShowTextStatusPureText];
}

+ (void)showSuccessText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showSuccessText:text inView:showView];
}
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView
{
    [self showToastWithText:text inView:superView imageName:nil stauts:ShowTextStatusSuccess];
}

+ (void)showErrorText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showErrorText:text inView:showView];
}
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView
{
    [self showToastWithText:text inView:superView imageName:nil stauts:ShowTextStatusError];
}

+ (void)showInfoText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showInfoText:text inView:showView];
}
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView
{
    [self showToastWithText:text inView:superView imageName:nil stauts:ShowTextStatusInfo];
}

+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showImageText:text imageName:imageName inView:showView] ;
}
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName inView:(UIView *)superView
{
    [self showToastWithText:text inView:superView imageName:imageName stauts:ShowTextStatusImage] ;
}

@end
