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

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)UIImage *showImage ;//展示的图片
@property (nonatomic,assign)ShowTextStatus showTextStatus ;//展示的类型
@property (nonatomic,assign)ShowType showType ;//展示的类型

@property (nonatomic,strong)EasyShowOptions *options ;


@property (nonatomic,strong)NSTimer *removeTimer ;
@property (nonatomic,assign)CGFloat showTime ;
@property CGFloat timerShowTime ;//定时器走动的时间


@property (nonatomic,strong)EasyShowBgView *showBgView ;//用于放图片和文字的背景

@end

@implementation EasyShowView

- (void)dealloc
{
    NSLog(@"%p EasyShowView dealloc",self );
}

+ (void)showLodingWithText:(NSString *)text inView:(UIView *)superView image:(UIImage *)image
{
    [EasyShowView showText:text inView:superView image:image textStatus:-1 showType:ShowTypeLoding];
}
+ (void)showToastWithText:(NSString *)text inView:(UIView *)view image:(UIImage *)image stauts:(ShowTextStatus)status
{
    [EasyShowView showText:text inView:view image:image textStatus:status showType:ShowTypeText];
}
+ (void)showText:(NSString *)text inView:(UIView *)view image:(UIImage *)image textStatus:(ShowTextStatus)status showType:(ShowType)showType
{
    if (status==ShowTextStatusPureText && ISEMPTY(text)) {//
        NSAssert(NO, @"you should set a text for showView !");
        return ;
    }
    if (nil == view) {
        NSAssert(NO, @"there shoud have a superview");
        return ;
    }
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    
    //显示之前---->隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowView *showView = (EasyShowView *)subview ;
            [showView clearCurrentShow];
        }
    }
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    EasyShowView *showView = [[EasyShowView alloc] initWithFrame:CGRectZero];
    showView.showText = text ;
    showView.showTextStatus = status ;
    showView.showImage = image ;
    showView.showType = showType ;
    
    showView.showTime = 1 + text.length*0.1 ;
    if (showView.showTime > [EasyShowOptions sharedEasyShowOptions].maxShowTime) {
        showView.showTime = [EasyShowOptions sharedEasyShowOptions].maxShowTime ;
    }
    showView.timerShowTime = 0 ;
    [showView showViewWithSuperView:view];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =  [[UIColor lightGrayColor] colorWithAlphaComponent:0.02]; //[UIColor purpleColor] ;//
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
    //展示视图的frame
    CGRect showFrame = [self getShowRectWithSuperView:superView];
    
    self.showBgView = [[EasyShowBgView alloc]initWithFrame:showFrame
                                                    status:self.showTextStatus
                                                      text:self.showText
                                                     image:self.showImage];
    [self addSubview:self.showBgView];
    
    //只有展示文字的时候，才需要自动消失
    if (self.showType == ShowTypeText) {
        [self.removeTimer fire];
    }
    
    if (self.options.showStartAnimation) {
        
        if (self.options.textStatusType == ShowTextStatusTypeStatusBar) {
            [UIView animateWithDuration:self.options.showAnimationTime animations:^{
                self.y = 0 ;
            }] ;
        }
        else{
            [self.showBgView showStartAnimationWithDuration:self.options.showAnimationTime];
        }
        
        [superView addSubview:self];
        
    }
    else{
        if (self.options.textStatusType == ShowTextStatusTypeStatusBar) {
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
    
    if (self.options.showShadow) {
        CGFloat afterStart = self.options.showStartAnimation ? self.options.showAnimationTime :0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterStart * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showBackgrouldsubLayer];
        });
    }
}

//获取需要展示框的大小
- (CGRect)getShowRectWithSuperView:(UIView *)superView
{
    //显示图片的高度。
    CGFloat imageH = self.showTextStatus==ShowTextStatusPureText ?:(EasyDrawImageWH + EasyDrawImageEdge) ;

    //显示区域的宽高
    CGFloat backGroundH = 0 ;
    CGFloat backGroundW = SCREEN_WIDTH ;
    switch (self.options.textStatusType) {
        case ShowTextStatusTypeStatusBar://如果是在statusbar上，则高固定，不需要计算
            backGroundH = STATUSBAR_ORGINAL_HEIGHT ;
            break;
        case ShowTextStatusTypeNavigation:
            backGroundH = STATUSBAR_ORGINAL_HEIGHT ;
            break ;
        default:{
            CGSize textSize = CGSizeZero ;
            if (!ISEMPTY(self.showText)) {
                textSize = [EasyShowUtils textWidthWithStirng:self.showText
                                                         font:self.options.textFount
                                                     maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
            }
            backGroundH = (textSize.height?(textSize.height+30):0) + imageH ;
            backGroundW = textSize.width?(textSize.width+40):0  ;
            
            if (backGroundW < EasyShowViewMinWidth) {
                backGroundW = EasyShowViewMinWidth  ;
            }
        } break;
    }
   
    //显示区域的y值
    CGFloat showFrameY = (SCREEN_HEIGHT-backGroundH)/2  ;//默认显示在中间
//    if (self.showTextStatus != ShowStatusLoding) {
        switch (self.options.textStatusType ) {
            case ShowTextStatusTypeStatusBar:
                showFrameY = 0 ;
                break ;
            case ShowTextStatusTypeTop:
                showFrameY = STATUSBAR_ORGINAL_HEIGHT + EasyTextShowEdge ;
                break;
            case ShowTextStatusTypeBottom:
                showFrameY = SCREEN_HEIGHT - backGroundH - EasyTextShowEdge ;
                break ;
            default: break;
        }
//    }
    
    
    //显示区域的frame
    CGRect showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
    
    if (self.options.superViewReceiveEvent) {
       
        //父视图能接受事件--> self的大小为显示区域的大小
        self.frame =  CGRectMake((SCREEN_WIDTH-backGroundW)/2, showFrameY, backGroundW, backGroundH);
    }
    else{
        
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        self.frame = CGRectMake(0, 0, superView.width, superView.height) ;
        
        showFrame.origin = CGPointMake((self.width-backGroundW)/2, showFrameY) ;
    }
    
    return showFrame ;
}

- (void)clearCurrentShow
{
    _timerShowTime = [EasyShowOptions sharedEasyShowOptions].maxShowTime + 1 ;
    [self timerAction];
}
- (void)timerAction
{
    if (_timerShowTime >= _showTime ) {
        
        //移除定时器
        _timerShowTime = 0 ;
        if (_removeTimer) {
            [_removeTimer invalidate];
            _removeTimer = nil ;
        }
       
        //移除阴影
        if (self.options.showShadow) {
            [self hiddenBackgrouldsubLayer];
        }
        
        //移除自己
        if (self.options.showEndAnimation) {
            [self.showBgView showEndAnimationWithDuration:self.options.showAnimationTime];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.options.showAnimationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
        }
        else{
            [UIView animateWithDuration:self.options.showAnimationTime animations:^{
                self.alpha = 0.1 ;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }] ;
        }
    }
    _timerShowTime++ ;
    
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

- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
}

- (NSTimer *)removeTimer
{
    if (nil == _removeTimer) {
        _removeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_removeTimer forMode:NSRunLoopCommonModes];
    }
    return _removeTimer ;
}

@end















