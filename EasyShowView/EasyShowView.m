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

@property (nonatomic,strong)UILabel *textLabel ;

@property (nonatomic,strong)NSTimer *removeTimer ;
@property (nonatomic,assign)CGFloat showTime ;
@property CGFloat timerShowTime ;//定时器走动的时间

@end

@implementation EasyShowView
- (void)dealloc
{
//    NSLog(@"%p cealloc",self );
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
            [path addLineToPoint:CGPointMake(self.width/2,KImageEdgeH + kDrawImageWH/4 + 3)];
            
            [path moveToPoint:CGPointMake(self.width/2,KImageEdgeH + kDrawImageWH/4 + 6)];
            [path addLineToPoint:CGPointMake(self.width/2,KImageEdgeH + kDrawImageWH*3/4 )];
            
            drawColor = [UIColor lightGrayColor] ;
        }break ;
        default:
            break;
    }
   
    CAShapeLayer *lineLayer = [ CAShapeLayer layer];
    lineLayer.frame = CGRectZero;
    lineLayer.fillColor = [ UIColor clearColor ].CGColor ;
    lineLayer.path = path. CGPath ;
    lineLayer.strokeColor = [UIColor whiteColor].CGColor ;
    lineLayer.lineWidth = 2;
    lineLayer.cornerRadius = 50;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    ani.fromValue = @0 ;
    ani.toValue = @1 ;
    ani.duration = 0.5 ;
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
        if (_showTime > 6) {
            _showTime = 6 ;
        }

        _timerShowTime = 0 ;

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
   
    [superView addSubview:self];
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















