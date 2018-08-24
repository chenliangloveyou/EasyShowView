//
//  EasyEmptyView.m
//  EasyShowViewDemo
//
//  Created by nf on 2018/1/16.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyEmptyView.h"

#import "EasyEmptyGlobalConfig.h"
#import "EasyShowUtils.h"
#import "EasyShowLabel.h"
#import "UIView+EasyShowExt.h"

@interface EasyEmptyView()

@property (nonatomic,strong)EasyEmptyPart *emptyItem ;
@property (nonatomic,strong)EasyEmptyConfig *emptyConfig ;
@property (nonatomic,strong)emptyViewCallback callback ;

@property (nonatomic,strong)UIView *bgContentView ;
@property (nonatomic,strong)UILabel *defaultTitleLabel ;
@property (nonatomic,strong)UILabel *defaultSubTitleLabel ;
@property (nonatomic,strong)UIImageView *defaultImageView ;

@end

@implementation EasyEmptyView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}
- (instancetype)initWithConfig:(EasyEmptyConfig *)config
{
    if (self = [super init]) {
        
        _emptyConfig = config ;

        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
        self.backgroundColor = config.bgColor ;
        self.alwaysBounceVertical = config.scrollVerticalEnable ;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarChangeNoti:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self ;
}
- (void)statusBarChangeNoti:(NSNotification *)notifycation
{
    [self layoutemptyViewSubviews];
}

- (void)layoutemptyViewSubviews
{
    CGFloat contentWidth = [self bgViewWidth];//bgcontentview的高度
    __block CGFloat contentHeight = 0 ;//计算bgcontentview的高度
    if (!ISEMPTY_S(self.emptyItem.imageName)) {
        UIImage *defaultImage = [UIImage imageNamed:self.emptyItem.imageName];
        CGSize imageSize = defaultImage.size ;
        if (imageSize.width > contentWidth*2/3.0f) {
            imageSize.height = (imageSize.height*(contentWidth*2/3.0f))/imageSize.width ;
            imageSize.width=  contentWidth*2/3.0f ;
        }
        self.defaultImageView.frame = CGRectMake((contentWidth-imageSize.width)/2.0f, contentHeight, imageSize.width, imageSize.height) ;
        contentHeight += imageSize.height+10 ;
    }
    
    if (!ISEMPTY_S(self.emptyItem.title)) {
        CGSize titleSize = [self.defaultTitleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.defaultTitleLabel.frame = CGRectMake(0, contentHeight, contentWidth, titleSize.height);
        
        contentHeight += self.defaultTitleLabel.easyS_height ;
    }
    
    if (!ISEMPTY_S(self.emptyItem.subtitle)) {
        CGSize titleSize = [self.defaultSubTitleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.defaultSubTitleLabel.frame = CGRectMake(0, contentHeight, contentWidth, titleSize.height);
        
        contentHeight += self.defaultSubTitleLabel.easyS_height ;
    }
    
    __weak typeof(NSArray *) weakButtonArray = self.emptyItem.buttonArray ;
    [self.bgContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            CGRect buttonFrame = obj.frame ;
            buttonFrame.origin.y = contentHeight+10 ;
            
            CGFloat buttonX = (contentWidth-obj.easyS_width)/2;
            if (weakButtonArray.count == 2) {
                buttonX = (contentWidth/2-obj.easyS_width)/2 + ((obj.tag==2)?(contentWidth/2):0)  ;
            }
            buttonFrame.origin.x =buttonX ;
            [obj setFrame:buttonFrame];
            
            if (weakButtonArray.count==1 || (weakButtonArray.count==2&&obj.tag==2)) {
                contentHeight += buttonFrame.size.height+10 ;
            }
        }
    }] ;
    
    self.bgContentView.frame = CGRectMake((self.easyS_width-contentWidth)/2, (self.easyS_height-contentHeight)/2, contentWidth, contentHeight) ;
    
}
- (void)showView
{
    if (self.callback) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClick:)];
        [self addGestureRecognizer:tapGesture];
    }
    [self addSubview:self.bgContentView];
    
    if (!ISEMPTY_S(self.emptyItem.imageName)) {
        self.defaultImageView.image = [UIImage imageNamed:self.emptyItem.imageName] ;
    }
    
    if (!ISEMPTY_S(self.emptyItem.title)) {
        self.defaultTitleLabel.text = self.emptyItem.title ;
    }
    
    if (!ISEMPTY_S(self.emptyItem.subtitle)) {
        self.defaultSubTitleLabel.text = self.emptyItem.subtitle ;
    }
    
    for (int i = 0 ; i < self.emptyItem.buttonArray.count; i++) {
        UIButton *button = [self defaultButtonWithIndex:i contentWidth:[self bgViewWidth]] ;
        [self.bgContentView addSubview:button];
    }
    
    [self layoutemptyViewSubviews];
    
    self.alpha = 0.2 ;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1 ;
    }] ;
    
}

