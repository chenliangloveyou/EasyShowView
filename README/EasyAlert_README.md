## EasyAlert使用方法

#### 在AppDelegate中设置全局的配置信息 -- (可省略) 
 
```
#import "EasyTextGlobalConfig.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
   /**显示alert**/
    EasyAlertGlobalConfig *alertConfig = [EasyAlertGlobalConfig shared];
    alertConfig.titleColor = [UIColor blackColor];
 }
```

#### 调用显示方法 --（如果单独某个显示视图不想用全局的配置信息，可以在每个显示方法中的config配置）

 ```

/**
 *  快速创建AlertView的方法 
 *
 * part        alertView的组成部分 标题，副标题，显示类型
 * config      配置信息（如果为空，就是使用EasyAlertGlobalConfig中的属性值）
 * buttonArray 所以需要显示的按钮
 * callback    点击按钮回调
 */
+ (EasyAlertView *)alertViewWithPart:(EasyAlertPart *(^)(void))part
                              config:(EasyAlertConfig *(^)(void))config
                         buttonArray:(NSArray<NSString *> *(^)(void))buttonArray
                            callback:(AlertCallback)callback ;

```


```
/**
 * 第一步：创建一个自定义的Alert/ActionSheet
 */
+ (instancetype)alertViewWithTitle:(NSString *)title
                          subtitle:(NSString *)subtitle
                     AlertViewType:(AlertViewType)alertType
                            config:(EasyAlertConfig *(^)(void))config  ;

+ (instancetype)alertViewWithPart:(EasyAlertPart *(^)(void))part
                           config:(EasyAlertConfig *(^)(void))config
                         callback:(AlertCallback)callback ;

/**
 * 第二步：往创建的alert上面添加事件
 */
- (void)addAlertItemWithTitle:(NSString *)title
                         type:(AlertItemType)type
                     callback:(AlertCallback)callback;
- (void)addAlertItem:(EasyAlertItem *(^)(void))item ;
- (void)addAlertItemWithTitleArray:(NSArray *)titleArray
                          callback:(AlertCallback)callbck ;

/**
 * 第三步：展示alert
 */
- (void)showAlertView ;
```

```

// 移除alertview
- (void)removeAlertView ;

```

#### 举例说明 -- 请参考demo
```
 [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setTitle(@"请点击两下").setSubtitle(@"1，点击背景是否接受事件\n2，改变动画类型。\n3，只有两个按钮的时候，是横排还是竖排.\n4，改变背景颜色").setAlertType(AlertViewTypeAlert) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].settwoItemHorizontal(hovizonal).setAnimationType(aniType).setTintColor(tintC).setBgViewEvent(NO).setSubtitleTextAligment(NSTextAlignmentLeft) ;
            } buttonArray:^NSArray<NSString *> *{
                return @[@"确定",@"取消"] ;
            } callback:^(EasyAlertView *showview , long index) {
                index ? [EasyTextView showSuccessText:@"点击了取消"] : [EasyTextView showText:@"点击了确定"];
            }];

```
 #### EasyAlertPart：它是显示属性的配置信息。提供了三种方法。这三种方法都是一样的，根据使用习惯选择一种就行。
```

@property (nonatomic,strong)NSString *title ;         //标题
@property (nonatomic,strong)NSString *subtitle ;      //副标题
@property (nonatomic,assign)AlertViewType alertType ; //alert类型 分4种
```



