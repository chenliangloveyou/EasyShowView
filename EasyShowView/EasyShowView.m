//
//  EFShowView.m
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//


#import "EasyShowView.h"


#import "UIView+EasyShowExt.h"

#define AUTOLAYTOU(a) ((a)*(SCREEN_WIDTH/320))
#define WARN_WIDTH (self.frame.size.width-AUTOLAYTOU(120))

@interface EasyShowView()<CAAnimationDelegate>
{
    NSString *_text ;
}

@property ShowStatus showStatus ;

@property (nonatomic,strong)UIView *backGrouldView ;
@property (nonatomic,strong)UILabel *textLabel ;

@property (nonatomic,strong)NSTimer *removeTimer ;
@property (nonatomic,assign)NSUInteger showTime ;

@end

@implementation EasyShowView
- (void)dealloc
{
    
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
    if (actionTime == _showTime ) {
        [self removeFromSuperview];
        [_backGrouldView removeFromSuperview];
        _backGrouldView = nil ;
        
        actionTime = 0 ;
        [_removeTimer invalidate];
        _removeTimer = nil ;
    }
    actionTime++ ;
}
- (UIView *)backGrouldView
{
    if (nil == _backGrouldView) {
        _backGrouldView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backGrouldView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    }
    return _backGrouldView ;
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.frame.size.width-WARN_WIDTH)/2, 8, WARN_WIDTH, WARN_WIDTH) cornerRadius:WARN_WIDTH/2];
    UIColor *drawColor = nil ;
    switch (_showStatus) {
        case ShowStatusText:
            return ;
        case ShowStatusSuccess:
        {
            [path moveToPoint:CGPointMake((self.frame.size.width-WARN_WIDTH)/2+10, WARN_WIDTH/2)];
            [path addLineToPoint:CGPointMake(self.frame.size.width/2.0-10, WARN_WIDTH-20)];
            [path addLineToPoint:CGPointMake(self.frame.size.width/2.0 + WARN_WIDTH/2-15, AUTOLAYTOU(35))];
            
            drawColor = [UIColor greenColor] ;
        } break;
        case ShowStatusError:
        {
            [path moveToPoint:CGPointMake((self.frame.size.width-WARN_WIDTH)/2+AUTOLAYTOU(20), AUTOLAYTOU(25))];
            [path addLineToPoint:CGPointMake(self.frame.size.width/2.0 + WARN_WIDTH/2-AUTOLAYTOU(20), WARN_WIDTH-AUTOLAYTOU(15)+AUTOLAYTOU(3))];
            
            [path moveToPoint:CGPointMake(self.frame.size.width/2.0 + WARN_WIDTH/2-AUTOLAYTOU(20), AUTOLAYTOU(25))];
            [path addLineToPoint:CGPointMake((self.frame.size.width-WARN_WIDTH)/2+AUTOLAYTOU(20), WARN_WIDTH-AUTOLAYTOU(15)+AUTOLAYTOU(3))];
            
            drawColor = [UIColor redColor] ;
        }break ;
        case ShowStatusInfo:
        {
            [path moveToPoint:CGPointMake(self.frame.size.width/2.0, AUTOLAYTOU(15))];
            [path addLineToPoint:CGPointMake(self.frame.size.width/2.0, WARN_WIDTH-AUTOLAYTOU(20))];
            
            [path moveToPoint:CGPointMake(self.frame.size.width/2.0, WARN_WIDTH-AUTOLAYTOU(15))];
            [path addLineToPoint:CGPointMake(self.frame.size.width/2.0, WARN_WIDTH-AUTOLAYTOU(8))];
            
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
    lineLayer.lineWidth = 5;
    lineLayer.cornerRadius = 50;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    ani. fromValue = @0 ;
    ani. toValue = @1 ;
    ani. duration = 0.5 ;
    [lineLayer addAnimation :ani forKey :@"strokeEnd"];
    
    [self.layer addSublayer :lineLayer];
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
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _showTime = 1 + _text.length*0.1 ;
       
        
        
        //label 宽度 130 - 230 高度 40 - 100
        //image 宽高 40 40
        //背景   宽度 label+40 高度 label+image+40
        CGRect rect = [_text boundingRectWithSize:CGSizeMake(230, 100)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                         context:nil];
        
        UIView *showView =[[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-rect.size.width-40)/2, 200, rect.size.width+40, rect.size.height+30)];
        showView.backgroundColor = [UIColor blackColor];
        
        [showView setRoundedCorners];
        
        
        self.backGrouldView.frame = CGRectZero ;
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 15,rect.size.width, rect.size.height)];
        label.text = _text ;
        label.textAlignment = NSTextAlignmentCenter ;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:17];
        label.numberOfLines = 0 ;
        [self addSubview:label];
        
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
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
    
    [superView addSubview:self.backGrouldView];
    [self.backGrouldView addSubview:self];
    self.center = self.backGrouldView.center;
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
    
    EasyShowView  *showView = [[EasyShowView alloc]initWithFrame:CGRectZero];
    showView->_text = text ;
    showView->_showStatus = ShowStatusText ;
    [showView showViewWithSuperView:view];
}



+ (void)showSuccessText:(NSString *)text
{
    
}
+ (void)showSuccessText:(NSString *)text inView:(UIView *)superView
{
    
}

+ (void)showErrorText:(NSString *)text
{
    
}
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView
{
    
}

+ (void)showInfoText:(NSString *)text
{
    
}
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView
{
    
    
}
@end















