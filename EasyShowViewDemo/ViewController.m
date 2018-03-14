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
            }];
        }break;
        case 1: [EasyTextView showSuccessText:@"显示成功！" config:nil];  break;
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
    switch (row) {
        case 0:{
            [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setTitle(@"这是个标题").setSubtitle(@"这是副标题").setAlertType(AlertViewTypeAlert) ;
            } config:^EasyAlertConfig *{
                return [EasyAlertConfig shared].setAlertViewMaxNum(2).setTitleColor([UIColor blueColor]) ;
            } buttonArray:^NSArray<NSString *> *{
                return @[@"确定",@"取消"] ;
            } callback:^(EasyAlertView *showview) {
                
            }];
        } break;
            
        case 1:
        {
            EasyAlertView *alertV = [EasyAlertView alertViewWithPart:^EasyAlertPart *{
                return [EasyAlertPart shared].setSubtitle(@"这是副标题").setAlertType(AlertViewTypeActionSheet) ;
            } config:nil];
            [alertV addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"shan'chu" type:AlertItemTypeBlue callback:nil];
            }];
            [alertV addAlertItem:^EasyAlertItem *{
                return [EasyAlertItem itemWithTitle:@"红色粗体" type:AlertItemTypeBlodRed callback:nil];
            }];
            [alertV addAlertItemWithTitleArray:@[@"这是家的",@"zitfalsj",@"发开始放假"] callback:nil];
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
            } callback:^(EasyAlertView *showview) {
                
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
