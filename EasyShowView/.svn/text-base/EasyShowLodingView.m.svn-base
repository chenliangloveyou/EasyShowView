//
//  EasyShowLodingView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowLodingView.h"
#import "UIView+EasyShowExt.h"
#import "EasyShowTextBgView.h"
#import "EasyShowLabel.h"


@interface EasyShowLodingView()<CAAnimationDelegate>

@property (nonatomic,strong)EasyShowOptions *options ;

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)NSString *showImageName ;//展示的图片

@property (nonatomic,strong)UIView *lodingBgView ;//上面放着 textlabel 和 imageview
@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *imageView ;

@property (nonatomic,strong)UIActivityIndicatorView *imageViewIndeicator ;


@end


@implementation EasyShowLodingView


- (void)dealloc
{
}


+ (void)showLoding
{
    [self showLodingText:@""];
}
+ (void)showLodingText:(NSString *)text
{
    UIView *showView = [EasyShowUtils topViewController].view ;
    if ([EasyShowOptions sharedEasyShowOptions].lodingShowOnWindow) {
        showView = [UIApplication sharedApplication].keyWindow ;
    }
    [self showLodingText:text inView:showView];
}
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView
{
    [self showLodingText:text imageName:nil inView:superView];
}
+ (void)showLodingText:(NSString *)text imageName:(NSString *)imageName
{
    UIView *showView = [EasyShowUtils topViewController].view ;
    if ([EasyShowOptions sharedEasyShowOptions].lodingShowOnWindow) {
        showView = [UIApplication sharedApplication].keyWindow ;
    }
    [self showLodingText:text imageName:imageName inView:showView];
}
+ (void)showLodingText:(NSString *)text imageName:(NSString *)imageName inView:(UIView *)superView
{
    [self showLodingWithText:text inView:superView imageName:imageName];
}
+ (void)showLodingWithText:(NSString *)text
                    inView:(UIView *)view
                 imageName:(NSString *)imageName
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
            EasyShowLodingView *showView = (EasyShowLodingView *)subview ;
            [showView removeSelfFromSuperView];
        }
    }
    
    EasyShowLodingView *showView = [[EasyShowLodingView alloc] initWithFrame:CGRectZero];
    showView.showText = text ;
    showView.showImageName = imageName ;
    [showView showViewWithSuperView:view];
   
}



