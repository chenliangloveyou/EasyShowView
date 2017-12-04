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

@property (nonatomic,strong)EasyShowOptions *options ;

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)UIImage *showImage ;//展示的图片
@property (nonatomic,assign)ShowStatus showStatus ;//展示的类型
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

+ (void)showText:(NSString *)text inView:(UIView *)view image:(UIImage *)image stauts:(ShowStatus)status
{
    if (ISEMPTY(text) && status!=ShowStatusLoding) {
        NSAssert(NO, @"you should set a text for showView !");
        return ;
    }
    if (nil == view) {
        NSAssert(NO, @"there shoud have a superview");
        return ;
    }
    
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    
    //隐藏之前还在显示的视图
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
    
    EasyShowView  *showView = [[EasyShowView alloc] initWithFrame:CGRectZero
                                                             text:text
                                                           status:status
                                                            image:image];
    [showView showViewWithSuperView:view];
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text status:(ShowStatus)status image:(UIImage *)image
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor purpleColor] ;// [[UIColor lightGrayColor] colorWithAlphaComponent:0.02]; //
        
        _showText = text ;
        _showImage = image ;
        _showStatus = status ;
        _showTime = 1 + text.length*0.1 ;
        if (_showTime > self.options.maxShowTime)  _showTime = self.options.maxShowTime ;
        
        _timerShowTime = 0 ;
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
    
    CGRect showFrame = [self getShowRectWithSuperView:superView];
    
    self.showBgView = [[EasyShowBgView alloc]initWithFrame:showFrame
                                                    status:self.showStatus
                                                      text:self.showText
                                                     image:self.showImage];
    [self addSubview:self.showBgView];
    
    if (self.showStatus != ShowStatusLoding) {
        [self.removeTimer fire];
    }
    
    if (self.options.showStartAnimation) {
        
        if (self.options.textStatusType == ShowStatusTextTypeStatusBar) {
            [UIView animateWithDuration:self.options.showAnimationDuration animations:^{
                self.y = 0 ;
            }] ;
        }
        else{
            [self.showBgView showStartAnimationWithDuration:self.options.showAnimationDuration];
        }
        [superView addSubview:self];
        
    }
    else{
        if (self.options.textStatusType == ShowStatusTextTypeStatusBar) {
            self.y = 0 ;
        }
        else{
            self.alpha = 0.1 ;
            [UIView animateWithDuration:self.options.showAnimationDuration animations:^{
                self.alpha = 1.0 ;
            } completion:^(BOOL finished) {
                [superView addSubview:self];
            }];
        }
       
    }
    
    if (self.options.showShadow) {
        CGFloat afterStart = self.options.showStartAnimation ? self.options.showAnimationDuration :0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterStart * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showBackgrouldsubLayer];
        });
    }
}

//获取需要展示框的大小
- (CGRect)getShowRectWithSuperView:(UIView *)superView
{
    CGSize textSize = CGSizeZero ;
    if (!ISEMPTY(self.showText)) {
        textSize = [EasyShowUtils textWidthWithStirng:self.showText
                                                 font:self.options.textFount
                                             maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
    }
    
    
    //这是显示在statusbar上的情况
//    if (self.showStatus==ShowStatusText && self.options.textStatusType==ShowStatusTextTypeStatusBar) {
//
//        [superView addSubview:self];
//
//        //        [self.removeTimer fire];
//
//        [UIView animateWithDuration:self.options.showAnimationDuration animations:^{
//            CGRect frame = self.showTextWindow.frame;
//            frame.origin.y = 0;
//            self.showTextWindow.frame = frame;
//        }completion:^(BOOL finished) {
//            [self.showTextWindow removeFromSuperview];
//            self.showTextWindow = nil;
//            //            [self hd_removeAllSubviews];
//            [self removeFromSuperview];
//
//            [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
//        }];
//        return ;
//    }

    //显示图片的高度。
    CGFloat imageH = self.showStatus==ShowStatusText ?:(EasyDrawImageWH + EasyDrawImageEdge) ;

    //50 = imageH:40 + 上下边距:10
    //无文字。 W:60 H: 60 有文字。W:文字宽度+40,>=100 H:文字高+30+图片高,
    
    //显示区域的宽高
    CGFloat backGroundH = 0 ;
    CGFloat backGroundW = 0 ;
    if (self.options.textStatusType == ShowStatusTextTypeStatusBar) {
        backGroundH = STATUSBAR_ORGINAL_HEIGHT ;
        backGroundW = SCREEN_WIDTH ;
    }
    else{
        backGroundH = (textSize.height?(textSize.height+30):0) + imageH ;
        backGroundW = textSize.width?(textSize.width+40):0  ;
        
        if (backGroundW < EasyShowViewMinWidth) {
            backGroundW = EasyShowViewMinWidth  ;
        }
    }
    
    //计算出showView的大小
    if (self.showStatus == ShowStatusLoding) {//特殊处理
        if (self.options.showLodingType > ShowLodingTypeImage) {//左右的形式
            backGroundH = textSize.height + 30 ;
            if (backGroundH < EasyShowViewMinWidth) {
                backGroundH = EasyShowViewMinWidth ;
            }
            backGroundW  = (textSize.width?(textSize.width+40):0) + imageH ;
        }
        else{   //上下的形式
            
        }
    }
    
    //显示区域的y值
    CGFloat showFrameY = (SCREEN_HEIGHT-backGroundH)/2  ;//默认显示在中间
    if (self.showStatus != ShowStatusLoding) {
        switch (self.options.textStatusType ) {
            case ShowStatusTextTypeStatusBar:
                showFrameY = - STATUSBAR_ORGINAL_HEIGHT ;//开始先放到startbar上面，然后动画展示下来.
                break ;
            case ShowStatusTextTypeTop:
                showFrameY = STATUSBAR_ORGINAL_HEIGHT + EasyTextShowEdge ;
                break;
            case ShowStatusTextTypeBottom:
                showFrameY = SCREEN_HEIGHT - backGroundH - EasyTextShowEdge ;
                break ;
            default: break;
        }
    }
    
    
    //显示区域的frame
    CGRect showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
    
    if (self.showStatus==ShowStatusText && self.options.textStatusType==ShowStatusTextTypeStatusBar) {
        //控件显示在statusbar上面
        showFrame.origin.y = showFrameY ;
        self.frame = showFrame ;
    }
    else if (self.options.superViewReceiveEvent) {
       
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
        
        _timerShowTime = 0 ;
        if (_removeTimer) {
            [_removeTimer invalidate];
            _removeTimer = nil ;
        }
       
        if (self.options.showShadow) {
            [self hiddenBackgrouldsubLayer];
        }
        
        if (self.options.showEndAnimation) {
            [self.showBgView showEndAnimationWithDuration:self.options.showAnimationDuration];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.options.showAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
        }
        else{
            [UIView animateWithDuration:self.options.showAnimationDuration animations:^{
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















