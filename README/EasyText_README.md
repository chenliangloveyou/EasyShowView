## EasyText使用方法

 .
#### 在AppDelegate中设置全局的配置信息 -- (可省略) 
 
```
#import "EasyTextGlobalConfig.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
    /**显示文字**/
    EasyTextGlobalConfig *config = [EasyTextGlobalConfig shared];
    config.bgColor = [UIColor whiteColor];
    config.titleColor = [UIColor blackColor];
 }
```

 .
#### 调用显示方法 --（如果单独某个显示视图不想用全局的配置信息，可以在每个显示方法中的config配置）

 ```
/**
 * 显示一个纯文字消息 （config：显示属性设置）
 */
+ (void)showText:(NSString *)text ;
+ (void)showText:(NSString *)text config:(EasyTextConfig *(^)(void))config ;
```


```
/**
 * 显示一个成功消息（config：显示属性设置）
 */
+ (void)showSuccessText:(NSString *)text ;
+ (void)showSuccessText:(NSString *)text config:(EasyTextConfig *(^)(void))config ;

```

```
/**
 * 显示一个错误消息（config：显示属性设置）
 */
+ (void)showErrorText:(NSString *)text ;
+ (void)showErrorText:(NSString *)text config:(EasyTextConfig *(^)(void))config ;

```

```
/**
 * 显示一个提示消息（config：显示属性设置）
 */
+ (void)showInfoText:(NSString *)text ;
+ (void)showInfoText:(NSString *)text config:(EasyTextConfig *(^)(void))config ;

```

```
/**
 * 显示一个自定义图片消息（config：显示属性设置）
 */
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName ;
+ (void)showImageText:(NSString *)text imageName:(NSString *)imageName config:(EasyTextConfig *(^)(void))config ;

```

 .
#### 举例说明
```
//没有加配置信息，所以显示的样式都会使用appdelegate中EasyTextGlobalConfig设置的。
[EasyTextView showSuccessText:@"显示成功消息!"];

//增加config配置信息。那么statusType属性会使用刚设置的。其他属性会继续使用EasyTextGlobalConfig设置的。
[EasyTextView showErrorText:@"服务器错误！" config:^EasyTextConfig *{
        return [EasyTextConfig shared].setStatusType(TextStatusTypeNavigation) ;
}];

```

 .
 #### EasyTextConfig说明：它是显示属性的配置信息。提供了三种方法。这三种方法都是一样的，根据使用习惯选择一种就行。
```
  //方法一
  return [EasyTextConfig configWithSuperView:self.view superReceiveEvent:ShowTextEventUndefine animationType:TextAnimationTypeNone textStatusType:TextStatusTypeBottom];
  //方法二
   return [EasyTextConfig shared].setBgColor([UIColor lightGrayColor]).setShadowColor([UIColor clearColor]).setStatusType(TextStatusTypeBottom);
   //方法三
  EasyTextConfig *config = [EasyTextConfig shared];
  config.bgColor = [UIColor lightGrayColor] ;
  config.shadowColor = [UIColor clearColor] ;
  config.animationType = TextAnimationTypeFade;
  config.statusType = TextStatusTypeBottom ;
  return config ;
```



