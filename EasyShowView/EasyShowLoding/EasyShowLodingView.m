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
#import "EasyShowLodingGlobalConfig.h"

@interface EasyShowLodingView()<CAAnimationDelegate>

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)NSString *showImageName ;//展示的图片
@property (nonatomic,strong)EasyShowLodingConfig *showConfig ;//展示的配置信息


@property (nonatomic,strong)UIView *lodingBgView ;//上面放着 textlabel 和 imageview
@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *imageView ;

@property (nonatomic,strong)UIActivityIndicatorView *imageViewIndeicator ;


@end


@implementation EasyShowLodingView


- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame showText:(NSString *)showText iamgeName:(NSString *)imageName config:(EasyShowLodingConfig *)config
{
    if (self = [super initWithFrame:frame]) {
        self.showText = showText ;
        self.showImageName = imageName ;
        self.showConfig = config ;
        [self bluidUI];
    }
    return self ;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =  [UIColor clearColor]; // [UIColor greenColor] ;//
    }
    return self ;
}

- (void)bluidUI
{
    //展示视图的frame
    
    CGSize imageSize = CGSizeZero ;
    switch (self.showConfig.lodingShowType) {
        case LodingShowTypeTurnAround:
        case LodingShowTypeTurnAroundLeft:
        case LodingShowTypeIndicator:
        case LodingShowTypeIndicatorLeft:
            imageSize = CGSizeMake(EasyShowLodingImageWH, EasyShowLodingImageWH);
            break;
        case LodingShowTypePlayImages:
        case LodingShowTypePlayImagesLeft:
        {
            NSAssert(self.showConfig.lodingPlayImagesArray, @"you should set a image array!") ;
            UIImage *image = self.showConfig.lodingPlayImagesArray.firstObject ;
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
    
    CGFloat textMaxWidth = EasyShowLodingMaxWidth - (self.showConfig.lodingShowType%2?:(EasyShowLodingImageWH+EasyShowLodingImageEdge*2)) ;//当为左右形式的时候减去图片的宽度
    CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(textMaxWidth, MAXFLOAT)];
    if (ISEMPTY_S(self.showText)) {
        textSize = CGSizeZero ;
    }
    
    //显示区域的宽高
    CGSize displayAreaSize = CGSizeZero ;
    if (self.showConfig.lodingShowType%2) {
        //左右形式
        displayAreaSize.width = imageSize.width + EasyShowLodingImageEdge*2 + textSize.width ;
        displayAreaSize.height = MAX(imageSize.height+ EasyShowLodingImageEdge*2, textSize.height) ;
    }
    else{
        //上下形式
        displayAreaSize.width = MAX(imageSize.width+2*EasyShowLodingImageEdge, textSize.width);
        displayAreaSize.height = imageSize.height+2*EasyShowLodingImageEdge + textSize.height ;
    }
    
    
    if (self.showConfig.lodingSuperViewReceiveEvent) {
        //父视图能够接受事件 。 显示区域的大小=self的大小=displayAreaSize
        
        [self setFrame:CGRectMake((self.showConfig.superView.width-displayAreaSize.width)/2, (self.showConfig.superView.height-displayAreaSize.height)/2, displayAreaSize.width, displayAreaSize.height)];
    }
    else{
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        
        [self setFrame: CGRectMake(0, 0, self.showConfig.superView.width, self.showConfig.superView.height)] ;
        
        self.lodingBgView.center = self.center ;
        
    }
    
    self.lodingBgView.frame = CGRectMake(0,0, displayAreaSize.width,displayAreaSize.height) ;
    if (!self.showConfig.lodingSuperViewReceiveEvent) {
        self.lodingBgView.center = self.center ;
    }
    
    self.imageView.frame = CGRectMake(EasyShowLodingImageEdge, EasyShowLodingImageEdge, imageSize.width, imageSize.height) ;
    if (!(self.showConfig.lodingShowType%2)) {
        self.imageView.centerX = self.lodingBgView.width/2 ;
    }
    
    CGFloat textLabelX = 0 ;
    CGFloat textLabelY = 0 ;
    if (self.showConfig.lodingShowType%2) {//左右形式
        textLabelX = self.imageView.right  ;
        textLabelY =  (self.lodingBgView.height-textSize.height)/2 ;
    }
    else{
        textLabelX = 0 ;
        textLabelY = self.imageView.bottom + EasyShowLodingImageEdge ;
    }
    self.textLabel.frame = CGRectMake(textLabelX, textLabelY, textSize.width, textSize.height );
    
//    [superView addSubview:self];
    if (self.showConfig.lodingCycleCornerWidth > 0) {
        [_lodingBgView setRoundedCorners:self.showConfig.lodingCycleCornerWidth];
    }
    
    switch (self.showConfig.lodingShowType) {
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
            UIImage *tempImage  = self.showConfig.lodingPlayImagesArray.firstObject ;
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
        switch (self.showConfig.lodingShowType) {
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
                for (int i = 0 ; i < self.showConfig.lodingPlayImagesArray.count; i++) {
                    UIImage *img = self.showConfig.lodingPlayImagesArray[i] ;
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
    
    
    switch (self.showConfig.lodingAnimationType) {
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
    
    shapeLayer.strokeColor = self.showConfig.lodingTintColor.CGColor;
    shapeLayer.lineWidth=2.0f;
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(.0f, .5f);
    gradientLayer.endPoint = CGPointMake(1.f, .5f);
    gradientLayer.frame = shapeLayer.frame ;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:6];
    for(int i=10;i>=0;i-=2) {
        [tempArray addObject:(__bridge id)[self.showConfig.lodingTintColor colorWithAlphaComponent:i*.1f].CGColor];
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
    switch (self.showConfig.lodingAnimationType) {
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
    centerLayer.strokeColor=self.showConfig.lodingTintColor.CGColor;//边框颜色
    centerLayer.lineWidth=2.0f;
    centerLayer.lineCap=kCALineCapRound;//线框类型
    
    [self.imageView.layer addSublayer:centerLayer];
    
}


#pragma mark - getter

- (UIView *)lodingBgView
{
    if (nil == _lodingBgView) {
        _lodingBgView = [[UIView alloc]init] ;
        _lodingBgView.backgroundColor = self.showConfig.lodingBackgroundColor ;
        [self addSubview:_lodingBgView];
    }
    return _lodingBgView ;
}
- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.tintColor = self.showConfig.lodingTintColor ;
        [self.lodingBgView addSubview:_imageView];
    }
    return _imageView ;
}
- (UILabel *)textLabel
{
    if (nil == _textLabel) {
        _textLabel = [[EasyShowLabel alloc]initWithContentInset:UIEdgeInsetsMake(10, 20, 10, 20)];
        _textLabel.textColor = self.showConfig.lodingTintColor;
        _textLabel.font = self.showConfig.lodingTextFount ;
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
        UIActivityIndicatorViewStyle style = self.showConfig.lodingShowType%2 ? UIActivityIndicatorViewStyleWhite : UIActivityIndicatorViewStyleWhiteLarge ;
        _imageViewIndeicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
        _imageViewIndeicator.tintColor = self.showConfig.lodingTintColor ;
        _imageViewIndeicator.color = self.showConfig.lodingTintColor ;
        _imageViewIndeicator.backgroundColor = [UIColor clearColor];
        _imageViewIndeicator.frame = self.imageView.bounds ;
    }
    return _imageViewIndeicator ;
}

#pragma mark - 工具方法
+ (UIView *)showLodingEmptyView
{
    UIView *showView = [UIApplication sharedApplication].keyWindow ;
    if ([EasyShowLodingGlobalConfig isUseLoeingGlobalConfig]) {
        if (![EasyShowLodingGlobalConfig sharedEasyShowLodingGlobalConfig].lodingShowOnWindow) {
            showView = [EasyShowUtils easyShowViewTopViewController].view ;
        }
    }
    else{
        if (![EasyShowOptions sharedEasyShowOptions].lodingShowOnWindow) {
            showView = [EasyShowUtils easyShowViewTopViewController].view ;
        }
    }
    return showView ;
}

#pragma mark - 类方法


+ (void)hidenLoding
{
    UIView *showView = [EasyShowUtils easyShowViewTopViewController].view ;
#warning 还需要处理
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



+ (void)showLoding
{
    [self showLodingText:@""];
}
+ (void)showLodingText:(NSString *)text
{
    [self showLodingText:text imageName:nil];
}
+ (void)showLodingText:(NSString *)text imageName:(NSString *)imageName
{
    __block EasyShowLodingConfig *config = [[EasyShowLodingConfig alloc]init];
    config.superView = [self showLodingEmptyView] ;
    EasyShowLodingConfig *(^configTemp)(void) = ^EasyShowLodingConfig *{
        return config ;
    };
    [self showLodingText:text imageName:imageName config:configTemp];
    
}
+ (void)showLodingText:(NSString *)text
                config:(EasyShowLodingConfig *(^)(void))config
{
    [self showLodingText:text imageName:nil config:config];
}
+ (void)showLodingText:(NSString *)text
             imageName:(NSString *)imageName
                config:(EasyShowLodingConfig *(^)(void))config
{
    NSAssert(config, @"there shoud have a superview!") ;
    
    if (nil == config) {
        EasyShowLodingConfig *(^configTemp)(void) = ^EasyShowLodingConfig *{
            return  [[EasyShowLodingConfig alloc]init];
        };
        config = configTemp ;
    }
    
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    EasyShowLodingConfig *tempConfig = [self changeConfigWithConfig:config] ;
    
    //显示之前---->隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [tempConfig.superView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowLodingView *showView = (EasyShowLodingView *)subview ;
            [showView removeSelfFromSuperView];
        }
    }
    
    if (!tempConfig.superView) {
        tempConfig.superView = [self showLodingEmptyView] ;
    }
    EasyShowLodingView *lodingView = [[EasyShowLodingView alloc]initWithFrame:CGRectZero
                                                                     showText:text
                                                                    iamgeName:imageName
                                                                       config:tempConfig];
    [tempConfig.superView addSubview:lodingView];
    
//    [self easyShowLodingViewWithText:text
//                           imageName:imageName
//                              config:config?config():nil];
}

+ (EasyShowLodingConfig *)changeConfigWithConfig:(EasyShowLodingConfig *(^)(void))config
{
    EasyShowLodingConfig *tempConfig = config ? config() : [[EasyShowLodingConfig alloc]init] ;
    
    EasyShowOptions *options = [EasyShowOptions sharedEasyShowOptions];
    
    BOOL isUseGlobalConfig = [EasyShowLodingGlobalConfig isUseLoeingGlobalConfig];
    EasyShowLodingGlobalConfig *globalConfig = nil ;
    if (isUseGlobalConfig) {
        globalConfig = [EasyShowLodingGlobalConfig sharedEasyShowLodingGlobalConfig];
    }
    
    if (tempConfig.lodingShowType == EasyUndefine) {
        tempConfig.lodingShowType = isUseGlobalConfig ? globalConfig.lodingShowType : options.lodingShowType ;
    }
    if (tempConfig.lodingAnimationType == EasyUndefine) {
        tempConfig.lodingAnimationType = isUseGlobalConfig ? globalConfig.lodingAnimationType : options.lodingAnimationType ;
    }
    if (tempConfig.lodingSuperViewReceiveEvent == EasyUndefine ) {
        tempConfig.lodingSuperViewReceiveEvent =  isUseGlobalConfig ? globalConfig.lodingSuperViewReceiveEvent : options.lodingSuperViewReceiveEvent ;
    }
#warning 这里几处都需要处理
    if (!tempConfig.lodingShowOnWindow) {
        tempConfig.lodingShowOnWindow =  isUseGlobalConfig ? globalConfig.lodingShowOnWindow : options.lodingShowOnWindow ;
    }
    if (!tempConfig.lodingCycleCornerWidth) {
        tempConfig.lodingCycleCornerWidth = isUseGlobalConfig ? globalConfig.lodingCycleCornerWidth : options.lodingCycleCornerWidth ;
    }
    if (!tempConfig.lodingTintColor) {
        tempConfig.lodingTintColor =  isUseGlobalConfig ? globalConfig.lodingTintColor : options.lodingTintColor ;
    }
    if (!tempConfig.lodingTextFount) {
        tempConfig.lodingTextFount =  isUseGlobalConfig ? globalConfig.lodingTextFount : options.lodingTextFount ;
    }
    if (!tempConfig.lodingBackgroundColor) {
        tempConfig.lodingBackgroundColor =  isUseGlobalConfig ? globalConfig.lodingBackgroundColor : options.lodingBackgroundColor ;
    }
    if (!tempConfig.lodingPlayImagesArray) {
        tempConfig.lodingPlayImagesArray =  isUseGlobalConfig ? globalConfig.lodingPlayImagesArray : options.lodingPlayImagesArray ;
    }
    return tempConfig ;
}


+ (void)showLodingText:(NSString *)text inView:(UIView *)superView
{
    __block EasyShowLodingConfig *config = [[EasyShowLodingConfig alloc]init];
    config.superView = superView ;
    EasyShowLodingConfig *(^configTemp)(void) = ^EasyShowLodingConfig *{
        return config ;
    };
    [self showLodingText:text config:configTemp];
}
+ (void)showLodingText:(NSString *)text imageName:(NSString *)imageName inView:(UIView *)superView
{
    __block EasyShowLodingConfig *config = [[EasyShowLodingConfig alloc]init];
    config.superView = superView ;
    EasyShowLodingConfig *(^configTemp)(void) = ^EasyShowLodingConfig *{
        return config ;
    };
    [self showLodingText:text imageName:imageName config:configTemp];
}
@end

