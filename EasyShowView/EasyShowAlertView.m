//
//  EasyShowAlertView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowAlertView.h"
#import "UIView+EasyShowExt.h"
#import "EasyShowOptions.h"
#import "EasyShowLabel.h"
@interface EasyShowAlertItem : NSObject
@property (nonatomic,strong)NSString *title ;
@property (nonatomic,assign)ShowAlertItemType itemTpye ;
@property (nonatomic,strong)alertItemCallback callback ;
@end
@implementation EasyShowAlertItem
@end

typedef NS_ENUM(NSUInteger , alertShowType) {
    alertShowTypeAlert ,
    alertShowTypeActionSheet ,
    alertShowTypeSystemAlert ,
    alertShowTypeSystemActionSheet ,
};


@interface EasyShowAlertView()<CAAnimationDelegate>

@property (nonatomic,strong)EasyShowOptions *options ;

@property (nonatomic,assign)alertShowType alertShowType ;

@property (nonatomic,strong)UILabel *alertTitleLabel ;
@property (nonatomic,strong)UILabel *alertMessageLabel ;
@property (nonatomic,strong)NSMutableArray<EasyShowAlertItem *> *alertItemArray ;
@property (nonatomic,strong)NSMutableArray *alertButtonArray ;

@property (nonatomic,strong)UIWindow *alertWindow ;
@property (nonatomic,strong)UIView *alertBgView ;
@property (nonatomic,strong)UIWindow *oldKeyWindow ;

@property (nonatomic,strong)NSString *alertShowTitle ;
@property (nonatomic,strong)NSString *alertShowMessage ;

@end

@implementation EasyShowAlertView


- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
+ (instancetype)showActionSheetWithTitle:(NSString *)title message:(NSString *)message
{
    return [self showAlertWithType:alertShowTypeActionSheet title:title message:message];
}
+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    return [self showAlertWithType:alertShowTypeAlert title:title message:message];
}
+ (instancetype)showSystemActionSheetWithTitle:(NSString *)title message:(NSString *)message
{
    return [self showAlertWithType:alertShowTypeSystemActionSheet title:title message:message] ;
}
+ (instancetype)showSystemAlertWithTitle:(NSString *)title message:(NSString *)message
{
    return [self showAlertWithType:alertShowTypeSystemAlert title:title message:message];
}
+ (instancetype)showAlertWithType:(alertShowType)type title:(NSString *)title message:(NSString *)message
{
    if (ISEMPTY_S(title) && ISEMPTY_S(message)) {
        NSAssert(NO, @"you should set title or message") ;
        return nil;
    }
    EasyShowAlertView *showView = [[EasyShowAlertView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    showView.alertShowTitle = title ;
    showView.alertShowMessage = message ;
    showView.alertShowType = type ;
    showView.alertItemArray = [NSMutableArray arrayWithCapacity:3];
    return showView ;
}

- (void)addSystemItemWithTitle:(NSString *)title itemType:(UIAlertActionStyle)itemType callback:(alertItemCallback)callback
{
    [self addItemWithTitle:title itemType:(ShowAlertItemType)itemType callback:callback];
}

- (void)addItemWithTitle:(NSString *)title itemType:(ShowAlertItemType)itemType callback:(alertItemCallback)callback
{
    NSAssert(!ISEMPTY_S(title), @"the title should input！");
    
    EasyShowAlertItem *item = [[EasyShowAlertItem alloc]init];
    item.title = title ;
    item.itemTpye = itemType ;
    item.callback = callback ;
    [self.alertItemArray addObject:item];
}


- (void)show
{
    self.oldKeyWindow = [UIApplication sharedApplication].keyWindow ;
    [self.alertWindow addSubview:self];
    [self.alertWindow makeKeyAndVisible];
    
    [self addSubview:self.alertBgView];
    
    [self.alertBgView addSubview:self.alertTitleLabel];
    [self.alertBgView addSubview:self.alertMessageLabel];
    self.alertTitleLabel.text = self.alertShowTitle ;
    self.alertMessageLabel.text = self.alertShowMessage ;
    
    for (int i = 0; i < self.alertItemArray.count; i++) {
        UIButton *button = [self alertButtonWithIndex:i ];
        [self.alertBgView addSubview:button];
    }
    
    [self layoutAlertSubViews];
    
    [self showStartAnimationWithType:self.options.alertAnimationType completion:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}

- (void)systemShow
{
    UIAlertControllerStyle stype = self.alertShowType == alertShowTypeSystemAlert ;
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:self.alertShowTitle
                                                                    message:self.alertShowMessage
                                                             preferredStyle:stype];
    
    [self.alertItemArray enumerateObjectsUsingBlock:^(EasyShowAlertItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj.title
                                                         style:(UIAlertActionStyle)obj.itemTpye
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           if (obj.callback) {
                                                               obj.callback(self);
                                                           }
                                                       }];
        [alertC addAction:action];
        
    }];

    [[EasyShowUtils topViewController] presentViewController:alertC animated:YES completion:nil];
}



