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

@interface EasyAlertLabel :UILabel

- (instancetype)initWithContentInset:(UIEdgeInsets)contentInset ;

@property (nonatomic) UIEdgeInsets contentInset;
@end

@implementation EasyAlertLabel
- (instancetype)initWithContentInset:(UIEdgeInsets)contentInset
{
    if (self = [super init]) {
        _contentInset = contentInset ;
    }
    return self ;
}
- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    NSString *tempString = self.text;
    self.text = @"";
    self.text = tempString;
}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    UIEdgeInsets insets = self.contentInset;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

-(void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentInset)];
}
@end


@interface EasyShowView()<CAAnimationDelegate>

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)UIImage *showImage ;//展示的图片
@property (nonatomic,assign)ShowTextStatus showTextStatus ;//展示的类型
@property (nonatomic,assign)ShowType showType ;//展示的类型

@property (nonatomic,strong)EasyShowOptions *options ;


@property (nonatomic,strong)NSTimer *removeTimer ;
@property (nonatomic,assign)CGFloat showTime ;
@property CGFloat timerShowTime ;//定时器走动的时间


@property (nonatomic,strong)EasyShowBgView *showBgView ;//用于放图片和文字的背景


@property (nonatomic,strong)UILabel *alertTitleLabel ;
@property (nonatomic,strong)UILabel *alertMessageLabel ;
@property (nonatomic,strong)NSMutableArray<EasyShowAlertItem *> *alertItemArray ;
@property (nonatomic,strong)NSMutableArray *alertButtonArray ;

@property (nonatomic,strong)UIWindow *alertWindow ;
@property (nonatomic,strong)UIView *alertBgView ;
@property (nonatomic,strong)UIWindow *oldKeyWindow ;

@end

@implementation EasyShowView

- (void)dealloc
{
    NSLog(@"%p EasyShowView dealloc",self );
}

