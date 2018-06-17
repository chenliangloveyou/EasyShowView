//
//  EasyAlertView.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/14.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyAlertView.h"
#import "UIView+EasyShowExt.h"
#import "EasyAlertConfig.h"

#import "EasyShowLabel.h"
#import "EasyAlertGlobalConfig.h"
#import "EasyAlertItem.h"


@interface EasyAlertView()<CAAnimationDelegate>

@property (nonatomic,strong)EasyAlertConfig *config ;
@property (nonatomic,strong)EasyAlertPart   *part ;
@property (nonatomic,strong)AlertCallback   callback ;

@property (nonatomic,strong)UILabel *titleLabel ;
@property (nonatomic,strong)UILabel *subtitleLabel ;
@property (nonatomic,strong)UIView *alertBgView ;
@property (nonatomic,strong)NSMutableArray<EasyAlertItem *> *itemArray ;
@property (nonatomic,strong)NSMutableArray<UIButton *> *buttonArray ;

@property (nonatomic,strong)UIWindow *alertWindow ;
//@property (nonatomic,strong)UIWindow *oldKeyWindow ;


@end

@implementation EasyAlertView

- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}


+ (EasyAlertView *)alertViewWithPart:(EasyAlertPart *(^)(void))part
                              config:(EasyAlertConfig *(^)(void))config
                         buttonArray:(NSArray<NSString *> *(^)(void))buttonArray
                            callback:(AlertCallback)callback
{
    EasyAlertView *alertView = [self alertViewWithPart:part config:config callback:callback];
    NSArray *tempArr = buttonArray ? buttonArray() : @[] ;
    [alertView addAlertItemWithTitleArray:tempArr callback:callback];
    [alertView showAlertView];
    return alertView ;
}


//第一步：创建一个自定义的Alert/ActionSheet
+ (instancetype)alertViewWithTitle:(NSString *)title
                          subtitle:(NSString *)subtitle
                     AlertViewType:(AlertViewType)alertType
                            config:(EasyAlertConfig *(^)(void))config
{
    EasyAlertPart *(^tempPart)(void) = ^EasyAlertPart *{
        return [EasyAlertPart alertPartWithTitle:title subtitle:subtitle alertype:alertType] ;
    };
    return [self alertViewWithPart:tempPart config:config callback:nil] ;
    
}

+ (instancetype)alertViewWithPart:(EasyAlertPart *(^)(void))part
                           config:(EasyAlertConfig *(^)(void))config
                         callback:(AlertCallback)callback
{
    EasyAlertPart *tempPart = [self changePartWithPart:part];
    EasyAlertConfig *tempConfig = [self changeConfigWithConfig:config] ;
    
    EasyAlertView *showView = [[EasyAlertView alloc]initWithPart:tempPart config:tempConfig];
    showView.callback = callback ;
    showView.itemArray = [NSMutableArray arrayWithCapacity:3];
    return showView ;
}

//第二步：往创建的alert上面添加事件
- (void)addAlertItemWithTitle:(NSString *)title
                         type:(AlertItemType)type
                     callback:(AlertCallback)callback
{
    EasyAlertItem *tempItem = [EasyAlertItem itemWithTitle:title type:type callback:callback];
    [self.itemArray addObject:tempItem];
}
- (void)addAlertItem:(EasyAlertItem *(^)(void))item
{
    EasyAlertItem *tempItem = item ? item() : [EasyAlertItem init];
    [self.itemArray addObject:tempItem];
}
- (void)addAlertItemWithTitleArray:(NSArray *)titleArray
                          callback:(AlertCallback)callbck
{
    for (int i = 0 ; i < titleArray.count; i++) {
        EasyAlertItem *tempItem = [EasyAlertItem itemWithTitle:titleArray[i] type:AlertItemTypeBlack callback:callbck];
        [self.itemArray addObject:tempItem];
    }
}

//第三步：展示alert
- (void)showAlertView
{
    
    if (self.part.alertType == AlertViewTypeSystemAlert ||self.part.alertType==AlertViewTypeSystemActionSheet ) {
        UIAlertControllerStyle stype = self.part.alertType == AlertViewTypeSystemAlert ;
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:self.part.title
                                                                        message:self.part.subtitle
                                                                 preferredStyle:stype];
        [self.itemArray enumerateObjectsUsingBlock:^(EasyAlertItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIAlertActionStyle actionStyle = UIAlertActionStyleDefault ;
            if (obj.itemTpye == AlertItemTypeSystemCancel) {
                actionStyle = UIAlertActionStyleCancel ;
            }else if (obj.itemTpye == AlertItemTypeSystemDestructive){
                actionStyle = UIAlertActionStyleDestructive ;
            }
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:obj.title
                                                             style:actionStyle
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               typeof(self)weakself = self;
                                                               if (self.callback) {
                                                                   self.callback(weakself, idx);
                                                               }else{
                                                                   if (obj.callback) {
                                                                       obj.callback(weakself,idx);
                                                                   }
                                                               }
                                                               
                                                           }];
            [alertC addAction:action];
        }];
       
        UIViewController *presentVC = [EasyShowUtils easyShowViewTopViewController];
        [presentVC presentViewController:alertC animated:YES completion:nil];
        
        return ;
    }    
    