- (UIButton *)defaultButtonWithIndex:(long)index contentWidth:(CGFloat)contentWidth
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:self.emptyConfig.buttonColor forState:UIControlStateNormal];
    [button setTitleColor:[self.emptyConfig.buttonColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    UIImage *bgNormalImg = [EasyShowUtils imageWithColor:self.emptyConfig.buttonBgColor] ;
    [button setBackgroundImage:bgNormalImg forState:UIControlStateNormal];
    UIImage *bgHightImg = [EasyShowUtils imageWithColor:[self.emptyConfig.buttonBgColor colorWithAlphaComponent:0.5f]] ;
    [button setBackgroundImage:bgHightImg forState:UIControlStateHighlighted];
    button.titleLabel.numberOfLines = 0 ;
    [button setTitleEdgeInsets:self.emptyConfig.buttonEdgeInsets];
    button.titleLabel.font = self.emptyConfig.buttonFont ;
    [button setTag:index+1];
    
    NSString *titleString = self.emptyItem.buttonArray[index];
    CGFloat buttonMaxWidth = contentWidth/self.emptyItem.buttonArray.count - self.emptyConfig.buttonEdgeInsets.left - self.emptyConfig.buttonEdgeInsets.right ;
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:titleString attributes:nil];
    [astr setAttributes:@{NSFontAttributeName:button.titleLabel.font} range:NSMakeRange(0, titleString.length)];
    CGSize buttonSize = [astr boundingRectWithSize:CGSizeMake(buttonMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    buttonSize = CGSizeMake(buttonSize.width+self.emptyConfig.buttonEdgeInsets.left + self.emptyConfig.buttonEdgeInsets.right, buttonSize.height+self.emptyConfig.buttonEdgeInsets.top+self.emptyConfig.buttonEdgeInsets.bottom) ;
    [button setFrame:CGRectMake(0, 0, buttonSize.width, buttonSize.height)];
    [button  setRoundedCorners:4];
    
    [button setTitle:titleString forState:UIControlStateNormal];
    
    return button ;
}
- (void)buttonClick:(UIButton *)button
{
    [EasyEmptyView hiddenEmptyView:self];
    
    if (self.callback) {
        if ([button isKindOfClass:[UIButton class]]) {
            self.callback(self, button, button.tag) ;
            return ;
        }
        self.callback(self, nil, callbackTypeBgView);
    }
}


#pragma mark - getter


- (CGFloat)bgViewWidth
{
    CGFloat contentWidth = self.easyS_width*0.7 ;//计算bgcontentview的宽度
    if (contentWidth < 200) {    //如果superview的宽度小于200 就应该是全部宽度
        contentWidth = self.easyS_width ;
    }
    return contentWidth ;
}

- (UIView *)bgContentView
{
    if (nil == _bgContentView) {
        _bgContentView = [[UIView alloc]init];
        _bgContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
        _bgContentView.backgroundColor = kColorRandom_S ;
    }
    return _bgContentView ;
}

- (UIImageView *)defaultImageView
{
    if (nil == _defaultImageView) {
        _defaultImageView = [[UIImageView alloc]init];
        _defaultImageView.backgroundColor = kColorRandom_S ;
        [self.bgContentView addSubview:_defaultImageView];
    }
    return _defaultImageView ;
}
- (UILabel *)defaultSubTitleLabel
{
    if (nil == _defaultSubTitleLabel) {
        _defaultSubTitleLabel =  [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(10, 20, 10, 20)];
        _defaultSubTitleLabel.textColor = self.emptyConfig.subTitleColor ;
        _defaultSubTitleLabel.font = self.emptyConfig.subtitleFont ;
        _defaultSubTitleLabel.numberOfLines = 0 ;
        _defaultSubTitleLabel.textAlignment = NSTextAlignmentCenter ;
        _defaultSubTitleLabel.backgroundColor = kColorRandom_S ;
        [self.bgContentView addSubview:_defaultSubTitleLabel];
    }
    return _defaultSubTitleLabel ;
}
- (UILabel *)defaultTitleLabel
{
    if (nil == _defaultTitleLabel) {
        _defaultTitleLabel = [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(10, 30, 10, 30)];;
        _defaultTitleLabel.textColor = self.emptyConfig.titleColor ;
        _defaultTitleLabel.font = self.emptyConfig.tittleFont ;
        _defaultTitleLabel.numberOfLines = 0 ;
        _defaultTitleLabel.backgroundColor = kColorRandom_S ;
        _defaultTitleLabel.textAlignment = NSTextAlignmentCenter ;
        [self.bgContentView addSubview:_defaultTitleLabel];
    }
    return _defaultTitleLabel ;
}

#pragma mark - 类方法

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                              part:(EasyEmptyPart *(^)(void))part
{
    return [self showEmptyInView:superview part:part config:nil];
}

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                              part:(EasyEmptyPart *(^)(void))part
                            config:(EasyEmptyConfig *(^)(void))config
{
    return [self showEmptyInView:superview part:part config:config callback:nil];
}

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                   part:(EasyEmptyPart *(^)(void))part
                 config:(EasyEmptyConfig *(^)(void))config
               callback:(emptyViewCallback)callback
{
    
    EasyEmptyConfig *emptyConfig = [self changeConfigWithConfig:config] ;
    EasyEmptyPart   *emptyItem = part() ;
    
    NSAssert(emptyItem.buttonArray.count<3, @"you can't set more than two button") ;
    
    EasyEmptyView *emptyView = [[EasyEmptyView alloc]initWithConfig:emptyConfig];
    emptyView.emptyItem =emptyItem ;
    emptyView.callback = callback ;
    
    UIEdgeInsets edge = emptyConfig.easyViewEdgeInsets ;
    CGFloat viewW = superview.easyS_width-edge.left-edge.right ;
    CGFloat viewH = superview.easyS_height-edge.top-edge.bottom ;
    [emptyView setFrame:CGRectMake(edge.left, edge.top, viewW,viewH )] ;
    
    [superview addSubview:emptyView] ;
    
    [emptyView showView];
    
    return emptyView ;
}


+ (void)hiddenEmptyView:(EasyEmptyView *)emptyView
{
    [UIView animateWithDuration:.3 animations:^{
        emptyView.alpha = 0.2 ;
    } completion:^(BOOL finished) {
        [emptyView removeFromSuperview];
    }] ;
}
+ (void)hiddenEmptyInView:(UIView *)superView
{
    
    NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
        });
    }
    
    NSEnumerator *subviewsEnum = [superView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            EasyEmptyView *emptyView = (EasyEmptyView *)subview ;
            [self hiddenEmptyView:emptyView];
        }
    }
}

