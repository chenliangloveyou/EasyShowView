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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"展示" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];

    
    [self.view addSubview:self.tableView];

}

- (void)rightBarClick
{
    SecondViewController *sc = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:sc animated:YES];
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0: [self showTextWithRow:indexPath.row] ;  break ;
        case 1: [self showLodingWithRow:indexPath.row]; break ;
        case 2: [self showEmptyWithRow:indexPath.row];  break ;
        case 3: [self showAlertWithRow:indexPath.row];  break ;
        default: break;
    }
}

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

#pragma mark - showLoding
- (void)showLodingWithRow:(long)row
{
    switch (row) {
        case 0:
        {
            static int a = 0 ;
            NSString *s = ++a%2 ? @"" : @"加载中...";
            [EasyLodingView showLodingText:s];
        } break;
            
            
        case 1:
        {
            [EasyLodingView showLodingText:@"正在努力加载中..." config:^EasyLodingConfig *{
                static int a = 0 ;
                int type = ++a%2 ? LodingShowTypeIndicatorLeft : LodingShowTypeIndicator ;
                return [EasyLodingConfig shared].setLodingType(type);
            }];
        }break ;
           
            
        case 2:
        {
            EasyLodingView *lodingV = [EasyLodingView showLodingText:@"3秒后能交互..." config:^EasyLodingConfig *{
                static int a = 0 ;
                int type = ++a%2 ? LodingShowTypePlayImagesLeft : LodingShowTypePlayImages ;
                return [EasyLodingConfig shared].setLodingType(type).setSuperReceiveEvent(NO);
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [EasyLodingView hidenLoding:lodingV];
            });
        }break ;
            
            
        case 3:
        {
            [EasyLodingView showLodingText:@"正在加载中.." imageName:@"HUD_NF.png" config:^EasyLodingConfig *{
                static int a = 0 ;
                int type = ++a%2 ? LodingShowTypeImageUpturnLeft : LodingShowTypeImageUpturn ;
                return [EasyLodingConfig shared].setLodingType(type).setBgColor([UIColor blackColor]).setTintColor([UIColor whiteColor]);
            }];
        }break ;
            
            
        case 4:
        {
            static int a = 0 ;
            NSString *s = ++a%2 ? @"大小根据图片尺寸变化" : @"" ;
            [EasyLodingView showLodingText:s imageName:@"HUD_NF.png" config:^EasyLodingConfig *{
                return [EasyLodingConfig shared].setLodingType(LodingShowTypeImageAround) ;
            }];
        }break;
            
            
        default:
            [EasyLodingView hidenLoding];
            break;
    }
  
}

#pragma mark - showEmpty
- (void)showEmptyWithRow:(long)row
{
    switch (row) {
        case 0:
        {
            [EasyEmptyView showEmptyInView:self.view item:^EasyEmptyPart *{
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
                [EasyEmptyView showEmptyInView:redView item:^EasyEmptyPart *{
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
                
                __block EasyEmptyView *emptyV = [EasyEmptyView showEmptyInView:blueView item:^EasyEmptyPart *{
                    return [EasyEmptyPart shared].setImageName(@"netError.png").setTitle(@"数据加载失败，点击重新加载！");
                } config:^EasyEmptyConfig *{
                    return [EasyEmptyConfig shared].setEasyViewEdgeInsets(UIEdgeInsetsMake(20, 30, 80, -30)) ;
                } callback:^(EasyEmptyView *view, UIButton *button, callbackType callbackType) {
                    
                    [EasyEmptyView hiddenEmptyView:emptyV];
                    
                    [EasyLodingView showLodingText:@"正在加载中..." config:^EasyLodingConfig *{
                        return [EasyLodingConfig shared].setSuperView(blueView);
                    }];
                    
                    dispatch_queue_after_S(3, ^{
                        [EasyLodingView hidenLoingInView:blueView];
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
            AlertAnimationType animationType =hovizonal ? AlertAnimationTypeFade : AlertAnimationTypeBounce ;
            UIColor *tintColor = hovizonal ? [UIColor groupTableViewBackgroundColor] : [UIColor cyanColor] ;
         
            
            [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setTitle(@"这是个标题").setSubtitle(@"这是副标题").setAlertType(AlertViewTypeAlert) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].settwoItemHorizontal(hovizonal).setAnimationType(animationType).setTintColor(tintColor) ;
            } buttonArray:^NSArray<NSString *> *{
                return @[@"确定",@"取消"] ;
            } callback:^(EasyAlertView *showview , long index) {
                if (index == 0) {
                    [EasyTextView showText:@"点击了确定"];
                }
                else{
                    [EasyTextView showSuccessText:@"点击了取消"];
                }
            }];
        } break;
            
        case 1:
        {
            EasyAlertView *alertV = [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setTitle(@"标题").setSubtitle(@"这是副标题").setAlertType(AlertViewTypeActionSheet) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].setTintColor([UIColor cyanColor]).setAlertViewMaxNum(2) ;
            }];
            [alertV addAlertItemWithTitleArray:@[@"这是家的",@"zitfalsj",@"发开始放假"] callback:nil];
            [alertV addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"红色粗体" type:AlertItemTypeBlodRed callback:nil];
            }];
            [alertV showAlertView];
            
        } break ;
        case 2:{
            EasyAlertView *alertView = [EasyAlertView alertViewWithTitle:@"标题" subtitle:@"负表笔" AlertViewType:AlertViewTypeSystemAlert config:nil];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"shan'chu" type:AlertItemTypeSystemDestructive callback:nil];
            }];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"nihao a a " type:AlertItemTypeSystemDefault callback:nil];
            }];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"fsdlfsdjfkdjsfkl" type:AlertItemTypeSystemCancel callback:nil];
            }];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"你的真啊" type:AlertItemTypeSystemDestructive callback:nil];
            }];
            [alertView addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"nihao a a " type:AlertItemTypeSystemDefault callback:nil];
            }];
            [alertView showAlertView];
        }break ;
        case 3:{
            [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setSubtitle(@"这是").setAlertType(AlertViewTypeSystemActionSheet) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].setAnimationType(AlertAnimationTypePush);
            } buttonArray:^NSArray<NSString *> *{
                return @[@"好的"];
            } callback:^(EasyAlertView *showview , long index) {
                
            }];
            
            [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setSubtitle(@"这是").setAlertType(AlertViewTypeSystemActionSheet) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].setAnimationType(AlertAnimationTypePush);
            } buttonArray:^NSArray<NSString *> *{
                return @[@"好的"];
            } callback:^(EasyAlertView *showview , long index) {
                
            }];
            
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
                       @[@"一行代码显示alertView",@"ActionSheet",@"系统AlertView",@"系统ActionSheet(点2次)",@"ar"]
                       ];
    }
    return _dataArray ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
