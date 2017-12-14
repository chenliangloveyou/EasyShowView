//
//  EasyShowTextView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowTextView.h"
#import "UIView+EasyShowExt.h"

@interface EasyShowTextView()

@property (nonatomic,strong)NSTimer *removeTimer ;
@property (nonatomic,assign)CGFloat showTime ;
@property CGFloat timerShowTime ;//定时器走动的时间


@end

@implementation EasyShowTextView


+ (void)showToastWithText:(NSString *)text
                   inView:(UIView *)view
                    image:(UIImage *)image
                   stauts:(ShowTextStatus)status
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
  
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    //显示之前隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowView *showView = (EasyShowView *)subview ;
            [showView removeSelfFromSuperView];
        }
    }
    
    EasyShowTextView *showView = [[EasyShowTextView alloc] initWithFrame:CGRectZero];
    showView.showText = text ;
    showView.showImage = image ;
    
    showView.showTextStatus = status ;

    showView.showTime = 1 + text.length*0.15 ;
    if (showView.showTime > [EasyShowOptions sharedEasyShowOptions].maxShowTime) {
        showView.showTime = [EasyShowOptions sharedEasyShowOptions].maxShowTime ;
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
    CGFloat backGroundW = SCREEN_WIDTH ;
    switch (self.options.textStatusType) {
        case ShowTextStatusTypeStatusBar://如果是在statusbar上，则高固定，不需要计算
            backGroundH = STATUSBAR_HEIGHT ;
            break;
        case ShowTextStatusTypeNavigation:
            backGroundH = NAVIGATION_HEIGHT ;
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
        case ShowTextStatusTypeNavigation:
        case ShowTextStatusTypeStatusBar:
            showFrameY = 0 ;
            break ;
        case ShowTextStatusTypeTop:
            showFrameY = NAVIGATION_HEIGHT + EasyTextShowEdge ;
            break;
        case ShowTextStatusTypeBottom:
            showFrameY = SCREEN_HEIGHT - backGroundH - EasyTextShowEdge ;
            break ;
        default: break;
    }
    //    }
    
    //显示区域的frame
    CGRect showFrame = CGRectMake(0, showFrameY, backGroundW, backGroundH);
    
    if (!self.options.superViewReceiveEvent) {
        showFrame.origin = CGPointMake((self.width-backGroundW)/2, showFrameY) ;
    }
    
    return showFrame ;
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
    [self showToastWithText:text inView:view image:nil stauts:ShowTextStatusPureText];
}

+ (void)showSuccessText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showSuccessText:text inView:showView];
}
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView
{
    [self showToastWithText:text inView:superView image:nil stauts:ShowTextStatusSuccess];
}

+ (void)showErrorText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showErrorText:text inView:showView];
}
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView
{
    [self showToastWithText:text inView:superView image:nil stauts:ShowTextStatusError];
}

+ (void)showInfoText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showInfoText:text inView:showView];
}
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView
{
    [self showToastWithText:text inView:superView image:nil stauts:ShowTextStatusInfo];
}

+ (void)showImageText:(NSString *)text image:(UIImage *)image
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [self showImageText:text image:image inView:showView] ;
}
+ (void)showImageText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView
{
    [self showToastWithText:text inView:superView image:image stauts:ShowTextStatusImage] ;
}

@end