+ (EasyEmptyConfig *)changeConfigWithConfig:(EasyEmptyConfig *(^)(void))config
{
    EasyEmptyConfig *tempConfig = config ? config() : nil ;
    if (!tempConfig) {
        tempConfig = [EasyEmptyConfig shared] ;
    }
    
    EasyEmptyGlobalConfig *globalConfig = [EasyEmptyGlobalConfig shared];
   
    if (!tempConfig.bgColor) {
        tempConfig.bgColor = globalConfig.bgColor  ;
    }
    if (!tempConfig.tittleFont) {
        tempConfig.tittleFont =globalConfig.tittleFont;
    }
    if (!tempConfig.titleColor) {
        tempConfig.titleColor =  globalConfig.titleColor ;
    }
    if (!tempConfig.subtitleFont) {
        tempConfig.subtitleFont = globalConfig.subtitleFont;
    }
    if (!tempConfig.subTitleColor) {
        tempConfig.subTitleColor = globalConfig.subTitleColor ;
    }
    if (!tempConfig.buttonFont) {
        tempConfig.buttonFont =  globalConfig.buttonFont ;
    }
    if (!tempConfig.buttonColor) {
        tempConfig.buttonColor = globalConfig.buttonColor;
    }
    if (!tempConfig.buttonBgColor) {
        tempConfig.buttonBgColor = globalConfig.buttonBgColor;
    }
    
    if (tempConfig.buttonEdgeInsets.top==0 && tempConfig.buttonEdgeInsets.left==0
    && tempConfig.buttonEdgeInsets.bottom==0 && tempConfig.buttonEdgeInsets.right==0 ) {
        tempConfig.buttonEdgeInsets = globalConfig.buttonEdgeInsets ;
    }
    return tempConfig ;
}

//+ (void)showEmptyViewLoadingWithImageName:(NSString *)imageName
//                                callback:(emptyViewCallback)callback
//{
//}
//
//+ (void)showEmptyViewLoadingWithTitle:(NSString *)title
//                            callback:(emptyViewCallback)callback
//{
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
