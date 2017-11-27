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
        
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0.02 ;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }] ;
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
    [superView addSubview:self];
    
    CGSize textSize = [EasyUtils textWidthWithStirng:self.showText
                                                font:self.options.textFount
                                            maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
    
    //50 = imageH:40 + 上下边距:10
    CGFloat imageH = self.showStatus==ShowStatusText ?0:60 ;
    CGFloat backGroundH = textSize.height + 30 + imageH ;
    CGFloat backGroundW = textSize.width + 40 ;
    
    CGRect showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
    
    if (!self.options.superViewReceiveEvent) {
        
        self.bounds = superView.bounds ;
        showFrame = CGRectMake((self.width-backGroundW)/2, (self.height-backGroundH)/2, backGroundW, backGroundH); ;
        
    }
    else{
        self.frame =  CGRectMake(0, 0, backGroundW, backGroundH);
        showFrame = self.frame ;
        [self setRoundedCorners:UIRectCornerAllCorners borderWidth:2 borderColor:[UIColor blueColor] cornerSize:CGSizeMake(5, 5)];
    }
    
    self.showBgView = [[EasyShowBgView alloc]initWithFrame:showFrame status:self.showStatus text:self.showText image:self.showImage];
    [self addSubview:self.showBgView];

    [self.removeTimer fire];

    self.center = superView.center ;
  
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
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
    
    //隐藏之前还在显示的视图
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowView *showView = (EasyShowView *)subview ;
            showView.timerShowTime = 10 ;
            [showView timerAction];
        }
    }
    
    EasyShowView  *showView = [[EasyShowView alloc]initWithFrame:CGRectZero text:text status:status image:image];
    [showView showViewWithSuperView:view];
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















