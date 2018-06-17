//
//  EasyTextBgView.m
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//

#import "EasyTextBgView.h"

#import "UIView+EasyShowExt.h"
#import "EasyShowUtils.h"


@interface EasyTextBgView()

@property ShowTextStatus showTextStatus ;

@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *imageView ;

@property (nonatomic,strong)EasyTextConfig *config ;

@property (nonatomic,strong)UIWindow *showTextWindow ;

@end

@implementation EasyTextBgView

- (void)dealloc
{
    _showTextWindow = nil ;
}


- (void)showWindowYToPoint:(CGFloat)toPoint
{
    self.showTextWindow.easyS_y = toPoint ;
}
- (instancetype)initWithFrame:(CGRect)frame status:(ShowTextStatus)status text:(NSString *)text imageName:(NSString *)imageName config:(EasyTextConfig *)config
{
    if ([super initWithFrame:frame]) {
        
        _config = config ;
        self.backgroundColor = self.config.bgColor ; //[UIColor redColor]; //
        
        _showTextStatus = status ;
        
        if ((!(self.isShowedStatusBar||self.isShowedNavigation))) {
            
            [self setRoundedCorners:10];
            
            if (_showTextStatus != ShowTextStatusPureText && (!ISEMPTY_S(text))) {//只要不是纯文字，其他的都需要显示图片
                self.imageView.easyS_top  = EasyDrawImageEdge ;
            }
        }
        
        
        if (imageName) {
            UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            if (image) {
                self.imageView.image = image ;
            }
            else{
                NSAssert(NO, @"iamgeName is illgal ");
            }
        }
        
        
        
        if (!ISEMPTY_S(text)) {
            CGSize textSize = [EasyShowUtils textWidthWithStirng:text
                                                            font:self.config.titleFont
                                                        maxWidth:TextShowMaxWidth];
            
            self.textLabel.text = text ;
            
            
            if (self.isShowedStatusBar||self.isShowedNavigation) {
                
                CGFloat addX = self.isShowedStatusBar ? 7 : 10 ;
                CGFloat addH = self.isShowedStatusBar ?: 5;
                self.textLabel.frame = CGRectMake(self.imageView.easyS_right + addX , self.imageView.easyS_top - addH, self.easyS_width - self.imageView.easyS_right - 5, self.imageView.easyS_height +addH*2 ) ;
                //                self.textLabel.backgroundColor = [UIColor yellowColor];
                self.textLabel.textAlignment = NSTextAlignmentLeft ;
            }
            else{
                
                self.textLabel.frame = CGRectMake(20,self.easyS_height-textSize.height-15 ,textSize.width, textSize.height) ;
                self.textLabel.textAlignment = NSTextAlignmentCenter ;
            }
        }
        
        [self drawAnimationImageView];
    }
    return self ;
}

