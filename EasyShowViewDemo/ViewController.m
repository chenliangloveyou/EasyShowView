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
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"接受事件" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
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


- (void)showTextWithRow:(long)row
{
    switch (row) {
        case 0:
        {
            [EasyTextView showText:@"你好" config:^EasyTextConfig *{
                return [EasyTextConfig shared].setAnimationType(TextAnimationTypeNone).setShadowColor([UIColor redColor]).setSuperView(self.view);
//                return [EasyShowTextConfig configWithSuperView:self.view
//                                             superReceiveEvent:ShowTextSuperReceiveEventUndefine
//                                                 animationType:TextAnimationTypeUndefine ];
//                return [EasyShowTextConfig configWithSuperView:self.view];
//                return [EasyShowTextConfig configWithSuperView:self.view superReceiveEvent:-1] ;
//                return [EasyShowTextConfig configWithSuperView:self.view superReceiveEvent:-1 animationType:-1 textStatusType:-1];
            }];
           
//            static int aa = 0 ;
//            [EasyShowOptions sharedEasyShowOptions].textStatusType = (aa++)%5 ;//ShowTextStatusTypeStatusBar ; //
//            [EasyTextView showText:@"这是一条纯文字消息!"];
        }break;
        case 1: [EasyTextView showSuccessText:@"显示成功！"];  break;
        case 2: [EasyTextView showErrorText:@"服务器错误！"];  break ;
        case 3: [EasyTextView showInfoText:@"请完成基本信息！"];  break ;
        case 4: [EasyTextView showImageText:@"自定义图片！" imageName:@"HUD_NF.png"];  break ;
    }
    
}
- (void)showLodingWithRow:(long)row
{
    switch (row) {
        case 0:{
            [EasyLodingView showLodingText:@"加载中..."];
        } break;
        case 1:
        {
            [EasyLodingView showLodingText:@"正在努力加载中..." config:^EasyLodingConfig *{
                return [EasyLodingConfig configInView:self.view superReceive:YES showType:LodingShowTypeIndicatorLeft];
            }];
        }break ;
        case 2:
        {
            [EasyLodingView showLodingText:@"加载中..." config:^EasyLodingConfig *{
                return [EasyLodingConfig configInView:self.view superReceive:NO showType:LodingShowTypePlayImages];
            }];
        }break ;
        case 3:
        {
            [EasyLodingView showLodingText:@"正在加载中,请稍后..." config:^EasyLodingConfig *{
                return [EasyLodingConfig configInView:self.view superReceive:YES showType:LodingShowTypePlayImagesLeft];
            }];
        }break ;
        case 4:
        {
            [EasyLodingView showLodingText:@"正在加载中.." imageName:@"HUD_NF.png" config:^EasyLodingConfig *{
                return [EasyLodingConfig configInView:self.view superReceive:YES showType:LodingShowTypeImageUpturnLeft];
            }];
        }break ;
        case 5:
        {
            [EasyLodingView showLodingText:@"" imageName:@"HUD_NF.png" config:^EasyLodingConfig *{
                return [EasyLodingConfig configInView:self.view superReceive:YES showType:LodingShowTypeImageAround];
            }];
            
        }
        default:
            [EasyLodingView hidenLoding];
            break;
    }
//    static int b_0 = 0 ;
//    switch (row) {
//        case 0:
//            [EasyShowOptions sharedEasyShowOptions].lodingShowType = ++b_0%2 ? LodingShowTypeTurnAroundLeft : LodingShowTypeTurnAround ;
//            [EasyLodingView showLodingText:@"正在努力加载..."];
//            break;
//        case 1:
//            [EasyShowOptions sharedEasyShowOptions].lodingShowType = ++b_0%2 ? LodingShowTypeIndicatorLeft : LodingShowTypeIndicator ;
//            [EasyLodingView showLodingText:@"正在添加"];
//            break ;
//        case 2:{
//            [EasyShowOptions sharedEasyShowOptions].lodingShowType = ++b_0%2 ? LodingShowTypePlayImagesLeft : LodingShowTypePlayImages ;
//            [EasyLodingView showLodingText:@"加载中..."];
//        }break ;
//        case 3:
//        {
//            [EasyShowOptions sharedEasyShowOptions].lodingShowType = ++b_0%2 ? LodingShowTypeImageUpturnLeft : LodingShowTypeImageUpturn ;
//            [EasyLodingView showLodingText:@"正在加载中,请稍后..." imageName:@"HUD_NF.png"];
//        }   break ;
//        case 4:
//        {
//            [EasyShowOptions sharedEasyShowOptions].lodingShowType = ++b_0%2 ? LodingShowTypeImageAroundLeft : LodingShowTypeImageAround ;
//            [EasyLodingView showLodingText:@"" imageName:@"HUD_NF.png"];
//        }break ;
//        default:
//            [EasyLodingView hidenLoding];
//            break;
//    }
}