+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    EasyShowView *showView = [[EasyShowView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    showView.alertTitleLabel.text = title ;
    showView.alertMessageLabel.text = message ;
    showView.alertItemArray = [NSMutableArray arrayWithCapacity:3];
    return showView ;
}
- (void)addAlertItem:(EasyShowAlertItem *)item
{
    [self.alertItemArray addObject:item];
}
- (void)layoutAlertSubViews
{
    CGFloat bgViewMaxWidth = SCREEN_WIDTH*0.75 ;
    CGFloat buttonHeight = 44 ;
    
    CGSize titleLabelSize = [self.alertTitleLabel sizeThatFits:CGSizeMake(bgViewMaxWidth, MAXFLOAT)];
    self.alertTitleLabel.frame = CGRectMake(0, 0, bgViewMaxWidth, titleLabelSize.height);
    
    CGSize messageLabelSize = [self.alertMessageLabel sizeThatFits:CGSizeMake(bgViewMaxWidth, MAXFLOAT)];
    self.alertMessageLabel.frame = CGRectMake(0, self.alertTitleLabel.bottom, bgViewMaxWidth, messageLabelSize.height) ;
    
    CGFloat totalHeight = self.alertMessageLabel.bottom + 0.5 ;
    for (int i = 0; i < self.alertButtonArray.count; i++) {
        UIButton *tempButton = self.alertButtonArray[i];
        CGFloat tempButtonY = self.alertMessageLabel.bottom + 0.5 + i*(buttonHeight+ 0.5) ;
        [tempButton setFrame:CGRectMake(0, tempButtonY, bgViewMaxWidth, buttonHeight)];
        totalHeight = tempButton.bottom ;
    }
    
    self.alertBgView.bounds = CGRectMake(0, 0, bgViewMaxWidth, totalHeight);
    self.alertBgView.center = self.center ;
    
    UIColor *boderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [self.alertBgView setRoundedCorners:UIRectCornerAllCorners
                            borderWidth:1
                            borderColor:boderColor
                             cornerSize:CGSizeMake(15,15)];//需要添加阴影
    
}

- (void)showAlert
{
    self.oldKeyWindow = [UIApplication sharedApplication].keyWindow ;
    [self.oldKeyWindow resignKeyWindow];
    [self.alertWindow addSubview:self];
    [self.alertWindow makeKeyWindow];
    
    [self addSubview:self.alertBgView];
    
    [self.alertBgView addSubview:self.alertTitleLabel];
    [self.alertBgView addSubview:self.alertMessageLabel];
    for (int i = 0; i < self.alertItemArray.count; i++) {
        UIButton *button = [self alertButtonWithIndex:i ];
        [self.alertBgView addSubview:button];
    }
    
    [self layoutAlertSubViews];
}
- (void)buttonAction:(UIButton *)button
{
    EasyShowAlertItem *item = self.alertItemArray[button.tag];
    if (item.callback) {
        item.callback(self);
    }
    [self alertWindowTap];
}
- (UIView *)alertBgView
{
    if (nil == _alertBgView) {
        _alertBgView = [[UIView alloc]init];
        if (self.options.alertBackgroundColor) {
            _alertBgView.backgroundColor = self.options.alertBackgroundColor;
        }else{
            _alertBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        //        _alertBgView.clipsToBounds = YES ;
        //        _alertBgView.layer.cornerRadius = 10 ;
    }
    return _alertBgView ;
}
- (NSMutableArray *)alertButtonArray
{
    if (nil == _alertButtonArray) {
        _alertButtonArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _alertButtonArray ;
}
- (UILabel *)alertTitleLabel
{
    if (nil == _alertTitleLabel) {
        _alertTitleLabel = [[EasyAlertLabel alloc] initWithContentInset:UIEdgeInsetsMake(35, 30, 15, 30)];
        _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        if (self.options.alertBackgroundColor) {
            _alertTitleLabel.backgroundColor = self.options.alertBackgroundColor;
        }
        else{
            _alertTitleLabel.backgroundColor = [UIColor whiteColor];
        }
        _alertTitleLabel.font = [UIFont boldSystemFontOfSize:20];
        //        _alertTitleLabel.textColor = [UIColor yellowColor];
        _alertTitleLabel.numberOfLines = 0;
    }
    return _alertTitleLabel ;
}
- (UILabel *)alertMessageLabel
{
    if (nil == _alertMessageLabel) {
        _alertMessageLabel = [[EasyAlertLabel alloc] initWithContentInset:UIEdgeInsetsMake(15, 30, 20, 30)];
        _alertMessageLabel.textAlignment = NSTextAlignmentCenter;
        if (self.options.alertBackgroundColor) {
            _alertMessageLabel.backgroundColor = self.options.alertBackgroundColor;
        }
        else{
            _alertMessageLabel.backgroundColor = [UIColor whiteColor];
        }
        _alertMessageLabel.font = [UIFont systemFontOfSize:17];
        _alertMessageLabel.textColor = [UIColor grayColor];
        _alertMessageLabel.numberOfLines = 0;
    }
    return _alertMessageLabel ;
}
- (UIButton *)alertButtonWithIndex:(long)index
{
    EasyShowAlertItem *item = self.alertItemArray[index];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:item.title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
- (UIWindow *)alertWindow {
    if (nil == _alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertWindowTap)];
        [_alertWindow addGestureRecognizer:tapGes];
        _alertWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _alertWindow.hidden = NO ;
    }
    
    return _alertWindow;
}
- (void)alertWindowTap
{
    
    [self.oldKeyWindow makeKeyWindow];
    [self.alertWindow resignKeyWindow];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
    
    [self.alertWindow.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.alertWindow.hidden = YES ;
    [self.alertWindow removeFromSuperview];
    self.alertWindow = nil;
    
}










+ (void)showLodingWithText:(NSString *)text inView:(UIView *)superView image:(UIImage *)image
{
    [EasyShowView showText:text inView:superView image:image textStatus:-1 showType:ShowTypeLoding];
}
+ (void)showToastWithText:(NSString *)text inView:(UIView *)view image:(UIImage *)image stauts:(ShowTextStatus)status
{
    [EasyShowView showText:text inView:view image:image textStatus:status showType:ShowTypeText];
}

+ (void)showText:(NSString *)text inView:(UIView *)view image:(UIImage *)image textStatus:(ShowTextStatus)status showType:(ShowType)showType
{
    if (status==ShowTextStatusPureText && ISEMPTY(text)) {//
        NSAssert(NO, @"you should set a text for showView !");
        return ;
    }
    if (nil == view) {
        NSAssert(NO, @"there shoud have a superview");
        return ;
    }
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    
    //显示之前---->隐藏还在显示的视图
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyShowView *showView = (EasyShowView *)subview ;
            [showView clearCurrentShow];
        }
    }
    
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    EasyShowView *showView = [[EasyShowView alloc] initWithFrame:CGRectZero];
    showView.showText = text ;
    showView.showTextStatus = status ;
    showView.showImage = image ;
    showView.showType = showType ;
    
    showView.showTime = 1 + text.length*0.15 ;
    if (showView.showTime > [EasyShowOptions sharedEasyShowOptions].maxShowTime) {
        showView.showTime = [EasyShowOptions sharedEasyShowOptions].maxShowTime ;
    }
    if (showView.showTime < 2) {
        showView.showTime = 2 ;
    }
    
    showView.timerShowTime = 0 ;
    [showView showViewWithSuperView:view];
}

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
    CGRect showFrame = CGRectZero ;
    if (self.showType == ShowTypeText) {
        showFrame = [self showTextRectWithSuperView:superView];
    }
    else if(self.showType == ShowTypeLoding){
        showFrame = [self showLodingRectWithSuperView:superView];
    }
    
    
    self.showBgView = [[EasyShowBgView alloc]initWithFrame:showFrame
                                                    status:self.showTextStatus
                                                      text:self.showText
                                                     image:self.showImage
                                                  showtype:self.showType];
    [self addSubview:self.showBgView];
    //只有展示文字的时候，才需要自动消失
    if (self.showType == ShowTypeText) {
        [self.removeTimer fire];
    }
    
    [self showSelfToSuperView:superView];
    
    if (self.options.showShadow) {
        CGFloat afterStart = self.options.showStartAnimation ? self.options.showAnimationTime :0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterStart * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showBackgrouldsubLayer];
        });
    }
}