//    self.oldKeyWindow = [UIApplication sharedApplication].keyWindow ;
    
    [self removeOtherAlertView];
    [self.alertWindow addSubview:self];
//    [self.alertWindow makeKeyAndVisible];
    
    [self addSubview:self.alertBgView];
    
    [self.alertBgView addSubview:self.titleLabel];
    [self.alertBgView addSubview:self.subtitleLabel];
    self.titleLabel.text = self.part.title ;
    self.subtitleLabel.text = self.part.subtitle ;
    
    for (int i = 0; i < self.itemArray.count; i++) {
        UIButton *button = [self alertButtonWithIndex:i];
        [self.alertBgView addSubview:button];
    }
    
    [self layoutAlertSubViews];
    
    [self showStartAnimationWithType:self.config.animationType completion:nil];
    
}


// 移除alertview
- (void)removeAlertView
{
    [self alertWindowTap];
}
- (instancetype)initWithPart:(EasyAlertPart *)part config:(EasyAlertConfig *)config
{
    if (self = [super init]) {
        _part = part ;
        _config = config ;
        self.frame = [UIApplication sharedApplication].keyWindow.bounds ;
    }
    return self ;
}



- (void)statusBarOrientationChange:(NSNotification *)notification {
    
    //    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self layoutAlertSubViews];
}
- (void)layoutAlertSubViews
{
    CGFloat bgViewMaxWidth = self.part.alertType==AlertViewTypeAlert ?  SCREEN_WIDTH_S*0.75 : SCREEN_WIDTH_S ;
    CGFloat buttonHeight = 50 ;
    
    CGSize titleLabelSize = [self.titleLabel sizeThatFits:CGSizeMake(bgViewMaxWidth, MAXFLOAT)];
    if (ISEMPTY_S(self.titleLabel.text)) {
        titleLabelSize.height = 10 ;
    }
    self.titleLabel.frame = CGRectMake(0, 0, bgViewMaxWidth, titleLabelSize.height);
    
    CGSize messageLabelSize = [self.subtitleLabel sizeThatFits:CGSizeMake(bgViewMaxWidth, MAXFLOAT)];
    if (ISEMPTY_S(self.subtitleLabel.text)) {
        messageLabelSize.height = 10 ;
    }
    self.subtitleLabel.frame = CGRectMake(0, self.titleLabel.easyS_bottom, bgViewMaxWidth, messageLabelSize.height) ;
    
    CGFloat totalHeight = self.subtitleLabel.easyS_bottom + 0.5 ;
    CGFloat btnCount = self.buttonArray.count ;
    
    if (self.part.alertType==AlertViewTypeAlert && btnCount==2 && self.config.twoItemHorizontal) {
        
        for (int i = 0; i < btnCount ; i++) {
            UIButton *tempButton = self.buttonArray[i];
            
            CGFloat tempButtonX = i ? (bgViewMaxWidth/2+0.5) : 0 ;
            CGFloat tempButtonY = self.subtitleLabel.easyS_bottom +0.5  ;
            [tempButton setFrame:CGRectMake(tempButtonX, tempButtonY, bgViewMaxWidth/2, buttonHeight)];
            totalHeight = tempButton.easyS_bottom ;
        }
    }
    else{
        for (int i = 0; i < btnCount ; i++) {
            UIButton *tempButton = self.buttonArray[i];
            
            CGFloat lineHeight = ((i==btnCount-1)&&self.part.alertType==AlertViewTypeActionSheet) ? 10 : 0.5 ;
            CGFloat tempButtonY = self.subtitleLabel.easyS_bottom + lineHeight + i*(buttonHeight+ 0.5) ;
            [tempButton setFrame:CGRectMake(0, tempButtonY, bgViewMaxWidth, buttonHeight)];
            totalHeight = tempButton.easyS_bottom ;
        }
    }
    
    CGFloat actionShowAddSafeHeiht = self.part.alertType==AlertViewTypeActionSheet ? kEasyShowSafeBottomMargin_S : 0 ;
    self.alertBgView.bounds = CGRectMake(0, 0, bgViewMaxWidth, totalHeight+actionShowAddSafeHeiht);
    
    switch (self.part.alertType) {
        case AlertViewTypeAlert:
        {
            self.alertBgView.center = self.center ;
            
            UIColor *boderColor = [self.alertBgView.backgroundColor colorWithAlphaComponent:0.2];
            [self.alertBgView setRoundedCorners:UIRectCornerAllCorners
                                    borderWidth:0.5
                                    borderColor:boderColor
                                     cornerSize:CGSizeMake(15,15)];//需要添加阴影
        }break;
        case AlertViewTypeActionSheet:
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
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIButton *itemBtn = self.buttonArray[i];
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
    EasyAlertItem *item = self.itemArray[button.tag];
    if (self.callback || item.callback) {
        typeof(self)weakself = self;
        dispatch_queue_after_S(EasyShowAnimationTime/2.0f, ^{
            if (self.callback) {
                self.callback(weakself, button.tag);
            }else{
                if (item.callback) {
                    item.callback(weakself,button.tag);
                }
            }
        });
    }
    [self alertWindowTap];
}
- (UIButton *)alertButtonWithIndex:(long)index
{
    EasyAlertItem *item = self.itemArray[index];
    
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
        case AlertItemTypeRed: {
            textColor = [UIColor redColor];
        }break ;
        case AlertItemTypeBlodRed:{
            textColor = [UIColor redColor];
            textFont  = [UIFont boldSystemFontOfSize:17] ;
        }break ;
        case AlertItemTypeBlue:{
            textColor = [UIColor blueColor];
        }break ;
        case AlertItemTypeBlodBlue:{
            textColor = [UIColor blueColor];
            textFont = [UIFont boldSystemFontOfSize:17] ;
        }break ;
        case AlertItemTypeBlack:{
            
        }break ;
        case AlertItemTypeBlodBlack:{
            textFont = [UIFont boldSystemFontOfSize:17] ;
        }break ;
        case AlertItemTypeCustom:{
            
        }break ;
        default:
        break ;
    }
    [button setTitleColor:textColor forState:UIControlStateNormal];
    [button setTitleColor:[textColor colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:textFont] ;
    
    [self.buttonArray addObject:button];
    
    return button ;
}

- (void)alertWindowTap
{
    
    void (^completion)(void) = ^{
//        [self.oldKeyWindow makeKeyWindow];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
        
        [self.alertWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.alertWindow.hidden = YES ;
        [self.alertWindow removeFromSuperview];
        self.alertWindow = nil;
    };
    
    [self showEndAnimationWithType:self.config.animationType
                        completion:completion];
}

#pragma mark - animation

- (void)showEndAnimationWithType:(AlertAnimationType)type completion:(void(^)(void))completion
{
    if (self.part.alertType == AlertViewTypeActionSheet) {
        [UIView animateWithDuration:EasyShowAnimationTime animations:^{
            self.alertBgView.easyS_top = SCREEN_HEIGHT_S ;
        } completion:^(BOOL finished) {
            if (completion) {
                completion() ;
            }
        }];
        return ;
    }
    
    switch (type) {
        case AlertAnimationTypeFade:
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
        case AlertAnimationTypeZoom:
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
        case AlertAnimationTypeBounce:
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
        case AlertAnimationTypePush:
        {
            [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                self.alertBgView.easyS_top = SCREEN_HEIGHT_S ;
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
- (void)showStartAnimationWithType:(AlertAnimationType)type completion:(void(^)(void))completion
{
    if (self.part.alertType == AlertViewTypeActionSheet) {
        self.alertBgView.easyS_top = SCREEN_HEIGHT_S ;
        [UIView animateWithDuration:EasyShowAnimationTime animations:^{
            self.alertBgView.easyS_top = (SCREEN_HEIGHT_S-self.alertBgView.easyS_height)-5 ;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05 animations:^{
                self.alertBgView.easyS_top = (SCREEN_HEIGHT_S-self.alertBgView.easyS_height) ;
            } completion:^(BOOL finished) {
            }];
        }];
        return ;
    }
    
    switch (type) {
        case AlertAnimationTypeFade:
        {
            self.alertBgView.alpha = 0 ;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:EasyShowAnimationTime];
            self.alertBgView.alpha = 1.0f;
            [UIView commitAnimations];
        }break;
        case AlertAnimationTypeZoom:
        {
            self.alertBgView.alpha = 0 ;
            self.alertBgView.transform = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(3, 3));
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:EasyShowAnimationTime];
            self.alertBgView.alpha = 1.0f;
            self.alertBgView.transform = CGAffineTransformIdentity;
            [UIView commitAnimations];
        }break ;
        case AlertAnimationTypeBounce:
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
        case AlertAnimationTypePush:
        {
            self.alertBgView.easyS_top = SCREEN_HEIGHT_S ;
            [UIView animateWithDuration:EasyShowAnimationTime animations:^{
                self.alertBgView.easyS_top = (SCREEN_HEIGHT_S-self.alertBgView.easyS_height)/2-5 ;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    self.alertBgView.easyS_top = (SCREEN_HEIGHT_S-self.alertBgView.easyS_height)/2 ;
                } completion:^(BOOL finished) {
                }];
            }];
        }break ;
        default:
            break;
    }
}