- (void)statusBarOrientationChange:(NSNotification *)notification {
    
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self layoutAlertSubViews];
}
- (void)layoutAlertSubViews
{
    CGFloat bgViewMaxWidth = self.alertShowType==alertShowTypeAlert ?  SCREEN_WIDTH_S*0.75 : SCREEN_WIDTH_S ;
    CGFloat buttonHeight = 50 ;
    
    CGSize titleLabelSize = [self.alertTitleLabel sizeThatFits:CGSizeMake(bgViewMaxWidth, MAXFLOAT)];
    if (ISEMPTY_S(self.alertTitleLabel.text)) {
        titleLabelSize.height = 10 ;
    }
    self.alertTitleLabel.frame = CGRectMake(0, 0, bgViewMaxWidth, titleLabelSize.height);
    
    CGSize messageLabelSize = [self.alertMessageLabel sizeThatFits:CGSizeMake(bgViewMaxWidth, MAXFLOAT)];
    if (ISEMPTY_S(self.alertMessageLabel.text)) {
        messageLabelSize.height = 10 ;
    }
    self.alertMessageLabel.frame = CGRectMake(0, self.alertTitleLabel.bottom, bgViewMaxWidth, messageLabelSize.height) ;
    
    CGFloat totalHeight = self.alertMessageLabel.bottom + 0.5 ;
    CGFloat btnCount = self.alertButtonArray.count ;
    
    if (self.alertShowType==alertShowTypeAlert && btnCount==2 && self.options.alertTowItemHorizontal) {
       
        for (int i = 0; i < btnCount ; i++) {
            UIButton *tempButton = self.alertButtonArray[i];
            
            CGFloat tempButtonX = i ? (bgViewMaxWidth/2+0.5) : 0 ;
            CGFloat tempButtonY = self.alertMessageLabel.bottom +0.5  ;
            [tempButton setFrame:CGRectMake(tempButtonX, tempButtonY, bgViewMaxWidth/2, buttonHeight)];
            totalHeight = tempButton.bottom ;
        }
    }
    else{
        for (int i = 0; i < btnCount ; i++) {
            UIButton *tempButton = self.alertButtonArray[i];
            
            CGFloat lineHeight = ((i==btnCount-1)&&self.alertShowType==alertShowTypeActionSheet) ? 10 : 0.5 ;
            CGFloat tempButtonY = self.alertMessageLabel.bottom + lineHeight + i*(buttonHeight+ 0.5) ;
            [tempButton setFrame:CGRectMake(0, tempButtonY, bgViewMaxWidth, buttonHeight)];
            totalHeight = tempButton.bottom ;
        }
    }
 
    CGFloat actionShowAddSafeHeiht = self.alertShowType==alertShowTypeActionSheet ? kEasyShowSafeBottomMargin_S : 0 ;
    self.alertBgView.bounds = CGRectMake(0, 0, bgViewMaxWidth, totalHeight+actionShowAddSafeHeiht);
    
    switch (self.alertShowType) {
        case alertShowTypeAlert:
        {
            self.alertBgView.center = self.center ;
            
            UIColor *boderColor = [self.alertBgView.backgroundColor colorWithAlphaComponent:0.2];
            [self.alertBgView setRoundedCorners:UIRectCornerAllCorners
                                    borderWidth:0.5
                                    borderColor:boderColor
                                     cornerSize:CGSizeMake(15,15)];//需要添加阴影
        }break;
        case alertShowTypeActionSheet:
        {
            self.alertBgView.center = CGPointMake(SCREEN_WIDTH_S/2, SCREEN_HEIGHT_S-(totalHeight/2));
        }break ;
        default:
            break;
    }
  
}