+ (void)hidenLoding
{
    UIView *showView = [EasyShowUtils topViewController].view ;
    if ([EasyShowOptions sharedEasyShowOptions].lodingShowOnWindow) {
        showView = [UIApplication sharedApplication].keyWindow ;
    }
    [self hidenLoingInView:showView];
}
+ (void)hidenLoingInView:(UIView *)superView
{
    NSEnumerator *subviewsEnum = [superView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowLodingView *showView = (EasyShowLodingView *)subview ;

            [showView removeSelfFromSuperView];
        }
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =  [UIColor clearColor]; // [UIColor greenColor] ;//
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
    //展示视图的frame
    
    CGSize imageSize = CGSizeZero ;
    switch (self.options.lodingShowType) {
        case LodingShowTypeTurnAround:
        case LodingShowTypeTurnAroundLeft:
        case LodingShowTypeIndicator:
        case LodingShowTypeIndicatorLeft:
            imageSize = CGSizeMake(EasyShowLodingImageWH, EasyShowLodingImageWH);
            break;
        case LodingShowTypePlayImages:
        case LodingShowTypePlayImagesLeft:
        {
            NSAssert(self.options.lodingPlayImagesArray, @"you should set a image array!") ;
            UIImage *image = self.options.lodingPlayImagesArray.firstObject ;
            CGSize tempSize = image.size ;
            if (tempSize.height > EasyShowLodingImageMaxWH) {
                tempSize.height = EasyShowLodingImageMaxWH ;
            }
            if (tempSize.width > EasyShowLodingImageMaxWH) {
                tempSize.width = EasyShowLodingImageMaxWH ;
            }
            imageSize = tempSize ;
        }break ;
        case LodingShowTypeImageUpturn:
        case LodingShowTypeImageUpturnLeft:
        case LodingShowTypeImageAround:
        case LodingShowTypeImageAroundLeft:
        {
            UIImage *image = [[UIImage imageNamed:self.showImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            CGSize tempSize = image.size ;
            if (tempSize.height > EasyShowLodingImageMaxWH) {
                tempSize.height = EasyShowLodingImageMaxWH ;
            }
            if (tempSize.width > EasyShowLodingImageMaxWH) {
                tempSize.width = EasyShowLodingImageMaxWH ;
            }
            imageSize = tempSize ;
        }break ;
        default:
            break;
    }

    
    if (!ISEMPTY_S(self.showText)) {
        self.textLabel.text = self.showText ;
    }
    
    CGFloat textMaxWidth = EasyShowLodingMaxWidth - (self.options.lodingShowType%2?:(EasyShowLodingImageWH+EasyShowLodingImageEdge*2)) ;//当为左右形式的时候减去图片的宽度
    CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(textMaxWidth, MAXFLOAT)];
    if (ISEMPTY_S(self.showText)) {
        textSize = CGSizeZero ;
    }
   
    //显示区域的宽高
    CGSize displayAreaSize = CGSizeZero ;
    if (self.options.lodingShowType%2) {
        //左右形式
        displayAreaSize.width = imageSize.width + EasyShowLodingImageEdge*2 + textSize.width ;
        displayAreaSize.height = MAX(imageSize.height+ EasyShowLodingImageEdge*2, textSize.height) ;
    }
    else{
        //上下形式
        displayAreaSize.width = MAX(imageSize.width+2*EasyShowLodingImageEdge, textSize.width);
        displayAreaSize.height = imageSize.height+2*EasyShowLodingImageEdge + textSize.height ;
    }

    
    if (self.options.lodingSuperViewReceiveEvent) {
        //父视图能够接受事件 。 显示区域的大小=self的大小=displayAreaSize

        [self setFrame:CGRectMake((SCREEN_WIDTH_S-displayAreaSize.width)/2, (SCREEN_HEIGHT_S-displayAreaSize.height)/2, displayAreaSize.width, displayAreaSize.height)];
    }
    else{
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        
        [self setFrame: CGRectMake(0, 0, superView.width, superView.height)] ;
      
        self.lodingBgView.center = self.center ;

    }
    
    self.lodingBgView.frame = CGRectMake(0,0, displayAreaSize.width,displayAreaSize.height) ;
    if (!self.options.lodingSuperViewReceiveEvent) {
        self.lodingBgView.center = self.center ;
    }
    
    self.imageView.frame = CGRectMake(EasyShowLodingImageEdge, EasyShowLodingImageEdge, imageSize.width, imageSize.height) ;
    if (!(self.options.lodingShowType%2)) {
        self.imageView.centerX = self.lodingBgView.width/2 ;
    }
   
    CGFloat textLabelX = 0 ;
    CGFloat textLabelY = 0 ;
    if (self.options.lodingShowType%2) {//左右形式
        textLabelX = self.imageView.right  ;
        textLabelY =  (self.lodingBgView.height-textSize.height)/2 ;
    }
    else{
        textLabelX = 0 ;
        textLabelY = self.imageView.bottom + EasyShowLodingImageEdge ;
    }
    self.textLabel.frame = CGRectMake(textLabelX, textLabelY, textSize.width, textSize.height );
    
    [superView addSubview:self];
    if (self.options.lodingCycleCornerWidth > 0) {
        [_lodingBgView setRoundedCorners:self.options.lodingCycleCornerWidth];
    }
    
    switch (self.options.lodingShowType) {
        case LodingShowTypeTurnAround:
        case LodingShowTypeTurnAroundLeft:
            [self drawAnimationImageViewLoding];
            break;
        case LodingShowTypeIndicator:
        case LodingShowTypeIndicatorLeft:
            [self.imageView addSubview:self.imageViewIndeicator];
            break ;
        case LodingShowTypePlayImages:
        case LodingShowTypePlayImagesLeft:
        {
            UIImage *tempImage  = self.options.lodingPlayImagesArray.firstObject ;
            if (tempImage) {
                self.imageView.image = tempImage ;
            }
        }
            break ;
        case LodingShowTypeImageUpturn:
        case LodingShowTypeImageUpturnLeft:
            
        case LodingShowTypeImageAround:
        case LodingShowTypeImageAroundLeft:
        {
            UIImage *image = [[UIImage imageNamed:self.showImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            if (image) {
                self.imageView.image = image ;
            }
            else{
                NSAssert(NO, @"iamgeName is illgal ");
            }
        } break ;
        default:
            break;
    }
    
    
    void (^completion)(void) = ^{
        switch (self.options.lodingShowType) {
            case LodingShowTypeTurnAround:
            case LodingShowTypeTurnAroundLeft:
                [self drawAnimiationImageView:NO];
                break;
            case LodingShowTypeIndicator:
            case LodingShowTypeIndicatorLeft:
                [self.imageViewIndeicator startAnimating];
                break ;
            case LodingShowTypePlayImages:
            case LodingShowTypePlayImagesLeft:
            {
                NSMutableArray *tempArray= [NSMutableArray arrayWithCapacity:20];
                for (int i = 0 ; i < self.options.lodingPlayImagesArray.count; i++) {
                    UIImage *img = self.options.lodingPlayImagesArray[i] ;
                    if ([img isKindOfClass:[UIImage class]]) {
                        [tempArray addObject:img];
                    }
                }
                self.imageView.animationImages = tempArray ;
                self.imageView.animationDuration = EasyShowAnimationTime ;
//                self.imageView.animationRepeatCount = NSIntegerMax ;
                [self.imageView startAnimating];
                
            }break ;
            case LodingShowTypeImageUpturn:
            case LodingShowTypeImageUpturnLeft:
                [self drawAnimiationImageView:YES];
                break ;
            case LodingShowTypeImageAround:
            case LodingShowTypeImageAroundLeft:
                [self drawGradientaLayerAmination];
                break ;
            default:
                break;
        }
    };
   
    
    switch (self.options.lodingAnimationType) {
        case lodingAnimationTypeNone:
            completion() ;
            break;
        case lodingAnimationTypeBounce:
            [self showBounceAnimationStart:YES completion:completion];
            break ;
        case lodingAnimationTypeFade:
            [self showFadeAnimationStart:YES completion:completion ] ;
            break ;
        default:
            break;
    }
    
}

- (void)drawGradientaLayerAmination
{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    
    CGFloat layerRadius = self.imageView.width/2*1.0f ;
    shapeLayer.frame = CGRectMake(.0f, .0f,  layerRadius*2.f+3,  layerRadius*2.f+3) ;
    
    CGFloat cp = layerRadius+3/2.f;
    UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(cp, cp) radius:layerRadius startAngle:.0f endAngle:.75f*M_PI clockwise:YES];
    shapeLayer.path = p.CGPath;
    
    shapeLayer.strokeColor = self.options.lodingTintColor.CGColor;
    shapeLayer.lineWidth=2.0f;

    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(.0f, .5f);
    gradientLayer.endPoint = CGPointMake(1.f, .5f);
    gradientLayer.frame = shapeLayer.frame ;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:6];
    for(int i=10;i>=0;i-=2) {
        [tempArray addObject:(__bridge id)[self.options.lodingTintColor colorWithAlphaComponent:i*.1f].CGColor];
    }
    gradientLayer.colors = tempArray;
    gradientLayer.mask = shapeLayer;
    [self.imageView.layer addSublayer:gradientLayer];

    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue = @(2.f*M_PI);
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

    [gradientLayer addAnimation:animation forKey:@"GradientLayerAnimation"];
}
- (void)removeSelfFromSuperView
{
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    
    void (^completion)(void) = ^{
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    };
    switch (self.options.lodingAnimationType) {
        case lodingAnimationTypeNone:
            completion() ;
            break;
        case lodingAnimationTypeBounce:
            [self showBounceAnimationStart:NO completion:completion];
            break ;
        case lodingAnimationTypeFade:
            [self showFadeAnimationStart:NO completion:completion ] ;
            break ;
        default:
            break;
    }
}


#pragma mark - animation
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


- (void)showFadeAnimationStart:(BOOL)isStart completion:(void(^)(void))completion
{
    self.alpha = isStart ? 0.1f : 1.0f;
    [UIView animateWithDuration:EasyShowAnimationTime animations:^{
        self.alpha = isStart ? 1.0 : 0.1f ;
    } completion:^(BOOL finished) {
        if (completion) {
            completion() ;
        }
    }];
}
- (void)showBounceAnimationStart:(BOOL)isStart completion:(void(^)(void))completion
{
    if (isStart) {
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration = EasyShowAnimationTime ;
        popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
                                [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
        popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        popAnimation.delegate = self ;
        [popAnimation setValue:completion forKey:@"handler"];
        [self.lodingBgView.layer addAnimation:popAnimation forKey:nil];
        return ;
    }
    CABasicAnimation *bacAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    bacAnimation.duration = EasyShowAnimationTime ;
    bacAnimation.beginTime = .0;
    bacAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.3f :0.5f :-0.5f];
    bacAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    bacAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[bacAnimation];
    animationGroup.duration =  bacAnimation.duration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;

//    animationGroup.delegate = self ;
//    [animationGroup setValue:completion forKey:@"handler"];
    [self.lodingBgView.layer addAnimation:animationGroup forKey:nil];
   
    [self performSelector:@selector(ddd) withObject:nil afterDelay:bacAnimation.duration];
}
- (void)ddd
{
    [self removeFromSuperview];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}
//加载loding的动画
- (void)drawAnimationImageViewLoding
{
    CGPoint centerPoint= CGPointMake(self.imageView.width/2.0f, self.imageView.height/2.0f) ;
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithArcCenter:centerPoint radius:centerPoint.x startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer *centerLayer=[CAShapeLayer layer];
    centerLayer.path=beizPath.CGPath;
    centerLayer.fillColor=[UIColor clearColor].CGColor;//填充色
    centerLayer.strokeColor=self.options.lodingTintColor.CGColor;//边框颜色
    centerLayer.lineWidth=2.0f;
    centerLayer.lineCap=kCALineCapRound;//线框类型
    
    [self.imageView.layer addSublayer:centerLayer];
    
}


#pragma mark - getter

- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
}
- (UIView *)lodingBgView
{
    if (nil == _lodingBgView) {
        _lodingBgView = [[UIView alloc]init] ;
        _lodingBgView.backgroundColor = self.options.lodingBackgroundColor ;
        [self addSubview:_lodingBgView];
    }
    return _lodingBgView ;
}
- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.tintColor = self.options.lodingTintColor ;
        [self.lodingBgView addSubview:_imageView];
    }
    return _imageView ;
}
- (UILabel *)textLabel
{
    if (nil == _textLabel) {
        _textLabel = [[EasyShowLabel alloc]initWithContentInset:UIEdgeInsetsMake(10, 20, 10, 20)];
        _textLabel.textColor = self.options.lodingTintColor;
        _textLabel.font = self.options.lodingTextFount ;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter ;
        _textLabel.numberOfLines = 0 ;
        [self.lodingBgView addSubview:_textLabel];
    }
    return _textLabel ;
}

- (UIActivityIndicatorView *)imageViewIndeicator
{
    if (nil == _imageViewIndeicator) {
        UIActivityIndicatorViewStyle style = self.options.lodingShowType%2 ? UIActivityIndicatorViewStyleWhite : UIActivityIndicatorViewStyleWhiteLarge ;
        _imageViewIndeicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        _imageViewIndeicator.tintColor = self.options.lodingTintColor ;
        _imageViewIndeicator.color = self.options.lodingTintColor ;
        _imageViewIndeicator.backgroundColor = [UIColor clearColor];
        _imageViewIndeicator.frame = self.imageView.bounds ;
    }
    return _imageViewIndeicator ;
}




@end
