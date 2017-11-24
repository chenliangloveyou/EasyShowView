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

#define kDrawImageWH 40
#define KImageEdgeH 15

@interface EasyShowView()<CAAnimationDelegate>
{
    NSString *_text ;
}

@property ShowStatus showStatus ;
@property (nonatomic,strong)EasyShowOptions *options ;

@property (nonatomic,strong)UIView *backGrouldView ;
@property (nonatomic,strong)UILabel *textLabel ;

@property (nonatomic,strong)NSTimer *removeTimer ;
@property (nonatomic,assign)CGFloat showTime ;

@end

@implementation EasyShowView
- (void)dealloc
{
    
}

- (void)addAnimationImage
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.width-kDrawImageWH)/2, KImageEdgeH, kDrawImageWH, kDrawImageWH) cornerRadius:kDrawImageWH/2];
    UIColor *drawColor = nil ;
    switch (_showStatus) {
        case ShowStatusText:
            return ;
        case ShowStatusSuccess:
        {
            [path moveToPoint:CGPointMake((self.width-kDrawImageWH)/2+kDrawImageWH/4, KImageEdgeH +3 + kDrawImageWH/2)];
            [path addLineToPoint:CGPointMake(self.width/2, KImageEdgeH + kDrawImageWH*3/4)];
            [path addLineToPoint:CGPointMake(self.width/2 + kDrawImageWH*1/3, KImageEdgeH + kDrawImageWH*1/3)];
            
            drawColor = [UIColor greenColor] ;
        } break;
        case ShowStatusError:
        {
            [path moveToPoint:CGPointMake(self.width/2-kDrawImageWH/4, KImageEdgeH+kDrawImageWH/4)];
            [path addLineToPoint:CGPointMake(self.width/2+kDrawImageWH/4, KImageEdgeH+kDrawImageWH*3/4)];
            
            [path moveToPoint:CGPointMake(self.width/2+kDrawImageWH/4, KImageEdgeH+kDrawImageWH/4)];
            [path addLineToPoint:CGPointMake(self.width/2-kDrawImageWH/4, KImageEdgeH+kDrawImageWH*3/4)];
            
            drawColor = [UIColor redColor] ;
        }break ;
        case ShowStatusInfo:
        {
            [path moveToPoint:CGPointMake(self.width/2, KImageEdgeH + kDrawImageWH/4 )];
            [path addLineToPoint:CGPointMake(self.width/2,KImageEdgeH + kDrawImageWH*3/4)];
            
            [path moveToPoint:CGPointMake(self.width/2,KImageEdgeH + kDrawImageWH*3/4 + 2)];
            [path addLineToPoint:CGPointMake(self.width/2,KImageEdgeH + kDrawImageWH*3/4 + 4 )];
            
            drawColor = [UIColor lightGrayColor] ;
        }break ;
        default:
            break;
    }
   
    CAShapeLayer *lineLayer = [ CAShapeLayer layer];
    
    lineLayer. frame = CGRectZero;
    lineLayer. fillColor = [ UIColor clearColor ]. CGColor ;
    lineLayer. path = path. CGPath ;
    lineLayer. strokeColor = drawColor.CGColor ;
    lineLayer.lineWidth = 2;
    lineLayer.cornerRadius = 50;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    ani. fromValue = @0 ;
    ani. toValue = @1 ;
    ani. duration = 0.5 ;
    [lineLayer addAnimation :ani forKey :@"strokeEnd"];
    
    [self.layer addSublayer :lineLayer];
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
    static int actionTime = 0 ;
    if (actionTime >= _showTime ) {
        [self removeFromSuperview];
        [_backGrouldView removeFromSuperview];
        _backGrouldView = nil ;
        
        actionTime = 0 ;
        [_removeTimer invalidate];
        _removeTimer = nil ;
    }
    actionTime++ ;
}

- (UILabel *)textLabel
{
    if (nil == _textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = [UIColor purpleColor];
        _textLabel.textAlignment = NSTextAlignmentCenter ;
    }
    return _textLabel ;
}
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text status:(ShowStatus)status
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor blackColor];

        _text = text ;
        _showStatus = status ;
        _showTime = 1 + _text.length*0.1 ;
       
        CGSize textSize = [_text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH*self.options.maxWidthScale, SCREEN_HEIGHT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:self.options.textFount}
                                         context:nil].size;
        
        if (textSize.width < 60) {
            textSize.width = 60 ;
        }
        
 
       
        //50 = imageH:40 + 上下边距:10

        CGFloat imageH = _showStatus==ShowStatusText ?0:60 ;
        CGFloat backGroundH = textSize.height + 30 + imageH ;
        
        CGFloat backGroundW = textSize.width + 40 ;
        
        self.frame = CGRectMake(0, 0, backGroundW, backGroundH);
        
        _backGrouldView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-backGroundW)/2, (SCREEN_HEIGHT-backGroundH)/2, backGroundW, backGroundH)];
        _backGrouldView.backgroundColor = [UIColor greenColor];
        [_backGrouldView setRoundedCorners:UIRectCornerAllCorners borderWidth:2 borderColor:[UIColor yellowColor] cornerSize:CGSizeMake(10, 10)];

        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, imageH + 15,textSize.width, textSize.height)];
        label.text = _text ;
        label.textAlignment = NSTextAlignmentCenter ;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = self.options.textFount ;
        label.numberOfLines = 0 ;
        [self addSubview:label];
        
        [self.removeTimer fire];
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
   
    [superView addSubview:self.backGrouldView];
    [self.backGrouldView addSubview:self];

    
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
    [self.backGrouldView.layer addAnimation:popAnimation forKey:nil];
    
    [self addAnimationImage];
}


- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [[EasyShowOptions alloc]init];
    }
    return _options ;
}
+ (void)showText:(NSString *)text
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    [EasyShowView showText:text inView:showView];
}

+ (void)showText:(NSString *)text inView:(UIView *)view
{
    if (ISEMPTY(text)) {
        NSAssert(NO, @"you should set a text for showView !");
        return ;
    }
    
    [EasyShowView showText:text inView:view stauts:ShowStatusText];
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
    EasyShowView  *showView = [[EasyShowView alloc]initWithFrame:CGRectZero text:text status:status];
    [showView showViewWithSuperView:view];
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















