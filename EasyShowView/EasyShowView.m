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

#define AUTOLAYTOU(a) ((a)*(SCREEN_WIDTH/320))
#define WARN_WIDTH (self.frame.size.width-AUTOLAYTOU(120))



@interface EasyShowView()<CAAnimationDelegate>

@property (nonatomic,strong)EasyShowOptions *options ;

@property (nonatomic,strong)NSTimer *removeTimer ;
@property (nonatomic,assign)CGFloat showTime ;
@property CGFloat timerShowTime ;//定时器走动的时间

@property (nonatomic,weak)UIView *superView ;

@property (nonatomic,strong)EasyShowBgView *showBgView ;//用于放图片和文字的背景

@end

@implementation EasyShowView
- (void)dealloc
{
//    NSLog(@"%p cealloc",self );
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
        NSLog(@"%p timerAction",self );

        
        _timerShowTime = 0 ;
        [_removeTimer invalidate];
        _removeTimer = nil ;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.02 ;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }] ;
    }
    _timerShowTime++ ;
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text status:(ShowStatus)status
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];

        _showTime = 1 + text.length*0.1 ;
        if (_showTime > 6)  _showTime = 6 ;
    
        _timerShowTime = 0 ;

        CGSize textSize = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH*self.options.maxWidthScale, SCREEN_HEIGHT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:self.options.textFount}
                                         context:nil].size;
        
        if (textSize.width < 60)  textSize.width = 60 ;
        
        //50 = imageH:40 + 上下边距:10
        CGFloat imageH = status==ShowStatusText ?0:60 ;
        CGFloat backGroundH = textSize.height + 30 + imageH ;
        
        CGFloat backGroundW = textSize.width + 40 ;
        
        CGRect showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
        
        if (!self.options.superViewReceiveEvent) {
//            self.frame =
            showFrame = CGRectMake((self.width-backGroundW)/2, (self.height-backGroundH)/2, backGroundW, backGroundH); ;
        }
        else{
            showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
            self.frame =  CGRectMake(0, 0, backGroundW, backGroundH);
        }
        self.showBgView = [[EasyShowBgView alloc]initWithFrame:showFrame status:status text:text];
        [self addSubview:self.showBgView];
        
        [self.removeTimer fire];
        
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
   
    [superView addSubview:self];
    if (!self.options.superViewReceiveEvent) {
        self.bounds = superView.bounds ;
        self.alpha = 0.02 ;
    }else{
        
    }
    self.center = superView.center ;
    [self setRoundedCorners:UIRectCornerAllCorners borderWidth:2 borderColor:[UIColor blueColor] cornerSize:CGSizeMake(5, 5)];

    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
    
}


- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [[EasyShowOptions alloc]init];
    }
    return _options ;
}


+ (void)showText:(NSString *)text inView:(UIView *)view stauts:(ShowStatus)status
{
    if (ISEMPTY(text)) {
        NSAssert(NO, @"you should set a text for showView !");
        return ;
    }
    if (nil == view) {
        NSAssert(NO, @"there shoud have a superview");
        return ;
    }
    
    //隐藏之前还在显示的视图
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowView *showView = (EasyShowView *)subview ;
            showView.timerShowTime = 10 ;
            [showView timerAction];
        }
    }
    
    EasyShowView  *showView = [[EasyShowView alloc]initWithFrame:CGRectZero text:text status:status];
    [showView showViewWithSuperView:view];
    NSLog(@"%p create", showView);
}



+ (void)showText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showText:text inView:showView];
}

+ (void)showText:(NSString *)text inView:(UIView *)view
{
    [EasyShowView showText:text inView:view stauts:ShowStatusText];
}

+ (void)showSuccessText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showSuccessText:text inView:showView];
}
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView stauts:ShowStatusSuccess];
}

+ (void)showErrorText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showErrorText:text inView:showView];
}
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView stauts:ShowStatusError];
}

+ (void)showInfoText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showInfoText:text inView:showView];
}
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView
{
    [EasyShowView showText:text inView:superView stauts:ShowStatusInfo];
}
@end