- (UIWindow *)showTextWindow
{
    if (nil == _showTextWindow) {
        CGFloat showHeight = self.isShowedStatusBar ? STATUSBAR_HEIGHT_S : NAVIGATION_HEIGHT_S ;
        _showTextWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, -showHeight , SCREEN_WIDTH_S, showHeight )];
        _showTextWindow.backgroundColor = self.config.bgColor ; // [UIColor yellowColor]; //
        _showTextWindow.windowLevel = UIWindowLevelAlert;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTap)];
        [_showTextWindow addGestureRecognizer:gesture];
        _showTextWindow.hidden = NO ;
        _showTextWindow.alpha = 1;
    }
    return _showTextWindow ;
}
- (void)gestureTap
{
}
//加载Loading的动画
- (void)drawAnimationImageViewLoading
{
    CGPoint centerPoint= CGPointMake(self.imageView.easyS_width/2.0f, self.imageView.easyS_height/2.0f) ;
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithArcCenter:centerPoint radius:centerPoint.x startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer *centerLayer=[CAShapeLayer layer];
    centerLayer.path=beizPath.CGPath;
    centerLayer.fillColor=[UIColor clearColor].CGColor;//填充色
    centerLayer.strokeColor=self.config.titleColor.CGColor;//边框颜色
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
    CGFloat imageWH = self.imageView.easyS_width ;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageWH, imageWH)
                                                    cornerRadius:imageWH/2];
    UIColor *drawColor = nil ;
    switch (_showTextStatus) {
        case ShowTextStatusPureText:
            return ;
        case ShowTextStatusSuccess:
        {
            CGFloat addHeight = self.config.statusType == TextStatusTypeStatusBar ? 1 : 3 ;
            [path moveToPoint:CGPointMake((imageWH-imageWH)/2+imageWH/4,  addHeight + imageWH/2)];
            [path addLineToPoint:CGPointMake(imageWH/2, imageWH*3/4)];
            [path addLineToPoint:CGPointMake(imageWH/2 + imageWH*1/3, imageWH*1/3)];
            
            drawColor = [UIColor greenColor] ;
        } break;
        case ShowTextStatusError:
        {
            [path moveToPoint:CGPointMake(imageWH/2-imageWH/4, imageWH/4)];
            [path addLineToPoint:CGPointMake(imageWH/2+imageWH/4, imageWH*3/4)];
            
            [path moveToPoint:CGPointMake(imageWH/2+imageWH/4, imageWH/4)];
            [path addLineToPoint:CGPointMake(imageWH/2-imageWH/4, imageWH*3/4)];
            
            drawColor = [UIColor redColor] ;
        }break ;
        case ShowTextStatusInfo:
        {
            CGFloat addHeight = self.config.statusType == TextStatusTypeStatusBar ? 5 : 3 ;
            [path moveToPoint:CGPointMake(imageWH/2,  imageWH/4 )];
            [path addLineToPoint:CGPointMake(imageWH/2,imageWH/4 + addHeight)];
            
            [path moveToPoint:CGPointMake(imageWH/2,imageWH/4 + 6)];
            [path addLineToPoint:CGPointMake(imageWH/2, imageWH*3/4 )];
            
            drawColor = [UIColor lightGrayColor] ;
        }break ;
        default:
            break;
    }
    
    CAShapeLayer *lineLayer = [ CAShapeLayer layer];
    lineLayer.frame = CGRectZero;
    lineLayer.fillColor = [ UIColor clearColor ].CGColor ;
    lineLayer.path = path. CGPath ;
    lineLayer.strokeColor = self.config.titleColor.CGColor ;
    lineLayer.lineWidth = self.isShowedStatusBar ? 1 : 2;
    lineLayer.cornerRadius = 50;
    
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    ani.fromValue = @0 ;
    ani.toValue = @1 ;
    ani.duration = 0.4;
    [lineLayer addAnimation :ani forKey :@"strokeEnd"];
    
    [self.imageView.layer addSublayer :lineLayer];
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


//是否显示在statusbar上
- (BOOL)isShowedStatusBar
{
    return self.config.statusType==TextStatusTypeStatusBar ;
}
//是否正在显示在navigation上
- (BOOL)isShowedNavigation
{
    return self.config.statusType==TextStatusTypeNavigation ;
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        CGFloat imageWH = EasyDrawImageWH ;
        CGFloat imageX = (self.easyS_width-EasyDrawImageWH)/2 ;
        CGFloat imageY = EasyDrawImageEdge/2 ;
        if (self.isShowedStatusBar) {
            imageWH = 15 ;
            imageX = 10 ;
            imageY = self.easyS_height - imageWH - 2.5 ;
        }else if ( self.isShowedNavigation){
            imageX = 10 ;
            imageY = (self.easyS_height - imageWH)/2 + (ISIPHONE_X_S ? 20 : 3 );
        }
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX,imageY , imageWH, imageWH)];
        _imageView.tintColor = self.config.titleColor ;
        //                _imageView.backgroundColor = [UIColor yellowColor];
        if ((self.isShowedStatusBar||self.isShowedNavigation)) {
            [self.showTextWindow addSubview:_imageView];
        }
        else{
            [self addSubview:_imageView];
        }
    }
    return _imageView ;
}
- (UILabel *)textLabel
{
    if (nil == _textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = self.config.titleColor;
        _textLabel.font = self.config.titleFont ;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter ;
        _textLabel.numberOfLines = 0 ;
        if ((self.isShowedStatusBar||self.isShowedNavigation)) {
            [self.showTextWindow addSubview:_textLabel];
        }
        else{
            [self addSubview:_textLabel];
        }
    }
    return _textLabel ;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
