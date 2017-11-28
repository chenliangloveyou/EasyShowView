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
//    NSLog(@"%p dealloc",self );
}



- (NSTimer *)removeTimer
{
    if (nil == _removeTimer) {
        _removeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    return _removeTimer ;
}
- (void)timerAction
{
    if (_timerShowTime >= _showTime ) {
        
        _timerShowTime = 0 ;
        [_removeTimer invalidate];
        _removeTimer = nil ;
        
        if (self.options.showShadow) {
            for (CALayer *subLayer in self.layer.sublayers) {
                if ([subLayer.name isEqualToString:@"addsublayer"]) {
                    [subLayer removeFromSuperlayer];
                    break ;
                }
            }
        }
        
        if (self.options.showEndAnimation) {
            [self.showBgView showEndAnimationWithDuration:self.options.showAnimationDuration];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.options.showAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
        }
        else{
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.1 ;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }] ;
        }
    }
    _timerShowTime++ ;

}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text status:(ShowStatus)status image:(UIImage *)image
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.02];

        _showText = text ;
        _showImage = image ;
        _showStatus = status ;
        _showTime = 1 + text.length*0.1 ;
        if (_showTime > 6)  _showTime = 6 ;
    
        _timerShowTime = 0 ;
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
    
    CGSize textSize = [EasyShowUtils textWidthWithStirng:self.showText
                                                font:self.options.textFount
                                            maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
    
    //50 = imageH:40 + 上下边距:10
    CGFloat imageH = self.showStatus==ShowStatusText ?0:60 ;
    CGFloat backGroundH = textSize.height + 30 + imageH ;
    CGFloat backGroundW = textSize.width + 40 ;
    
    CGRect showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
    
    if (!self.options.superViewReceiveEvent) {//父视图不能接受事件
        
        self.bounds = superView.bounds ;
        self.center = superView.center ;

        CGFloat showFrameY = (self.height-backGroundH)/2  ;
        if (self.showStatus == ShowStatusText) {
            switch (self.options.textStatusType ) {
                case ShowStatusTextTypeTop:
                    showFrameY = [UIApplication sharedApplication].statusBarFrame.size.height + 50 ;
                    break;
                case ShowStatusTextTypeBottom:
                    showFrameY = self.height - backGroundH - 50 ;
                    break ;
                default: break;
            }
        }
        showFrame = CGRectMake((self.width-backGroundW)/2, showFrameY, backGroundW, backGroundH);

    }
    else{//父视图接受事件   self的大小为显示的区域
        
        CGFloat showFrameY = (SCREEN_HEIGHT-self.height)/2 ;
        if (self.showStatus == ShowStatusText) {
            switch (self.options.textStatusType ) {
                case ShowStatusTextTypeTop:
                    showFrameY = [UIApplication sharedApplication].statusBarFrame.size.height + 50 ;
                    break;
                case ShowStatusTextTypeBottom:
                    showFrameY = SCREEN_HEIGHT - backGroundH - 50 ;
                    break ;
                default: break;
            }
        }
        self.frame =  CGRectMake((SCREEN_WIDTH-backGroundW)/2, showFrameY, backGroundW, backGroundH);
        showFrame = CGRectMake(0, 0, backGroundW, backGroundH) ;
        [self setRoundedCorners:UIRectCornerAllCorners borderWidth:1 borderColor:[UIColor clearColor] cornerSize:CGSizeMake(5, 5)];

    }
    
    self.showBgView = [[EasyShowBgView alloc]initWithFrame:showFrame status:self.showStatus text:self.showText image:self.showImage];
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
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.options.showAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            CALayer *subLayer=[CALayer layer];
            CGRect fixframe = self.showBgView.frame;
            subLayer.frame= fixframe;
            subLayer.cornerRadius=8;
            subLayer.backgroundColor=self.options.shadowColor.CGColor;
            subLayer.masksToBounds=NO;
            subLayer.name = @"addsublayer";
            subLayer.shadowColor = self.options.shadowColor.CGColor;
            subLayer.shadowOffset = CGSizeMake(3,2);
            subLayer.shadowOpacity = 0.8;
            subLayer.shadowRadius = 4;
            [self.layer insertSublayer:subLayer below:self.showBgView.layer];
            
        });
    }
}


- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
}


+ (void)showText:(NSString *)text inView:(UIView *)view image:(UIImage *)image stauts:(ShowStatus)status
{
    if (ISEMPTY(text)) {
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
            showView.timerShowTime = 10 ;
            [showView timerAction];
        }
    }
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    EasyShowView  *showView = [[EasyShowView alloc]initWithFrame:CGRectZero text:text status:status image:image];
    [showView showViewWithSuperView:view];
}

+ (void)showLoding
{
    [EasyShowView showLodingText:@"加载中..."];
}
+ (void)showLodingText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showLodingText:text inView:showView];
}
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView image:nil stauts:ShowStatusLoding];
}
+ (void)showLodingText:(NSString *)text image:(UIImage *)image
{
    
}
+ (void)showLodingText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView
{
    
}
+ (void)hidenLoding
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView hidenLoingInView:showView];
}
+ (void)hidenAllLoding
{
    
}
+ (void)hidenLoingInView:(UIView *)superView
{
    NSEnumerator *subviewsEnum = [superView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowView *showView = (EasyShowView *)subview ;
            showView.timerShowTime = 10 ;
            [showView timerAction];
        }
    }
}
+ (void)showText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showText:text inView:showView];
}

+ (void)showText:(NSString *)text inView:(UIView *)view
{
    [EasyShowView showText:text inView:view image:nil stauts:ShowStatusText];
}

+ (void)showSuccessText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showSuccessText:text inView:showView];
}
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView image:nil stauts:ShowStatusSuccess];
}

+ (void)showErrorText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showErrorText:text inView:showView];
}
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView image:nil stauts:ShowStatusError];
}

+ (void)showInfoText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showInfoText:text inView:showView];
}
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView image:nil stauts:ShowStatusInfo];
}

+ (void)showImageText:(NSString *)text image:(UIImage *)image
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showImageText:text image:image inView:showView] ;
}
+ (void)showImageText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView image:image stauts:ShowStatusImage] ;
}
@end















