//
//  ViewController.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "ViewController.h"
#import "EasyShowView.h"


#import "SecondViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView ;
@property (nonatomic,strong)NSArray *dataArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"EasyShowView示例";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"展示1" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"展示2" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
    [self.view addSubview:self.tableView] ;
}

- (void)rightBarClick
{
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0: [self showTextWithRow:indexPath.row] ;  break ;
        case 1: [self showLoadingWithRow:indexPath.row]; break ;
        case 2: [self showEmptyWithRow:indexPath.row];  break ;
        case 3: [self showAlertWithRow:indexPath.row];  break ;
        default: break;
    }
}

//https://github.com/chenliangloveyou/EasyShowView
#warning -- 欢迎到github上下载最新代码，喜欢的话，多多start~~~~


#pragma mark - showText
- (void)showTextWithRow:(long)row
{
    switch (row) {
            
        case 0:
        {
            [EasyTextView showText:@"纯文字消息" config:^EasyTextConfig *{
                //（这三种方法都是一样的，根据使用习惯选择一种就行。|| 不传的参数就会使用EasyTextGlobalConfig全局配置的属性）
                //方法一
                //return [EasyTextConfig configWithSuperView:self.view superReceiveEvent:ShowTextEventUndefine animationType:TextAnimationTypeNone textStatusType:TextStatusTypeBottom];
                //方法二
                //return [EasyTextConfig shared].setBgColor([UIColor lightGrayColor]).setShadowColor([UIColor clearColor]).setStatusType(TextStatusTypeBottom);
                //方法三
                EasyTextConfig *config = [EasyTextConfig shared];
                config.bgColor = [UIColor lightGrayColor] ;
                config.shadowColor = [UIColor clearColor] ;
                config.animationType = TextAnimationTypeFade;
                config.statusType = TextStatusTypeBottom ;
                return config ;
            }];
        }break;
            
            
        case 1:
        {
            [EasyTextView showSuccessText:@"显示成功消息!"];
        } break;
            
            
        case 2:
        {
            [EasyTextView showErrorText:@"服务器错误！" config:^EasyTextConfig *{
                return [EasyTextConfig shared].setStatusType(TextStatusTypeNavigation) ;
            }];
        } break ;
            
            
        case 3:
        {
            [EasyTextView showInfoText:@"请完成基本信息！" config:^EasyTextConfig *{
                return [EasyTextConfig shared].setShadowColor([UIColor redColor]).setBgColor([UIColor blackColor]).setTitleColor([UIColor whiteColor]).setStatusType(TextStatusTypeStatusBar);
            }];
        }break ;
            
            
        case 4:
        {
            [EasyTextView showImageText:@"显示期间不接受事件！" imageName:@"HUD_NF.png" config:^EasyTextConfig *{
                return [EasyTextConfig shared].setAnimationType(TextAnimationTypeNone).setShadowColor([UIColor clearColor]).setBgColor([UIColor blackColor]).setTitleColor([UIColor whiteColor]).setSuperReceiveEvent(NO);
            }];
        }break ;
    }
    
}

