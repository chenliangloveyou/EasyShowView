//
//  EasyShowBgView.m
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//

#import "EasyShowBgView.h"

#import "UIView+EasyShowExt.h"
#import "EasyShowUtils.h"

@interface EasyShowBgView()

@property ShowStatus showStatus ;
@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *imageView ;

@property (nonatomic,strong)UIActivityIndicatorView *imageViewIndeicator ;

@property (nonatomic,strong)EasyShowOptions *options ;

@end

@implementation EasyShowBgView
- (UIActivityIndicatorView *)imageViewIndeicator
{
    if (nil == _imageViewIndeicator) {
        _imageViewIndeicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _imageViewIndeicator.tintColor = self.options.textColor ;
        _imageViewIndeicator.color = self.options.textColor ;
//        _imageViewIndeicator.backgroundColor = [UIColor yellowColor];
        _imageViewIndeicator.frame = self.imageView.bounds ;
        [self.imageView addSubview:_imageViewIndeicator];
    }
    return _imageViewIndeicator ;
}
- (instancetype)initWithFrame:(CGRect)frame status:(ShowStatus)status text:(NSString *)text image:(UIImage *)image
{
    if ([super initWithFrame:frame]) {
       
        self.backgroundColor = self.options.backGroundColor ;
        [self setRoundedCorners];
        
        _showStatus = status ;
        
        if (!ISEMPTY(text)) {
            CGSize textSize = [EasyShowUtils textWidthWithStirng:text
                                                            font:self.options.textFount
                                                        maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
            
            self.textLabel.text = text ;
            self.textLabel.frame = CGRectMake(20,self.height-textSize.height-15 ,textSize.width, textSize.height) ;
            
            if (status != ShowStatusText) {//只要不是纯文字，其他的都需要显示图片
                self.imageView.top  = KDrawImageEdgeH ;
            }
            
            if (self.showStatus==ShowStatusLoding && self.options.showLodingType > ShowLodingTypeImage) {//左右的形式
                self.textLabel.frame = CGRectMake(kDrawImageWH + 20,self.height-textSize.height-15 ,textSize.width, textSize.height) ;
            }
        }
        if (self.showStatus==ShowStatusLoding && self.options.showLodingType > ShowLodingTypeImage) {//左右的形式
            self.imageView.frame = CGRectMake(KDrawImageEdgeH/2, KDrawImageEdgeH/2, kDrawImageWH, kDrawImageWH);
        }
        if (image) {
            self.imageView.image = image ;
        }
        
        if (status == ShowStatusLoding){
            
            switch (self.options.showLodingType) {
                case ShowLodingTypeDefault:
                case ShowLodingTypeLeftDefault:
                    [self drawAnimationImageViewLoding];
                    break;
                case ShowLodingTypeIndicator:
                case ShowLodingTypeLeftIndicator:
                    [self.imageViewIndeicator startAnimating];
                    break ;
                case ShowLodingTypeImage:
                case ShowLodingTypeLeftImage:
                    [self drawAnimiationImageView:YES];
                    break ;
                default:
                    break;
            }
           
        }
        else
        [self drawAnimationImageView];
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

- (void)drawAnimationImageView
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kDrawImageWH, kDrawImageWH)
                                                    cornerRadius:kDrawImageWH/2];
    UIColor *drawColor = nil ;
    switch (_showStatus) {
        case ShowStatusText:
            return ;
        case ShowStatusSuccess:
        {
            [path moveToPoint:CGPointMake((self.imageView.width-kDrawImageWH)/2+kDrawImageWH/4,  3 + kDrawImageWH/2)];
            [path addLineToPoint:CGPointMake(self.imageView.width/2, kDrawImageWH*3/4)];
            [path addLineToPoint:CGPointMake(self.imageView.width/2 + kDrawImageWH*1/3, kDrawImageWH*1/3)];
            
            drawColor = [UIColor greenColor] ;
        } break;
        case ShowStatusError:
        {
            [path moveToPoint:CGPointMake(self.imageView.width/2-kDrawImageWH/4, kDrawImageWH/4)];
            [path addLineToPoint:CGPointMake(self.imageView.width/2+kDrawImageWH/4, kDrawImageWH*3/4)];
            
            [path moveToPoint:CGPointMake(self.imageView.width/2+kDrawImageWH/4, kDrawImageWH/4)];
            [path addLineToPoint:CGPointMake(self.imageView.width/2-kDrawImageWH/4, kDrawImageWH*3/4)];
            
            drawColor = [UIColor redColor] ;
        }break ;
        case ShowStatusInfo:
        {
            [path moveToPoint:CGPointMake(self.imageView.width/2,  kDrawImageWH/4 )];
            [path addLineToPoint:CGPointMake(self.imageView.width/2,kDrawImageWH/4 + 3)];
            
            [path moveToPoint:CGPointMake(self.imageView.width/2,kDrawImageWH/4 + 6)];
            [path addLineToPoint:CGPointMake(self.imageView.width/2, kDrawImageWH*3/4 )];
            
            drawColor = [UIColor lightGrayColor] ;
        }break ;
        default:
            break;
    }
    
    CAShapeLayer *lineLayer = [ CAShapeLayer layer];
    lineLayer.frame = CGRectZero;
    lineLayer.fillColor = [ UIColor clearColor ].CGColor ;
    lineLayer.path = path. CGPath ;
    lineLayer.strokeColor = self.options.textColor.CGColor ;
    lineLayer.lineWidth = 2;
    lineLayer.cornerRadius = 50;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    ani.fromValue = @0 ;
    ani.toValue = @1 ;
    ani.duration = 0.4 ;
    [lineLayer addAnimation :ani forKey :@"strokeEnd"];
    
    [self.imageView.layer addSublayer :lineLayer];
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width-kDrawImageWH)/2, KDrawImageEdgeH/2, kDrawImageWH, kDrawImageWH)];
//        _imageView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageView] ;
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
- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
