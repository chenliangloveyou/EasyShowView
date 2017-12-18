//
//  EasyShowLodingView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowLodingView.h"
#import "UIView+EasyShowExt.h"
#import "EasyShowBgView.h"

@interface EasyShowLodingBgView : UIView

@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *imageView ;

@property (nonatomic,strong)UIActivityIndicatorView *imageViewIndeicator ;

@property (nonatomic,strong)EasyShowOptions *options ;


- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text image:(UIImage *)image;

- (void)showStartAnimationWithDuration:(CGFloat)duration ;
- (void)showEndAnimationWithDuration:(CGFloat)duration  ;

@end

@implementation EasyShowLodingBgView


- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text image:(UIImage *)image
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = self.options.backGroundColor ; //[UIColor redColor]; //
        
        if ( self.options.lodingShowType>LodingShowTypeImage) {//左右的形式
            self.imageView.frame = CGRectMake(EasyDrawImageEdge/2, EasyDrawImageEdge/2, EasyDrawImageWH, EasyDrawImageWH);
        }
        if (image) {
            self.imageView.image = image ;
        }
        
        if (!ISEMPTY(text)) {
            CGSize textSize = [EasyShowUtils textWidthWithStirng:text
                                                            font:self.options.textFount
                                                        maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
            self.textLabel.text = text ;
            
            if (self.options.lodingShowType > LodingShowTypeImage) {//左右的形式
                self.textLabel.frame = CGRectMake(EasyDrawImageWH + 20,self.height-textSize.height-15 ,textSize.width, textSize.height) ;
            }
            else{//上下形式
                self.textLabel.frame = CGRectMake( 20,self.height-textSize.height-15 ,textSize.width, textSize.height) ;
            }
        }
        
        switch (self.options.lodingShowType) {
            case LodingShowTypeDefault:
            case LodingShowTypeLeftDefault:
                [self drawAnimationImageViewLoding];
                break;
            case LodingShowTypeIndicator:
            case LodingShowTypeLeftIndicator:
                [self.imageViewIndeicator startAnimating];
                break ;
            case LodingShowTypeImage:
            case LodingShowTypeLeftImage:
                [self drawAnimiationImageView:YES];
                break ;
            default:
                break;
        }
    }
    return self ;
}

//加载loding的动画
- (void)drawAnimationImageViewLoding
{
    CGPoint centerPoint= CGPointMake(self.imageView.width/2.0f, self.imageView.height/2.0f) ;
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithArcCenter:centerPoint radius:centerPoint.x startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer *centerLayer=[CAShapeLayer layer];
    centerLayer.path=beizPath.CGPath;
    centerLayer.fillColor=[UIColor clearColor].CGColor;//填充色
    centerLayer.strokeColor=self.options.textColor.CGColor;//边框颜色
    centerLayer.lineWidth=2.0f;
    centerLayer.lineCap=kCALineCapRound;//线框类型
    
    [self.imageView.layer addSublayer:centerLayer];
    
    [self drawAnimiationImageView:NO];
}

// 转圈动画
- (void)drawAnimiationImageView:(BOOL)isImageView
{
    NSString *keyPath = isImageView ? @"transform.rotation.y" : @"transform.rotation.z" ;
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue=@(0);
    animation.toValue=@(M_PI*2);
    animation.duration=isImageView ? 1.3 : .8;
    animation.repeatCount=HUGE;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.imageView.layer addAnimation:animation forKey:@"animation"];
}

- (void)showEndAnimationWithDuration:(CGFloat)duration
{
    CABasicAnimation *bacAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    bacAnimation.duration = duration ;
    bacAnimation.beginTime = .0;
    bacAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.3f :0.5f :-0.5f];
    bacAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    bacAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[bacAnimation];
    animationGroup.duration =  bacAnimation.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animationGroup forKey:nil];
}

- (void)showStartAnimationWithDuration:(CGFloat)duration
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = duration;
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

#pragma mark - getter

- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        CGFloat imageWH = EasyDrawImageWH ;
        CGFloat imageX = (self.width-EasyDrawImageWH)/2 ;
        CGFloat imageY = EasyDrawImageEdge/2 ;
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX,imageY , imageWH, imageWH)];
        //_imageView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_imageView];
    }
    return _imageView ;
}
- (UILabel *)textLabel
{
    if (nil == _textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = self.options.textColor;
        _textLabel.font = self.options.textFount ;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter ;
        _textLabel.numberOfLines = 0 ;
        [self addSubview:_textLabel];
    }
    return _textLabel ;
}

- (UIActivityIndicatorView *)imageViewIndeicator
{
    if (nil == _imageViewIndeicator) {
        _imageViewIndeicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _imageViewIndeicator.tintColor = self.options.textColor ;
        _imageViewIndeicator.color = self.options.textColor ;
        //_imageViewIndeicator.backgroundColor = [UIColor yellowColor];
        _imageViewIndeicator.frame = self.imageView.bounds ;
        [self.imageView addSubview:_imageViewIndeicator];
    }
    return _imageViewIndeicator ;
}

@end

@interface EasyShowLodingView()

@property (nonatomic,strong)EasyShowLodingBgView *showBgView ;//用于放图片和文字的背景
@property (nonatomic,strong)EasyShowOptions *options ;

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)UIImage *showImage ;//展示的图片

@end


@implementation EasyShowLodingView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =  [[UIColor lightGrayColor] colorWithAlphaComponent:0.02]; // [UIColor greenColor] ;//
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
    //展示视图的frame
    CGRect showFrame = [self showRectWithSpuerView:superView] ;
    
    if (self.options.superViewReceiveEvent) {//父视图能接受事件
        //self的大小为显示区域的大小
        [self setFrame:CGRectMake((SCREEN_WIDTH-showFrame.size.width)/2, showFrame.origin.y, showFrame.size.width, showFrame.size.height)];
        //显示视图的bgview的frame的位置为{0，0}
        showFrame.origin.y = 0 ;
    }
    else{
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        [self setFrame: CGRectMake(0, 0, superView.width, superView.height)] ;
    }
    
    
    self.showBgView = [[EasyShowLodingBgView alloc]initWithFrame:showFrame
                                                            text:self.showText
                                                           image:self.showImage];
    [self addSubview:self.showBgView];
    
    
    [self showSelfToSuperView:superView];
    
}

- (void)showSelfToSuperView:(UIView *)superView
{
    if (self.options.showStartAnimation) {
        
        [self.showBgView showStartAnimationWithDuration:self.options.showAnimationTime];
        
        [superView addSubview:self];
        
    }
    else{
        
        self.alpha = 0.1 ;
        [UIView animateWithDuration:self.options.showAnimationTime animations:^{
            self.alpha = 1.0 ;
        } completion:^(BOOL finished) {
            [superView addSubview:self];
        }];
    }
}
- (void)removeSelfFromSuperView
{
    
    if (self.options.showEndAnimation) {
        
        [self.showBgView showEndAnimationWithDuration:self.options.showAnimationTime];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.options.showAnimationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }
    else{
        
        [UIView animateWithDuration:self.options.showAnimationTime animations:^{
            self.alpha = 0.1 ;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }] ;
    }
}


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
    
    if (self.options.lodingShowType > LodingShowTypeImage) {//左右形式
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
- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
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
