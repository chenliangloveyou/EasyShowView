# EasyShowView 
  一款非常简单的展示工具。提示框，加载框，alert弹出框。一行代码搞定所有操作。
  
 
# PreView

![github](https://github.com/chenliangloveyou/EasyShowView/blob/master/show_preview/preview_text.gif "github")![github](https://github.com/chenliangloveyou/EasyShowView/blob/master/show_preview/preview_loding.gif "github")![github](https://github.com/chenliangloveyou/EasyShowView/blob/master/show_preview/preview_alert.gif "github")  


# 使用方法

## 一、提示框


_显示一个纯文字消息_

 ```
+ (void)showText:(NSString *)text ;
+ (void)showText:(NSString *)text inView:(UIView *)view ;//这个view为父视图如果不传将会加载window上。显示时间的长短根据text的长度计算的。
```
_显示一个成功消息_
```
+ (void)showSuccessText:(NSString *)text ;
+ (void)showSuccessText:(NSString *)text inView:(UIView *)view ;//view和上面介绍的一样
```
_显示一个错误消息_
```
+ (void)showErrorText:(NSString *)text ;
+ (void)showErrorText:(NSString *)text inView:(UIView *)superView ;
```
_显示一个提示消息_
```
+ (void)showInfoText:(NSString *)text ;
+ (void)showInfoText:(NSString *)text inView:(UIView *)superView ;
```
_显示一个自定义图片消息_
```
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName ;
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName inView:(UIView *)superView ;
```

#### 自定义样式(可略)

最好在APPdelegate里设置一次(整个APP应该统一风格)。
 ```
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   EasyShowOptions *options = [EasyShowOptions sharedEasyShowOptions];
    
  //在展示消息的时候，界面上是否可以事件。默认为YES，如果你想在展示消息的时候不让用户有手势交互，可设为NO
  options.textSuperViewReceiveEvent = NO ;

  //显示/隐藏的动画形式。有无动画，渐变，抖动，三种样式。
  options.textAnimationType = TextAnimationTypeFade ;

  //提示框所在的位置。有上，中，下，状态栏上，导航条上，五种选择。
  options.textStatusType = ShowTextStatusTypeMidden ；

  //文字大小
  options.textTitleFount = [UIFont systemFontOfSize:15] ;
  //文字颜色
  options.textTitleColor = [UIColor whiteColor] ;
  //背景颜色
  options.textBackGroundColor = [UIColor blackColor];
  //阴影颜色。(为clearcolor的时候不显示阴影)
  options.textShadowColor = [UIColor blueColor];

  return YES ;
}
```




## 二、加载框

_显示加载框_
```
/**
 * 显示一个加载框
 * text:需要显示加载框的字体
 * imageName：需要显示加载框的图片名称
 * superview:加载框所需要的父视图（如果不传会放到window和topviewcontroller上面，在EasyShowOptions里指定）
 */
+ (void)showLoding ;
+ (void)showLodingText:(NSString *)text ;
+ (void)showLodingText:(NSString *)text inView:(UIView *)superView ;
+ (void)showLodingText:(NSString *)text imageName:(NSString *)imageName ;
+ (void)showLodingText:(NSString *)text imageName:(NSString *)imageName inView:(UIView *)superView ;

```
_隐藏加载框_
```
/**
 * 移除一个加载框
 * uperview:加载框所在的父视图。show的时候没有指定父视图。那么隐藏的时候也不用
 */
+ (void)hidenLoding ;
+ (void)hidenLoingInView:(UIView *)superView ;

```

#### 自定义样式(可略)
最好在APPdelegate里设置一次。与上面的提示框一起设置
```
  //在展示消息的时候，界面上是否可以事件。默认为YES，如果你想在展示消息的时候不让用户有手势交互，可设为NO
  options.lodingSuperViewReceiveEvent = NO ;

  //加载框的样式。在这个枚举中一共有10中样式。如果是显示图片加载，那么加载框的大小会根据图片的大小调整。__☺☺试试把图片传很小，不显示文字，背景为透明色是什么效果☺☺__
  options.lodingShowType = LodingShowTypeTurnAround ;

  //显示/隐藏的动画形式。有无动画，渐变，抖动，三种样式。
  options.lodingAnimationType = LodingAnimationTypeFade ;

  //文字大小
  options.lodingTextFount = [UIFont systemFontOfSize:15];
  //主体颜色(包括图片，文字颜色)
  options.lodingTintColor = [UIColor blackColor];
  //背景颜色，试试传透明色是什么效果
  options.lodingBackgroundColor = [UIColor lightGrayColor];
  //当不传superView的时候，父视图默认有window和最上面的控制器。这里设置是否显示在wind上
  options.lodingShowOnWindow = NO ;
  //圆角大小
  options.lodingCycleCornerWidth = 5 ;
  
```

## 三、AlertView/ActionSheet弹出框

#### 一：自定义形式

_第一步_
创建一个弹出框
```
//创建AlertView
+ (instancetype)showAlertWithTitle:(NSString *)title
                           message:(NSString *)message ;
//ActionSheet
+ (instancetype)showActionSheetWithTitle:(NSString *)title
                                 message:(NSString *)message ;
```
_第二步_ 往弹出框上添加事件
```
- (void)addItemWithTitle:(NSString *)title
                itemType:(ShowAlertItemType)itemType
                callback:(alertItemCallback)callback;
```
_第三步_ 展示弹出框(不可少)
```
- (void)show ;
```
#### 二：系统形式
与自定义的形式。把show后面加一个system。可参考实例。

#### 自定义样式(可略)
最好在APPdelegate里设置一次。与上面的提示框一起设置
```
/**
 *alertview的背景颜色。
 * title/message的字体颜色
 */
@property (nonatomic,strong)UIColor *alertTintColor ;
@property (nonatomic,strong)UIColor *alertTitleColor ;
@property (nonatomic,strong)UIColor *alertMessageColor ;

/**
 * alertView:是两个按钮的时候 横着摆放
 */
@property (nonatomic,assign)BOOL alertTowItemHorizontal ;

/**
 * alertView:展示和消失的动画类型。
 * 当展示的是系统alertview和ActionSheet不起作用
 */
@property (nonatomic,assign)alertAnimationType alertAnimationType ;

/**
 * 点击alertview之外的空白区域，是否销毁alertview。默认为:NO
 *
 * 系统的alert        不可以点击销毁。
 * 系统的ActionSheet  添加UIAlertActionStyleCancel类型就会有点击销毁。没有就不会销毁。
 */
@property (nonatomic,assign)BOOL alertBgViewTapRemove ;
```












