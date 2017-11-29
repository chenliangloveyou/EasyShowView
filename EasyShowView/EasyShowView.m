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
    NSLog(@"%p dealloc",self );
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
    
    EasyShowView  *showView = [[EasyShowView alloc]initWithFrame:CGRectZero text:text status:status image:image];
    [showView showViewWithSuperView:view];
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text status:(ShowStatus)status image:(UIImage *)image
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.02];
        
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
    CGSize textSize = CGSizeZero ;
    if (!ISEMPTY(self.showText)) {
        textSize = [EasyShowUtils textWidthWithStirng:self.showText
                                                 font:self.options.textFount
                                             maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
    }

    //50 = imageH:40 + 上下边距:10
    //无文字。 W:60 H: 60 有文字。W:文字宽度+40,>=100 H:文字高+30+图片高,
    
    CGFloat imageH = self.showStatus==ShowStatusText ?:(kDrawImageWH + KDrawImageEdgeH) ;
    CGFloat backGroundH = (textSize.height?(textSize.height+30):0) + imageH ;
    CGFloat backGroundW = textSize.width?(textSize.width+40):0  ;
    if (backGroundW < kShowViewMinWidth) {
        backGroundW = kShowViewMinWidth  ;
    }
    
    //计算出showView的大小
    if (self.showStatus == ShowStatusLoding) {//特殊处理
        if (self.options.showLodingType > ShowLodingTypeImage) {//左右的形式
            backGroundH = textSize.height + 30 ;
            if (backGroundH < kShowViewMinWidth) {
                backGroundH = kShowViewMinWidth ;
            }
            backGroundW  = (textSize.width?(textSize.width+40):0) + imageH ;
        }
        else{   //上下的形式

        }
    }
    
    CGFloat showFrameY = (SCREEN_HEIGHT-backGroundH)/2  ;
    if (self.showStatus == ShowStatusText) {
        switch (self.options.textStatusType ) {
            case ShowStatusTextTypeTop:
                showFrameY = STATUSBAR_ORGINAL_HEIGHT + kTextShowEdgeDistance ;
                break;
            case ShowStatusTextTypeBottom:
                showFrameY = SCREEN_HEIGHT - backGroundH - kTextShowEdgeDistance ;
                break ;
            default: break;
        }
    }
    
    CGRect showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
    if (self.options.superViewReceiveEvent) {//父视图不能接受事件
       
        self.frame =  CGRectMake((SCREEN_WIDTH-backGroundW)/2, showFrameY, backGroundW, backGroundH);
    }
    else{//父视图接受事件   self的大小为显示的区域
      
        self.frame = CGRectMake(0, 0, superView.width, superView.height) ;
        showFrame.origin = CGPointMake((self.width-backGroundW)/2, showFrameY) ;
    }
    
    self.showBgView = [[EasyShowBgView alloc]initWithFrame:showFrame
                                                    status:self.showStatus
                                                      text:self.showText
                                                     image:self.showImage];
    [self addSubview:self.showBgView];
    
    if (self.showStatus != ShowStatusLoding) {
        [self.removeTimer fire];
    }
    
    if (self.options.showStartAnimation) {
        [self.showBgView showStartAnimationWithDuration:self.options.showAnimationDuration];
        [superView addSubview:self];
    }
    else{
        self.alpha = 0.1 ;
        [UIView animateWithDuration:self.options.showAnimationDuration animations:^{
            self.alpha = 1.0 ;
        } completion:^(BOOL finished) {
            [superView addSubview:self];
        }];
    }
    
    if (self.options.showShadow) {
        CGFloat afterStart = self.options.showStartAnimation ? self.options.showAnimationDuration :0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterStart * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showBackgrouldsubLayer];
        });
    }
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
    }
    return _removeTimer ;
}

@end