- (void)bgViewTap:(UIPanGestureRecognizer *)recognizer
{
    
}
- (void)bgViewPan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self];

    UIButton *tempButton = nil;
    for (int i = 0; i < self.alertButtonArray.count; i++) {
        UIButton *itemBtn = self.alertButtonArray[i];
        CGRect btnFrame = [itemBtn convertRect:itemBtn.bounds toView:self];
        if (CGRectContainsPoint(btnFrame, location)) {
            itemBtn.highlighted = YES;
            tempButton = itemBtn;
        } else {
            itemBtn.highlighted = NO;
        }
    }
    
    if (tempButton && recognizer.state == UIGestureRecognizerStateEnded) {
        [self buttonClick:tempButton];
    }
    
}

- (void)buttonClick:(UIButton *)button
{
    EasyShowAlertItem *item = self.alertItemArray[button.tag];
    if (item.callback) {
        item.callback(self);
    }
    [self alertWindowTap];
}
- (UIButton *)alertButtonWithIndex:(long)index
{
    EasyShowAlertItem *item = self.alertItemArray[index];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:item.title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *bgImage = [EasyShowUtils imageWithColor:[UIColor whiteColor]];
    UIImage *bgHighImage = [EasyShowUtils imageWithColor:[[UIColor whiteColor]colorWithAlphaComponent:0.7] ];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setBackgroundImage:bgHighImage forState:UIControlStateHighlighted];
    
    UIFont *textFont = [UIFont systemFontOfSize:17] ;
    UIColor *textColor = [UIColor blackColor] ;
    switch (item.itemTpye) {
        case ShowAlertItemTypeRed: {
            textColor = [UIColor redColor];
        }break ;
        case ShowAlertItemTypeBlodRed:{
            textColor = [UIColor redColor];
            textFont  = [UIFont boldSystemFontOfSize:17] ;
        }break ;
        case ShowAlertItemTypeBlue:{
            textColor = [UIColor blueColor];
        }break ;
        case ShowAlertItemTypeBlodBlue:{
            textColor = [UIColor blueColor];
            textFont = [UIFont boldSystemFontOfSize:17] ;
        }break ;
        case ShowAlertItemTypeBlack:{
            
        }break ;
        case ShowAlertItemTypeBlodBlack:{
            textFont = [UIFont boldSystemFontOfSize:17] ;
        }break ;
        case ShowStatusTextTypeCustom:{
            
        }break ;
    }
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[textColor colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:textFont] ;
    
    [self.alertButtonArray addObject:button];
    
    return button ;
}

- (void)alertWindowTap
{
    
    void (^completion)(void) = ^{
        [self.oldKeyWindow makeKeyWindow];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
        
        [self.alertWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.alertWindow.hidden = YES ;
        [self.alertWindow removeFromSuperview];
        self.alertWindow = nil;
    };
    
    [self showEndAnimationWithType:self.options.alertAnimationType
                        completion:completion];
}

#pragma mark - animation

- (void)showEndAnimationWithType:(alertAnimationType)type completion:(void(^)(void))completion
{
    if (self.alertShowType == alertShowTypeActionSheet) {
        [UIView animateWithDuration:EasyShowAnimationTime animations:^{
            self.alertBgView.top = SCREEN_HEIGHT_S ;
        } completion:^(BOOL finished) {
            if (completion) {
                completion() ;
            }
        }];
        return ;
    }
    
    switch (type) {
        case alertAnimationTypeFade:
        {
            [UIView animateWithDuration:EasyShowAnimationTime
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alpha = .0f;
                                 self.transform = CGAffineTransformIdentity;
                             } completion:^(BOOL finished) {
                                 if (completion) {
                                     completion() ;
                                 }
                             }];
        }break;
        case alertAnimationTypeZoom:
        {
            [UIView animateWithDuration:EasyShowAnimationTime
                                  delay:0 options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertBgView.alpha = 0 ;
                                 self.alertBgView.transform = CGAffineTransformMakeScale(0.01, 0.01);
                             } completion:^(BOOL finished) {
                                 if (completion) {
                                     completion() ;
                                 }
                             }];
        }break ;
        case alertAnimationTypeBounce:
        {
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
            
            animationGroup.delegate = self ;
            [animationGroup setValue:completion forKey:@"handler"];
            
            [self.alertBgView.layer addAnimation:animationGroup forKey:nil];
        }break ;
        case alertAnimationTypePush:
        {
            [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                self.alertBgView.top = SCREEN_HEIGHT_S ;
            } completion:^(BOOL finished) {
                if (completion) {
                    completion() ;
                }
            }];
        }break ;
        default:
        {
            if (completion) {
                completion();
            }
        }
            break;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}