#pragma mark - showLoading
- (void)showLoadingWithRow:(long)row
{
    switch (row) {
        case 0:
        {
            static int a = 0 ;
            NSString *s = ++a%2 ? @"" : @"加载中...";
            [EasyLoadingView showLoadingText:s];
        } break;
            
            
        case 1:
        {
            [EasyLoadingView showLoadingText:@"正在努力加载中..." config:^EasyLoadingConfig *{
                static int a = 0 ;
                int type = ++a%2 ? LoadingShowTypeIndicatorLeft : LoadingShowTypeIndicator ;
                return [EasyLoadingConfig shared].setLoadingType(type);
            }];
        }break ;
            
            
        case 2:
        {
            EasyLoadingView *LoadingV = [EasyLoadingView showLoadingText:@"3秒后能交互..." config:^EasyLoadingConfig *{
                static int a = 0 ;
                int type = ++a%2 ? LoadingShowTypePlayImagesLeft : LoadingShowTypePlayImages ;
                return [EasyLoadingConfig shared].setLoadingType(type).setSuperReceiveEvent(NO);
            }];
            dispatch_queue_after_S(3, ^{
                [EasyLoadingView hidenLoading:LoadingV];
            });
            
        }break ;
            
            
        case 3:
        {
            [EasyLoadingView showLoadingText:@"正在加载中.." imageName:@"HUD_NF.png" config:^EasyLoadingConfig *{
                static int a = 0 ;
                int type = ++a%2 ? LoadingShowTypeImageUpturnLeft : LoadingShowTypeImageUpturn ;
                return [EasyLoadingConfig shared].setLoadingType(type).setBgColor([UIColor blackColor]).setTintColor([UIColor whiteColor]);
            }];
        }break ;
            
            
        case 4:
        {
            static int a = 0 ;
            NSString *s = ++a%2 ? @"大小根据图片尺寸变化" : @"" ;
            [EasyLoadingView showLoadingText:s imageName:@"HUD_NF.png" config:^EasyLoadingConfig *{
                return [EasyLoadingConfig shared].setLoadingType(LoadingShowTypeImageAround) ;
            }];
        }break;
            
            
        default:
            [EasyLoadingView hidenLoading];
            break;
    }
    
}

#pragma mark - showEmpty
- (void)showEmptyWithRow:(long)row
{
    switch (row) {
        case 0:
        {
            [EasyEmptyView showEmptyInView:self.view part:^EasyEmptyPart *{
                return [EasyEmptyPart shared].setTitle(@"网络连接已断开").setImageName(@"netError.png") ;
            } config:^EasyEmptyConfig *{
                return [EasyEmptyConfig shared].setTitleColor([UIColor redColor]).setScrollVerticalEnable(NO);
            } callback:^(EasyEmptyView *view, UIButton *button, callbackType callbackType) {
                [EasyEmptyView hiddenEmptyInView:self.view];
            }];
            
        }break;
        case 1:
        {
            UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
            redView.backgroundColor = [UIColor redColor];
            [self.view addSubview:redView];
            
            dispatch_queue_after_S(1, ^{
                [EasyEmptyView showEmptyInView:redView part:^EasyEmptyPart *{
                    return [EasyEmptyPart shared].setTitle(@"你开心就好").setImageName(@"netError.png").setSubtitle(@"数据加载失败，点击重新加载！").setButtonArray(@[@"取消",@"去首页"]);
                } config:nil callback:nil];
            });
            
        }break ;
        case 2:
        {
            UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(10, 200, 300, 380)];
            blueView.backgroundColor = [UIColor cyanColor];
            [self.view addSubview:blueView];
            
            dispatch_queue_after_S(1, ^{
                
                __block EasyEmptyView *emptyV = [EasyEmptyView showEmptyInView:blueView part:^EasyEmptyPart *{
                    return [EasyEmptyPart shared].setImageName(@"netError.png").setTitle(@"数据加载失败，点击重新加载！");
                } config:^EasyEmptyConfig *{
                    return [EasyEmptyConfig shared].setEasyViewEdgeInsets(UIEdgeInsetsMake(20, 30, 80, -30)) ;
                } callback:^(EasyEmptyView *view, UIButton *button, callbackType callbackType) {
                    
                    [EasyEmptyView hiddenEmptyView:emptyV];
                    
                    [EasyLoadingView showLoadingText:@"正在加载中..." config:^EasyLoadingConfig *{
                        return [EasyLoadingConfig shared].setSuperView(blueView);
                    }];
                    
                    dispatch_queue_after_S(3, ^{
                        [EasyLoadingView hidenLoingInView:blueView];
                        [blueView removeFromSuperview];
                    });
                }];
            });
            
        }break ;
        default:
            break;
    }
    
}


