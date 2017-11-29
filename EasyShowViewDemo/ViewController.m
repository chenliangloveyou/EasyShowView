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
#import "EasyShowOptions.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView ;
@property (nonatomic,strong)NSArray *dataArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
  
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
    
    [self selectAtIndex:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10 ;
}

- (void)selectAtIndex:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:{
                    [EasyShowOptions sharedEasyShowOptions].textStatusType = ShowStatusTextTypeTop ;
                    NSLog(@"%lu",(unsigned long)[EasyShowOptions sharedEasyShowOptions].textStatusType);
                    [EasyShowView showText:@"今天发的拉伸；试大家了"];
                } break;
                case 1:
                {
                    [EasyShowOptions sharedEasyShowOptions].textStatusType = ShowStatusTextTypeBottom ;
                    [EasyShowView showText:@"今天发的拉伸；试大家了"];
                }
//                    [EasyShowView showSuccessText:@"恭喜您通过所有关卡!"];
                    break ;
                case 2:
                {  [EasyShowOptions sharedEasyShowOptions].textStatusType = ShowStatusTextTypeMidden ;
                    [EasyShowView showText:@"今天发的拉伸；试大家了"];
                }
//                    [EasyShowView showErrorText:@"加载失败！"];
                    break ;
                case 3:
                    [EasyShowView showInfoText:@"请完善基本信息!"];
                    break ;
                case 4:
                    [EasyShowView showImageText:@"自定义图片" image:[UIImage imageNamed:@"HUD_NF.png"] inView:self.view];
                    break ;
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [EasyShowView showLoding];
                    break;
                case 1:
                    [EasyShowView hidenLoding];
                    break ;
                    
                default:
                    break;
            }
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
                       @[@"纯文字",@"显示成功",@"显示失败",@"显示提示",@"显示图片"],
                       @[@"显示加载框",@"隐藏加载框"]
                      ];
    }
    return _dataArray ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