- (void)showStartAnimationWithType:(alertAnimationType)type completion:(void(^)(void))completion
{
    if (self.alertShowType == alertShowTypeActionSheet) {
        self.alertBgView.top = SCREEN_HEIGHT_S ;
        [UIView animateWithDuration:EasyShowAnimationTime animations:^{
            self.alertBgView.top = (SCREEN_HEIGHT_S-self.alertBgView.height)-5 ;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05 animations:^{
                self.alertBgView.top = (SCREEN_HEIGHT_S-self.alertBgView.height) ;
            } completion:^(BOOL finished) {
            }];
        }];
        return ;
    }
    
    switch (type) {
        case alertAnimationTypeFade:
        {
            self.alertBgView.alpha = 0 ;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:EasyShowAnimationTime];
            self.alertBgView.alpha = 1.0f;
            [UIView commitAnimations];
        }break;
        case alertAnimationTypeZoom:
        {
            self.alertBgView.alpha = 0 ;
            self.alertBgView.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(3, 3));
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:EasyShowAnimationTime];
            self.alertBgView.alpha = 1.0f;
            self.alertBgView.transform = CGAffineTransformIdentity;
            [UIView commitAnimations];
        }break ;
        case alertAnimationTypeBounce:
        {
            CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            popAnimation.duration = EasyShowAnimationTime;
            popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
                                    [NSValue valueWithCATransform3D:CATransform3DIdentity]];
            popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
            popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.alertBgView.layer addAnimation:popAnimation forKey:nil];
        }break ;
        case alertAnimationTypePush:
        {
            self.alertBgView.top = SCREEN_HEIGHT_S ;
            [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                self.alertBgView.top = (SCREEN_HEIGHT_S-self.alertBgView.height)/2-5 ;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    self.alertBgView.top = (SCREEN_HEIGHT_S-self.alertBgView.height)/2 ;
                } completion:^(BOOL finished) {
                }];
            }];
        }break ;
        default:
            break;
    }
}

#pragma mark - getter
- (UIView *)alertBgView
{
    if (nil == _alertBgView) {
        _alertBgView = [[UIView alloc]init];
        if (self.options.alertTintColor == [UIColor clearColor]) {
            _alertBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        else{
            _alertBgView.backgroundColor = self.options.alertTintColor;
        }
        _alertBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewPan:)] ;
        [_alertBgView addGestureRecognizer:panGesture];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewTap:)] ;
        [_alertBgView addGestureRecognizer:tapGesture];

        //        _alertBgView.clipsToBounds = YES ;
        //        _alertBgView.layer.cornerRadius = 10 ;
    }
    return _alertBgView ;
}
- (UIWindow *)alertWindow {
    if (nil == _alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _alertBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
         _alertWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _alertWindow.hidden = NO ;
        if (self.options.alertBgViewTapRemove) {
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertWindowTap)];
            [_alertWindow addGestureRecognizer:tapGes];
        }
    }
    
    return _alertWindow;
}

- (UILabel *)alertTitleLabel
{
    if (nil == _alertTitleLabel) {
        _alertTitleLabel = [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(35, 30, 15, 30)];
        _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        if (self.options.alertTintColor == [UIColor clearColor]) {
            _alertTitleLabel.backgroundColor = [UIColor whiteColor];
        }
        else{
            _alertTitleLabel.backgroundColor = self.options.alertTintColor;
        }
        _alertTitleLabel.font = [UIFont boldSystemFontOfSize:20];
        _alertTitleLabel.textColor = self.options.alertTitleColor ;
        _alertTitleLabel.numberOfLines = 0;
    }
    return _alertTitleLabel ;
}
- (UILabel *)alertMessageLabel
{
    if (nil == _alertMessageLabel) {
        _alertMessageLabel = [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(15, 30, 20, 30)];
        _alertMessageLabel.textAlignment = NSTextAlignmentCenter;
        if (self.options.alertTintColor == [UIColor clearColor]) {
            _alertMessageLabel.backgroundColor = [UIColor whiteColor];
        }
        else{
            _alertMessageLabel.backgroundColor = self.options.alertTintColor;
        }
        _alertMessageLabel.font = [UIFont systemFontOfSize:17];
        _alertMessageLabel.textColor = self.options.alertMessageColor;
        _alertMessageLabel.numberOfLines = 0;
    }
    return _alertMessageLabel ;
}
- (NSMutableArray *)alertButtonArray
{
    if (nil == _alertButtonArray) {
        _alertButtonArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _alertButtonArray ;
}
- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
}





@end
