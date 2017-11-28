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
#import "EasyShowOptions.h"

#define kDrawImageWH 40
#define KImageEdgeH 15

@interface EasyShowBgView()

@property ShowStatus showStatus ;
@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *imageView ;

@end

@implementation EasyShowBgView

- (instancetype)initWithFrame:(CGRect)frame status:(ShowStatus)status text:(NSString *)text image:(UIImage *)image
{
    if ([super initWithFrame:frame]) {
        _showStatus = status ;
        
        CGSize textSize = [EasyShowUtils textWidthWithStirng:text
                                                    font:[EasyShowOptions sharedEasyShowOptions].textFount
                                                maxWidth:[EasyShowOptions sharedEasyShowOptions].maxWidthScale*SCREEN_WIDTH];
        
        self.textLabel.text = text ;
        self.textLabel.frame = CGRectMake(20,self.height-textSize.height-15 ,textSize.width, textSize.height) ;
        
        if (status == ShowStatusImage) {
            self.imageView.image = image ;
        }
        
        self.backgroundColor = [UIColor blackColor];
        [self setRoundedCorners:UIRectCornerAllCorners
                    borderWidth:2
                    borderColor:[UIColor clearColor]
                     cornerSize:CGSizeMake(5, 5)];

       
    }
    return self ;
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
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.width-kDrawImageWH)/2, KImageEdgeH, kDrawImageWH, kDrawImageWH)
                                                    cornerRadius:kDrawImageWH/2];
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
    ani.duration = 0.4 ;
    [lineLayer addAnimation :ani forKey :@"strokeEnd"];
    
    [self.layer addSublayer :lineLayer];
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width-kDrawImageWH)/2, KImageEdgeH, kDrawImageWH, kDrawImageWH)];
        [self addSubview:_imageView] ;
    }
    return _imageView ;
}
- (UILabel *)textLabel
{
    if (nil == _textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textAlignment = NSTextAlignmentCenter ;
        _textLabel.font = [EasyShowOptions sharedEasyShowOptions].textFount ;
        _textLabel.numberOfLines = 0 ;
        [self addSubview:_textLabel];
        
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