- (CGRect)showLodingRectWithSuperView:(UIView *)superView
{
    
    //显示图片的高度。
    CGFloat imageH = self.showTextStatus==ShowTextStatusPureText ?:(EasyDrawImageWH + EasyDrawImageEdge) ;
    
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
    
    if (self.options.showLodingType > ShowLodingTypeImage) {//左右形式
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
    CGRect showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
    if (self.options.superViewReceiveEvent) {
        //父视图能接受事件--> self的大小为显示区域的大小
        self.frame =  CGRectMake((SCREEN_WIDTH-backGroundW)/2, showFrameY, backGroundW, backGroundH);
    }
    else{
        
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        self.frame = CGRectMake(0, 0, superView.width, superView.height) ;
        
        showFrame.origin = CGPointMake((self.width-backGroundW)/2, showFrameY) ;
    }
    return showFrame ;
}
//获取需要展示框的大小
- (CGRect)showTextRectWithSuperView:(UIView *)superView
{
    //显示图片的高度。
    CGFloat imageH = self.showTextStatus==ShowTextStatusPureText ?:(EasyDrawImageWH + EasyDrawImageEdge) ;
    
    //显示区域的宽高
    CGFloat backGroundH = 0 ;
    CGFloat backGroundW = SCREEN_WIDTH ;
    switch (self.options.textStatusType) {
        case ShowTextStatusTypeStatusBar://如果是在statusbar上，则高固定，不需要计算
            backGroundH = STATUSBAR_HEIGHT ;
            break;
        case ShowTextStatusTypeNavigation:
            backGroundH = NAVIGATION_HEIGHT ;
            break ;
        default:{
            CGSize textSize = CGSizeZero ;
            if (!ISEMPTY(self.showText)) {
                textSize = [EasyShowUtils textWidthWithStirng:self.showText
                                                         font:self.options.textFount
                                                     maxWidth:self.options.maxWidthScale*SCREEN_WIDTH];
            }
            backGroundH = (textSize.height?(textSize.height+30):0) + imageH ;
            backGroundW = textSize.width?(textSize.width+40):0  ;
            
            if (backGroundW < EasyShowViewMinWidth) {
                backGroundW = EasyShowViewMinWidth  ;
            }
        } break;
    }
    
    //显示区域的y值
    CGFloat showFrameY = (SCREEN_HEIGHT-backGroundH)/2  ;//默认显示在中间
    //    if (self.showTextStatus != ShowStatusLoding) {
    switch (self.options.textStatusType ) {
        case ShowTextStatusTypeNavigation:
        case ShowTextStatusTypeStatusBar:
            showFrameY = 0 ;
            break ;
        case ShowTextStatusTypeTop:
            showFrameY = NAVIGATION_HEIGHT + EasyTextShowEdge ;
            break;
        case ShowTextStatusTypeBottom:
            showFrameY = SCREEN_HEIGHT - backGroundH - EasyTextShowEdge ;
            break ;
        default: break;
    }
    //    }
    
    
    //显示区域的frame
    CGRect showFrame = CGRectMake(0, 0, backGroundW, backGroundH);
    
    if (self.options.superViewReceiveEvent) {
        
        //父视图能接受事件--> self的大小为显示区域的大小
        self.frame =  CGRectMake((SCREEN_WIDTH-backGroundW)/2, showFrameY, backGroundW, backGroundH);
    }
    else{
        
        //父视图不能接收-->self的大小应该为superview的大小。来遮盖
        self.frame = CGRectMake(0, 0, superView.width, superView.height) ;
        
        showFrame.origin = CGPointMake((self.width-backGroundW)/2, showFrameY) ;
    }
    
    return showFrame ;
}

- (void)timerAction
{
    if (_timerShowTime >= _showTime ) {
        
        //移除定时器
        _timerShowTime = 0 ;
        if (_removeTimer) {
            [_removeTimer invalidate];
            _removeTimer = nil ;
        }
        
        //移除阴影
        if (self.options.showShadow) {
            [self hiddenBackgrouldsubLayer];
        }
        
        //移除自己
        [self removeSelfFromSuperView];
    }
    _timerShowTime++ ;
    
}

- (void)clearCurrentShow
{
    _timerShowTime = [EasyShowOptions sharedEasyShowOptions].maxShowTime + 1 ;
    [self timerAction];
}
- (void)showSelfToSuperView:(UIView *)superView
{
    if (self.options.showStartAnimation) {
        
        if (self.showType==ShowTypeText && (self.isShowedStatusBar || self.isShowedNavigation)) {
            self.y = - self.height ;
            [UIView animateWithDuration:self.options.showAnimationTime animations:^{
                self.y = 0 ;
                [self.showBgView showWindowYToPoint:0];
            }] ;
        }
        else{
            [self.showBgView showStartAnimationWithDuration:self.options.showAnimationTime];
        }
        
        [superView addSubview:self];
        
    }
    else{
        if (self.showType==ShowTypeText && (self.isShowedStatusBar || self.isShowedNavigation)) {
            self.y = 0 ;
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
}
- (void)removeSelfFromSuperView
{
    if (self.options.showEndAnimation) {
        
        if (self.showType==ShowTypeText && (self.isShowedStatusBar || self.isShowedNavigation)) {
            
            [UIView animateWithDuration:self.options.showAnimationTime animations:^{
                self.y = -self.height ;
                [self.showBgView showWindowYToPoint:-self.height ];
                NSLog(@"========= %.2f",self.y);
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }] ;
        }
        else{
            [self.showBgView showEndAnimationWithDuration:self.options.showAnimationTime];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.options.showAnimationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
            });
        }
    }
    else{
        [UIView animateWithDuration:self.options.showAnimationTime animations:^{
            self.alpha = 0.1 ;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }] ;
    }
}
- (void)showBackgrouldsubLayer
{
    CALayer *addSubLayer=[CALayer layer];
    addSubLayer.frame= self.showBgView.frame;
    addSubLayer.cornerRadius=8;
    addSubLayer.backgroundColor=self.options.backGroundColor.CGColor;
    addSubLayer.masksToBounds=NO;
    addSubLayer.name = @"backgrouldsubLayer";
    addSubLayer.shadowColor = self.options.shadowColor.CGColor;
    addSubLayer.shadowOffset = CGSizeMake(0.5, 2);
    addSubLayer.shadowOpacity = 0.6;
    addSubLayer.shadowRadius = 4;
    [self.layer insertSublayer:addSubLayer below:self.showBgView.layer];
    
}
- (void)hiddenBackgrouldsubLayer
{
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer.name isEqualToString:@"backgrouldsubLayer"]) {
            [subLayer removeFromSuperlayer];
            break ;
        }
    }
}

#pragma mark - getter
//是否显示在statusbar上
- (BOOL)isShowedStatusBar
{
    return self.options.textStatusType==ShowTextStatusTypeStatusBar ;
}
//是否正在显示在navigation上
- (BOOL)isShowedNavigation
{
    return self.options.textStatusType==ShowTextStatusTypeNavigation ;
}
- (EasyShowOptions *)options
{
    if (nil == _options) {
        _options = [EasyShowOptions sharedEasyShowOptions];
    }
    return _options ;
}

- (NSTimer *)removeTimer
{
    if (nil == _removeTimer) {
        _removeTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_removeTimer forMode:NSRunLoopCommonModes];
    }
    return _removeTimer ;
}

@end