#pragma mark - showAlert
- (void)showAlertWithRow:(long)row
{
    switch (row) {
        case 0:{
            static int a = 0 ;
            BOOL hovizonal = ++a%2 ;
            AlertAnimationType aniType =hovizonal ? AlertAnimationTypeFade : AlertAnimationTypeBounce ;
            UIColor *tintC = hovizonal ? [UIColor groupTableViewBackgroundColor] : [UIColor cyanColor] ;
            
            
            [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setTitle(@"请点击两下").setSubtitle(@"1，点击背景是否接受事件\n2，改变动画类型。\n3，只有两个按钮的时候，是横排还是竖排.\n4，改变背景颜色").setAlertType(AlertViewTypeAlert) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].settwoItemHorizontal(hovizonal).setAnimationType(aniType).setTintColor(tintC).setBgViewEvent(NO).setSubtitleTextAligment(NSTextAlignmentLeft).setEffectType(AlertBgEffectTypeAlphaCover) ;
            } buttonArray:^NSArray<NSString *> *{
                return @[@"确定",@"取消"] ;
            } callback:^(EasyAlertView *showview , long index) {
                index ? [EasyTextView showSuccessText:@"点击了取消"] : [EasyTextView showText:@"点击了确定"];
            }];
        } break;
            
            
        case 1:
        {
            //第一步 创建alertview
            EasyAlertView *alertV = [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setTitle(@"标题").setSubtitle(@"这是副标题").setAlertType(AlertViewTypeActionSheet) ;
            } config:nil buttonArray:nil callback:^(EasyAlertView *showview, long index) {
                NSLog(@"点击了 index = %ld",index );
            }];
            
            //第二步 添加上面的按钮
            [alertV addAlertItemWithTitleArray:@[@"这是家的",@"zitfalsj",@"发开始放假"] callback:nil];
            [alertV addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"红色粗体" type:AlertItemTypeBlodRed callback:^(EasyAlertView *showview, long index) {
                    //因为上面已经加了一个全局的回调，所以这个地方是不会回调的
                    NSLog(@"红色粗体 = %ld",index );
                }];
            }];
            
            //第三步  显示alertview
            [alertV showAlertView];
            
        } break ;
        case 2:{
            EasyAlertView *alertView = [EasyAlertView alertViewWithTitle:@"标题" subtitle:@"负表笔" AlertViewType:AlertViewTypeSystemAlert config:nil];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"红色按钮_1" type:AlertItemTypeSystemDestructive callback:nil];
            }];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"按钮 " type:AlertItemTypeSystemDefault callback:nil];
            }];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"取消控件(一定在最下面)" type:AlertItemTypeSystemCancel callback:nil];
            }];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"红色按钮_2" type:AlertItemTypeSystemDestructive callback:nil];
            }];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"按钮" type:AlertItemTypeSystemDefault callback:nil];
            }];
            [alertView showAlertView];
        }break ;
        case 3:{
            static int a = 0 ;
            EasyAlertView *alertV = [EasyAlertView alertViewWithTitle:nil subtitle:@"只有添加Cancel按钮的时候，点击背景才会销毁alertview" AlertViewType:AlertViewTypeSystemActionSheet config:nil];
            if (++a%2) {
                [alertV addAlertItem:^EasyAlertItem *{
                    return [EasyAlertItem itemWithTitle:@"取消按钮" type:AlertItemTypeSystemCancel callback:nil];
                }];
            }
            [alertV addAlertItemWithTitle:@"红色按钮" type:AlertItemTypeSystemDestructive callback:nil];
            [alertV addAlertItemWithTitleArray:@[@"你好",@"谢谢"] callback:nil];

            [alertV showAlertView];
            
        }break ;
        default:
            break;
    }
}






#pragma mark - getter/setter
- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        _tableView.dataSource = self ;
        _tableView.delegate = self ;
    }
    return _tableView ;
}

- (NSArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = @[
                       @[@"纯文字消息",@"成功消息",@"失败消息",@"提示消息",@"自定义图片"],
                       @[@"转圈加载框",@"菊花加载框",@"自定义图片加载框",@"图片翻转加载框",@"图片边框转圈",@"隐藏加载框"] ,
                       @[@"空页面(不可滚动)",@"空页面(所有子控件)",@"空页面(对superview外扩内收)"],
                       @[@"一行代码显示自定义alertView",@"ActionSheet",@"系统AlertView",@"系统ActionSheet(点2次)"]
                       ];
    }
    return _dataArray ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
