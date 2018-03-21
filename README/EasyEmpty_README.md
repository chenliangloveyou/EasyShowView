## EasyEmptyView使用方法

<br> 


#### 在AppDelegate中设置全局的配置信息 -- (可省略) 
 
```
#import "EasyEmptyGlobalConfig.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
    /**显示空白页面**/
    EasyEmptyGlobalConfig  *emptyConfig = [EasyEmptyGlobalConfig shared];
    emptyConfig.bgColor = [UIColor groupTableViewBackgroundColor];
   
   return YES; 
 }
```

<br> 


#### 调用显示方法 --（如果单独某个显示视图不想用全局的配置信息，可以在每个显示方法中的config配置）

 ```
+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                   item:(EasyEmptyPart *(^)(void))item ;

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                   item:(EasyEmptyPart *(^)(void))item
                 config:(EasyEmptyConfig *(^)(void))config ;

+ (EasyEmptyView *)showEmptyInView:(UIView *)superview
                   item:(EasyEmptyPart *(^)(void))item
                 config:(EasyEmptyConfig *(^)(void))config
               callback:(emptyViewCallback)callback ;
               
```

```
+ (void)hiddenEmptyInView:(UIView *)superView ;
+ (void)hiddenEmptyView:(EasyEmptyView *)emptyView ;
```


<br> 


#### 举例说明
```
[EasyEmptyView showEmptyInView:self.view item:^EasyEmptyPart *{
                return [EasyEmptyPart shared].setTitle(@"网络连接已断开").setImageName(@"netError.png") ;
            } config:^EasyEmptyConfig *{
                return [EasyEmptyConfig shared].setTitleColor([UIColor redColor]).setScrollVerticalEnable(NO);
            } callback:^(EasyEmptyView *view, UIButton *button, callbackType callbackType) {
                [EasyEmptyView hiddenEmptyInView:self.view];
            }];
```

<br> 


 #### EasyEmptyPart：empty所需要系那是的字视图，根据自己都需要选择
```
 @property (nonatomic,strong)NSString *title ;                 //标题
@property (nonatomic,strong)NSString *subtitle ;              //副标题
@property (nonatomic,strong)NSString *imageName ;             //图片名称
@property (nonatomic,strong)NSArray<NSString *> *buttonArray ;//下面需要的按钮
```

<br> 


 #### EasyEmptyConfig：它是显示属性的配置信息。提供了三种方法。这三种方法都是一样的，根据使用习惯选择一种就行。

```
@property (nonatomic,strong)UIColor *bgColor ;   //背景颜色

@property (nonatomic,strong)UIFont  *tittleFont ; //标题字体大小
@property (nonatomic,strong)UIColor *titleColor ;//标题字体颜色

@property (nonatomic,strong)UIFont  *subtitleFont ;  //副标题字体大小
@property (nonatomic,strong)UIColor *subTitleColor ;//副标题字体颜色

@property (nonatomic,strong)UIFont  *buttonFont ;    //按钮字体大小
@property (nonatomic,strong)UIColor *buttonColor ;  //按钮字体亚瑟
@property (nonatomic,strong)UIColor *buttonBgColor ;//按钮背景颜色

@property (nonatomic,assign)UIEdgeInsets easyViewEdgeInsets ;//整个emptyview往内缩的距离(如果为负数，则会超出边界)
@property (nonatomic,assign)UIEdgeInsets buttonEdgeInsets ; //按钮往内缩的边距（按钮四边边缘距离文字的距离）
@property (nonatomic,assign)BOOL scrollVerticalEnable ;//是否可以上下滚动
```


