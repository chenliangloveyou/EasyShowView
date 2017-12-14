//
//  EasyShowLodingView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowLodingView.h"
#import "UIView+EasyShowExt.h"

@interface EasyShowLodingView()

@end


@implementation EasyShowLodingView

- (CGRect)showRectWithSpuerView:(UIView *)superView
{
    //显示图片的高度。
    CGFloat imageH = (EasyDrawImageWH + EasyDrawImageEdge) ;
    
    //显示区域的宽高
    CGFloat backGroundH = 0 ;
    CGFloat backGroundW = SCREEN_WIDTH ;
    
    CGSize textSize = CGSizeZero ;
    if (!ISEMPTY(self.showText)) {
        textSize = [EasyShowUtils textWidthWithStirng:self.showText
                                                 font:self.options.textFount
                                             maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
    }
    backGroundH = (textSize.height?(textSize.height+30):0) ;
    backGroundW = textSize.width?(textSize.width+40):0  ;
    
    if (self.options.showLodingType > ShowLodingTypeImage) {//左右形式
        backGroundW = backGroundW + imageH ;
    }
    else{//上下形式
        backGroundH = backGroundH + imageH ;
    }
    
    if (backGroundW < EasyShowViewMinWidth) {
        backGroundW = EasyShowViewMinWidth  ;
    }
    if (backGroundH < EasyShowViewMinWidth) {
        backGroundH = EasyShowViewMinWidth  ;
    }
    CGFloat showFrameY = (SCREEN_HEIGHT-backGroundH)/2  ;//默认显示在中间
    //显示区域的frame
    CGRect showFrame = CGRectMake(0, showFrameY, backGroundW, backGroundH);
    if (!self.options.superViewReceiveEvent) {
        
        showFrame.origin = CGPointMake((self.width-backGroundW)/2, showFrameY) ;
    }
    
    return showFrame ;
}





+ (void)showLodingWithText:(NSString *)text
                   inView:(UIView *)view
                    image:(UIImage *)image
{
    
    if (nil == view) {
        NSAssert(NO, @"there shoud have a superview");
        return ;
    }
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    //显示之前---->隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowView *showView = (EasyShowView *)subview ;
            [showView removeSelfFromSuperView];
        }
    }
    
    EasyShowLodingView *showView = [[EasyShowLodingView alloc] initWithFrame:CGRectZero];
    showView.showText = text ;
    showView.showImage = image ;
    showView.showType = ShowTypeLoding;
    [showView showViewWithSuperView:view];
    
}


+ (void)showLoding
{
    [self showLodingText:@""];
}
+ (void)showLodingText:(NSString *)text
{
    UIView *showView = kTopViewController.view ;
    [self showLodingText:text inView:showView];
}
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView
{
    [self showLodingText:text image:nil inView:superView];
}
+ (void)showLodingText:(NSString *)text image:(UIImage *)image
{
    UIView *showView = kTopViewController.view ;
    [self showLodingText:text image:image inView:showView];
}
+ (void)showLodingText:(NSString *)text image:(UIImage *)image inView:(UIView *)superView
{
    [self showLodingWithText:text inView:superView image:image];
}


+ (void)hidenLoding
{
    UIView *showView = kTopViewController.view ;
    [self hidenLoingInView:showView];
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
            [showView removeSelfFromSuperView];
        }
    }
}



@end