- (void)removeOtherAlertView
{
    NSMutableArray *tempAlertViewArray = [NSMutableArray arrayWithCapacity:2];
    for (UIWindow *subWindow in [UIApplication sharedApplication].windows) {
        for (UIView *subView in subWindow.subviews) {
            if ([subView isKindOfClass:[self class]]) {
                [tempAlertViewArray addObject:subView];
            }
        }
    }
    if (tempAlertViewArray.count > self.config.alertViewMaxNum-1) {
        for (int i = 0 ; i < tempAlertViewArray.count-self.config.alertViewMaxNum+1; i++) {
            UIView *tempView = tempAlertViewArray[i];
            if ([tempView isKindOfClass:[self class]]) {
                EasyAlertView *tempAlertView = (EasyAlertView *)tempView ;
                [tempAlertView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [tempAlertView removeFromSuperview];
                
                [tempAlertView.alertWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                tempAlertView.alertWindow.hidden = YES ;
                [tempAlertView.alertWindow removeFromSuperview];
                tempAlertView.alertWindow = nil;
            }
        }
    }
}

#pragma mark - getter
- (UIView *)alertBgView
{
    if (nil == _alertBgView) {
        _alertBgView = [[UIView alloc]init];
        _alertBgView.backgroundColor = self.config.tintColor==[UIColor clearColor] ?  [UIColor groupTableViewBackgroundColor] : self.config.tintColor ;
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
        
        if (self.config.effectType == AlertBgEffectTypeAlphaCover) {
            _alertWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        }
        else{
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
            effectView.alpha = 0.8;
            effectView.frame = _alertWindow.bounds ;
            [_alertWindow addSubview:effectView];
        }
        
        
        _alertWindow.hidden = NO ;
        if (self.config.bgViewEvent) {
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertWindowTap)];
            [_alertWindow addGestureRecognizer:tapGes];
        }
    }
    
    return _alertWindow;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(35, 30, 15, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = self.config.tintColor == [UIColor clearColor] ?  [UIColor whiteColor] : self.config.tintColor ;
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = self.config.titleColor ;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel ;
}
- (UILabel *)subtitleLabel
{
    if (nil == _subtitleLabel) {
        _subtitleLabel = [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(15, 30, 20, 30)];
        _subtitleLabel.textAlignment = self.config.subtitleTextAligment ;
        _subtitleLabel.backgroundColor = self.config.tintColor==[UIColor clearColor] ? [UIColor whiteColor] : self.config.tintColor;
        _subtitleLabel.font = [UIFont systemFontOfSize:17];
        _subtitleLabel.textColor = self.config.subtitleColor ;
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel ;
}
- (NSMutableArray *)buttonArray
{
    if (nil == _buttonArray) {
        _buttonArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _buttonArray ;
}


#pragma mark - 工具方法
+ (EasyAlertPart *)changePartWithPart:(EasyAlertPart *(^)(void))part
{
    EasyAlertPart *tempPart = part ? part() : nil ;
    if (nil == tempPart) {
        tempPart = [EasyAlertPart alertPartWithTitle:nil subtitle:nil alertype:AlertViewTypeAlert] ;
    }
    
    if (ISEMPTY_S(tempPart.title) && ISEMPTY_S(tempPart.subtitle)) {
        NSAssert(NO, @"you should set title or message") ;
    }
    return tempPart ;
}
+ (EasyAlertConfig *)changeConfigWithConfig:(EasyAlertConfig *(^)(void))config
{
    EasyAlertConfig *tempConfig = config ? config() : nil ;
    if (nil == tempConfig) {
        tempConfig = [EasyAlertConfig shared];
    }
    
    EasyAlertGlobalConfig *globalConfig = [EasyAlertGlobalConfig shared];
    if (!tempConfig.tintColor) {
        tempConfig.tintColor = globalConfig.tintColor ;
    }
    if (!tempConfig.titleColor) {
        tempConfig.titleColor = globalConfig.titleColor ;
    }
    if (!tempConfig.subtitleColor) {
        tempConfig.subtitleColor = globalConfig.subtitleColor ;
    }
    if (tempConfig.animationType == AlertAnimationTypeUndefine) {
        tempConfig.animationType = globalConfig.animationType ;
    }
    if (tempConfig.alertViewMaxNum <= 0) {
        tempConfig.alertViewMaxNum = globalConfig.alertViewMaxNum ;
    }
    return tempConfig ;
}

@end