- (void)showEmptyWithRow:(long)row
{
    switch (row) {
        case 0:
        {
            [EasyEmptyView showEmptyInView:self.view item:^EasyEmptyPart *{
                return [EasyEmptyPart shared].setTitle(@"网络连接已断开").setImageName(@"netError.png") ;
            }config:^EasyEmptyConfig *{
                return [EasyEmptyConfig shared].setBgColor([UIColor colorWithWhite:0.5 alpha:0.5]);
            } callback:^(EasyEmptyView *view, UIButton *button, callbackType callbackType) {
                [EasyEmptyView hiddenEmptyView:self.view];
            }];
          
        }break;
        case 1:
        {
            UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(10, 50, 200, 300)];
            redView.backgroundColor = [UIColor redColor];
            [self.view addSubview:redView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [EasyEmptyView showEmptyInView:redView item:^EasyEmptyPart *{
                    return [EasyEmptyPart shared].setTitle(@"你开心就好");
                } config:nil callback:nil];
            });
            
        }break ;
        case 2:
        {
            UIView *blueView = [[UIView alloc]initWithFrame:CGRectMake(10, 200, 300, 380)];
            blueView.backgroundColor = [UIColor cyanColor];
            [self.view addSubview:blueView];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              
//                [EasyEmptyView showEmptyViewWithTitle:@"无数据" subTitle:@"" imageName:@"nodata_icon.png" buttonTitleArray:@[@"重新加载数据"] inview:blueView callback:^(EasyEmptyView *view, UIButton *button, callbackType callbackType) {
//                    [EasyLodingView showLodingText:@"正在加载中..." config:^EasyLodingConfig *{
//                        return [EasyLodingConfig shared].setSuperView(blueView);
//                    }];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [EasyLodingView hidenLoingInView:blueView];
//                        [blueView removeFromSuperview];
//                    });
//                }];
               
            });
        }break ;
        default:
            break;
    }
    
}
- (void)showAlertWithRow:(long)row
{
//
//    EasyAlertView *alertView = [EasyAlertView alertViewWithTitle:@"title" subtitle:@"subtitle" alertViewType:alertViewTypeAlert config:^EasyAlertConfig *{
//        return [EasyAlertConfig shared].setTintColor([UIColor blackColor]);
//    }] ;
//    [alertView addItemWithTitle:@"alerttype" type:AlertItemTypeRed callback:^(EasyAlertView *showview) {
//        NSLog(@"天");
//    }];
//    [alertView addItem:^EasyAlertItem *{
//        return [EasyAlertItem itemWithTitle:@"title" type:AlertItemTypeRed callback:^(EasyAlertView *showview) {
//            NSLog(@"'dafdkfd");
//        }];
//    }] ;
//    [alertView addItemWithTitleArray:@[@"您好",@"还好吧"] callback:^(EasyAlertView *showview) {
//
//    }];
//    [alertView show];
    
    [EasyAlertView alertViewWithPart:^EasyAlertPart *{
        return [EasyAlertPart shared].setTitle(@"这是个标题").setSubtitle(@"这是副标题").setAlertType(alertViewTypeAlert) ;
    } config:^EasyAlertConfig *{
        return [EasyAlertConfig shared].setAlertViewMaxNum(2).setTintColor([UIColor blueColor]) ;
    } buttonArray:^NSArray<NSString *> *{
        return @[@"确定",@"取消"] ;
    } callback:^(EasyAlertView *showview) {
        
    }];
//    switch (row) {
//        case 0:
//        {
//            static int c_0 = 0 ;
//            //设置动画类型。建议在appdelegate里面设置一次就好(APP应该统一风格)。
////            [EasyShowOptions sharedEasyShowOptions].alertAnimationType =  (c_0++)%5 ;
//            //设置主题颜色
////            [EasyShowOptions sharedEasyShowOptions].alertTintColor = [UIColor cyanColor];
//            EasyAlertView *showView = [EasyAlertView showAlertWithTitle:@"提示" message:@"确定删除发撒发逻辑是否快捷登录法拉第设计数据吗？"];
//
//
//            if (c_0%4) {
//                [showView addItemWithTitle:@"取消" itemType:AlertItemTypeRed callback:^(EasyAlertView *showview) {
//                    NSLog(@"好的=%@",showview) ;
//                }];
//
//            }
//            if (c_0%2) {
//                [showView addItemWithTitle:@"我已了解" itemType:AlertItemTypeBlodBlue callback:^(EasyAlertView *showview) {
//                    NSLog(@"我已了解=%@",showview) ;
//                }];
//                [showView addItemWithTitle:@"好的" itemType:AlertItemTypeBlue callback:^(EasyAlertView *showview) {
//                    NSLog(@"好的=%@",showview) ;
//                }];
////                [EasyShowOptions sharedEasyShowOptions].alertTintColor = [UIColor clearColor];
//            }
//            [showView show];
//        }break;
//
//        case 1:
//        {
//            EasyAlertView *showView = [EasyAlertView showActionSheetWithTitle:@"提示" message:@"确定删除发撒发逻辑是否快捷登录法拉第设计此数据吗？"];
//            [showView addItemWithTitle:@"确定" itemType:AlertItemTypeBlack callback:^(EasyAlertView *showview) {
//                NSLog(@"好的=%@",showview) ;
//            }];
//            [showView addItemWithTitle:@"取消" itemType:AlertItemTypeBlack callback:^(EasyAlertView *showview) {
//                NSLog(@"好的=%@",showview) ;
//            }];
//            [showView addItemWithTitle:@"确定删除吗" itemType:AlertItemTypeBlodBlue callback:^(EasyAlertView *showview) {
//                NSLog(@"好的=%@",showview) ;
//            }];
//            [showView addItemWithTitle:@"点击取消当前操作！" itemType:AlertItemTypeBlodRed callback:^(EasyAlertView *showview) {
//                NSLog(@"好的=%@",showview) ;
//            }];
//
//            [showView show];
//        }break;
//        case 2:
//        {
//            EasyAlertView *alertView =[EasyAlertView showSystemAlertWithTitle:@"提示" message:@"确定需要此操作吗?次草错爱东方饭店了肯德基福达康！"];
//            [alertView addSystemItemWithTitle:@"确定" itemType:AlertActionSystemStyleDefault callback:^(EasyAlertView *showview) {
//                NSLog(@"dddddddd    ");
//            }];
//            [alertView addSystemItemWithTitle:@"确dd定" itemType:AlertActionSystemStyleDestructive callback:^(EasyAlertView *showview) {
//                NSLog(@"dddddwd  ");
//            }];
//            [alertView systemShow];
//        }break ;
//        case 3:
//        {
//            EasyAlertView *alertView =[EasyAlertView showSystemActionSheetWithTitle:@"请选择您需要的操作" message:@""];
//            [alertView addSystemItemWithTitle:@"确定" itemType:AlertActionSystemStyleDefault callback:^(EasyAlertView *showview) {
//                NSLog(@"dddddddd    ");
//            }];
//            [alertView addSystemItemWithTitle:@"确定" itemType:AlertActionSystemStyleDefault callback:^(EasyAlertView *showview) {
//                NSLog(@"dddddddd    ");
//            }];
//            [alertView addSystemItemWithTitle:@"删除操作" itemType:AlertActionSystemStyleDestructive callback:^(EasyAlertView *showview) {
//                NSLog(@"dddddddd    ");
//            }];
//            static int c_3 = 0 ;
//            if (++c_3%2) {
//                [alertView addSystemItemWithTitle:@"取消" itemType:AlertActionSystemStyleCancel callback:^(EasyAlertView *showview) {
//                    NSLog(@"dddddddd    ");
//                }];
//            }
//            [alertView systemShow];
//        }break ;
//        default:
//          break ;
//    }
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
                       @[@"空页面1",@"空页面2",@"空页面3"],
                       @[@"AlertView(点5次)",@"ActionSheet",@"系统AlertView",@"系统ActionSheet(点2次)"]
                       ];
    }
    return _dataArray ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
