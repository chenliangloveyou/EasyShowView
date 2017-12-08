//
//  ViewController.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "ViewController.h"
#import "EasyShowView.h"
#import "EasyShowView+Loding.h"
#import "EasyShowView+Text.h"
#import "EasyShowView+Alert.h"
#import "EasyShowOptions.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView ;
@property (nonatomic,strong)NSArray *dataArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"父视图接受事件" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
}

- (void)rightBarClick
{
    EasyShowOptions *options = [EasyShowOptions sharedEasyShowOptions];
    options.superViewReceiveEvent = !options.superViewReceiveEvent ;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            [self showTextWithRow:indexPath.row] ;
            break;
        case 1:
            [self showLodingWithRow:indexPath.row];
            break ;
        case 2:
            [self showAlertWithRow:indexPath.row];
            break ;
        default:
            break;
    }
}

- (void)showTextWithRow:(long)row
{
    static int aa = 0 ;
    [EasyShowOptions sharedEasyShowOptions].textStatusType = (aa++)%5 ;//ShowTextStatusTypeStatusBar ; //
    switch (row) {
        case 0: [EasyShowView showText:@"这是一条纯文字消息"];  break;
        case 1: [EasyShowView showSuccessText:@""];  break;
        case 2: [EasyShowView showErrorText:@""];  break ;
        case 3: [EasyShowView showInfoText:@""];  break ;
        case 4: [EasyShowView showImageText:@"" image:[UIImage imageNamed:@"HUD_NF.png"]];  break ;
    }
}
- (void)showLodingWithRow:(long)row
{
//    static int aa = 0 ;
//    [EasyShowOptions sharedEasyShowOptions].textStatusType = ShowTextStatusTypeStatusBar ; // (aa++)%5 ;//
//    switch (row) {
//        case 0: [EasyShowView showText:@"这是一条纯文发烧了；福建省多了扣积分读书节独立思考建档立卡 范德萨了；就字消息"];  break;
//        case 1: [EasyShowView showSuccessText:@"恭喜您通过所有关卡!"];  break;
//        case 2: [EasyShowView showErrorText:@"加载失败！"];  break ;
//        case 3: [EasyShowView showInfoText:@"请完善信息！"];  break ;
//        case 4: [EasyShowView showImageText:@"自定义图片" image:[UIImage imageNamed:@"HUD_NF.png"]];  break ;
//    }
//    return ;
    static int b_0 = 0 ;
    switch (row) {
        case 0:
            [EasyShowOptions sharedEasyShowOptions].showLodingType = ++b_0%2 ? ShowLodingTypeLeftDefault : ShowLodingTypeDefault ;
            [EasyShowView showLodingText:@""];
            break;
        case 1:
            [EasyShowOptions sharedEasyShowOptions].showLodingType = ++b_0%2 ? ShowLodingTypeLeftIndicator : ShowLodingTypeIndicator ;
            [EasyShowView showLodingText:@""];
            break ;
        case 2:
            [EasyShowOptions sharedEasyShowOptions].showLodingType = ++b_0%2 ? ShowLodingTypeLeftImage : ShowLodingTypeImage ;
            [EasyShowView showLodingText:@"正在加载中,请稍后..." image:[UIImage imageNamed:@"HUD_NF.png"]];
            break ;
        case 3:
            [EasyShowView hidenLoding];
            break ;
        default:
            break;
    }
}
- (void)showAlertWithRow:(long)row
{
//    static int aa = 0 ;
//    [EasyShowOptions sharedEasyShowOptions].textStatusType = ShowTextStatusTypeNavigation ; // (aa++)%5 ;//
//    switch (row) {
//        case 0: [EasyShowView showText:@"这是一条纯文发发烧了；放到就离开家烧了；福建省多了扣积分读书节独立思考建档立卡 范德萨了；就字消息"];  break;
//        case 1: [EasyShowView showSuccessText:@"恭喜您通过所有关卡!"];  break;
//        case 2: [EasyShowView showErrorText:@"加载失败！"];  break ;
//        case 3: [EasyShowView showInfoText:@"请完善信息！"];  break ;
//        case 4: [EasyShowView showImageText:@"自定义图片" image:[UIImage imageNamed:@"HUD_NF.png"]];  break ;
//    }
//    return ;
    switch (row) {
        case 0:
        {
            EasyShowView *showView = [EasyShowView showAlertWithTitle:@"提示" message:@"确定删除发撒发逻辑是否快捷登录法拉第设计方老师大嫁风尚拉克的就分类考试大积分此数据吗？"];
            [showView addItemWithTitle:@"确定吗打了款" image:nil itemType:ShowAlertItemTypeBlack callback:^(EasyShowView *showview) {
                NSLog(@"yes");
            }];
            [showView addItemWithTitle:@"取消抄错" image:nil itemType:ShowAlertItemTypeBlodRed callback:^(EasyShowView *showview) {
                NSLog(@"取消抄错");
            }];
            [showView show];
        }break;
        case 1:
        {
        
        }break;
        default:
        {
//            EasyShowView *showAlet = [EasyShowView showActionSheetWithTitle:@"提示" message:@"这是提示的副标题"] ;
//            [showAlet addItemWithTitle:@"确定" image:[UIImage imageNamed:@"HUD_NF.png"] itemType:9 callback:^(EasyShowView *showView, NSUInteger index) {
//                NSLog(@"dddd");
//            }];
//            [showAlet addItemWithTitle:@"" image:nil itemType:ShowAlertItemTypeRed callback:^(EasyShowView *showView, NSUInteger index) {
//                NSLog(@"read") ;
//            }];
//
//            [showAlet show];
        }break ;
            
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
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        img.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView =img ;
    }
    return _tableView ;
}

- (NSArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = @[
                       @[@"纯文字消息",@"成功消息",@"失败消息",@"提示消息",@"自定义图片"],
                       @[@"默认加载框",@"菊花加载框",@"图片加载框",@"隐藏加载框"] ,
                       @[@"展示alertView",@"展示系统alertView",@"ddd",@"adfd",@"dd"]
                       ];
    }
    return _dataArray ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
