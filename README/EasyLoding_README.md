## EasyText使用方法

<br> 

#### 在AppDelegate中设置全局的配置信息 -- (可省略) 
 
```
#import "EasyTextGlobalConfig.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
     /**显示加载框**/
    EasyLodingGlobalConfig *lodingConfig = [EasyLodingGlobalConfig shared];
    lodingConfig.lodingType = LodingAnimationTypeFade ;
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:8];
    for (int i = 0; i < 9; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"icon_hud_%d",i+1]];
        [tempArr addObject:img] ;
    }
    lodingConfig.playImagesArray = tempArr ;
 }
```

<br> 

#### 调用显示方法 --（如果单独某个显示视图不想用全局的配置信息，可以在每个显示方法中的config配置）

 ```
/**
 * 显示一个加载框（config：显示属性设置）
 */
+ (EasyLodingView *)showLoding ;
+ (EasyLodingView *)showLodingText:(NSString *)text ;
+ (EasyLodingView *)showLodingText:(NSString *)text
                            config:(EasyLodingConfig *(^)(void))config ;

```


```
/**
 * 显示一个带图片的加载框 （config：显示属性设置）
 */
+ (EasyLodingView *)showLodingText:(NSString *)text
                         imageName:(NSString *)imageName ;
+ (EasyLodingView *)showLodingText:(NSString *)text
                         imageName:(NSString *)imageName
                            config:(EasyLodingConfig *(^)(void))config ;

```

```
/**
 * 移除一个加载框
 * superview:加载框所在的父视图。(如果show没指定父视图。那么隐藏也不用)
 */
+ (void)hidenLoding ;
+ (void)hidenLoingInView:(UIView *)superView ;
+ (void)hidenLoding:(EasyLodingView *)lodingView ;


```

<br>  

#### 举例说明

__显示lodingview__
```
//没有加配置信息，所以显示的样式都会使用appdelegate中EasyTextGlobalConfig设置的。
[EasyLodingView showLodingText:@"加载中..."];

//增加config配置信息。那么statusType属性会使用刚设置的。其他属性会继续使用EasyTextGlobalConfig设置的。
 [EasyLodingView showLodingText:@"正在努力加载中..." config:^EasyLodingConfig *{
       return [EasyLodingConfig shared].setLodingType(LodingShowTypeIndicatorLeft);
 }];

```
__隐藏lodingview__
```
 //会移除window或者是topviewcontroller上所有的lidngview
 [EasyLodingView hidenLoding];

 //移除特定的lodingview
 [EasyLodingView hidenLoding:lodingV];

```
<br> 

 #### EasyLodingConfig：它是显示属性的配置信息。提供了三种方法。这三种方法都是一样的，根据使用习惯选择一种就行。
```
  
  //方法一
   return [EasyLodingConfig configInView:self.view showType:LodingShowTypePlayImagesLeft];
  
  //方法二
  return [EasyLodingConfig shared].setLodingType(LodingShowTypePlayImagesLeft).setSuperReceiveEvent(NO);

  //方法三
  EasyLodingConfig *config = [EasyLodingConfig shared];
  config.lodingType = LodingShowTypePlayImagesLeft ;
  config.superView  = self.view ;
  return config ;
```


