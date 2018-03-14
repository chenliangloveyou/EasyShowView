//
//  SecondViewController.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2017/12/23.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "SecondViewController.h"
#import "EasyShowView.h"
@interface SecondViewController ()

@end

@implementation SecondViewController
- (void)dealloc{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(20, 100, 300, 300)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
    
    [EasyLodingView showLodingText:@"加载中..." config:^EasyLodingConfig *{
        return [EasyLodingConfig shared].setSuperView(greenView);
    }];
    __weak typeof(self) weakSelf = self ;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyLodingView hidenLoingInView:greenView];
        [EasyEmptyView showEmptyInView:greenView item:^EasyEmptyPart *{
            return [EasyEmptyPart shared].setTitle(@"网络错误").setSubtitle(@"请检查网络是否正常，点击返回首页...");
        } config:^EasyEmptyConfig *{
            return nil ;
        } callback:^(EasyEmptyView *view, UIButton *button, callbackType callbackType) {
            switch (callbackType) {
                case callbackTypeBgView:
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    break;
                case callbackTypeButton_1:{
                    [EasyTextView showSuccessText:@"加载成功" config:^EasyTextConfig *{
                        return [EasyTextConfig shared].setSuperView(greenView);
                    }];
                }
                    break ;
                case callbackTypeButton_2:
                {
                    EasyAlertView *showView = [EasyAlertView showActionSheetWithTitle:@"提示" message:@"确定删除发撒发逻辑是否快捷登录法拉第设计此数据吗？"];
                    [showView addItemWithTitle:@"确定" itemType:ShowAlertItemTypeBlack callback:^(EasyAlertView *showview) {
                        NSLog(@"好的=%@",showview) ;
                    }];
                    [showView addItemWithTitle:@"取消" itemType:ShowAlertItemTypeBlack callback:^(EasyAlertView *showview) {
                        NSLog(@"好的=%@",showview) ;
                    }];
                    [showView addItemWithTitle:@"确定删除吗" itemType:ShowAlertItemTypeBlodBlue callback:^(EasyAlertView *showview) {
                        NSLog(@"好的=%@",showview) ;
                    }];
                    [showView addItemWithTitle:@"点击取消当前操作！" itemType:ShowAlertItemTypeBlodRed callback:^(EasyAlertView *showview) {
                        NSLog(@"好的=%@",showview) ;
                    }];
                    
                    [showView show];
                }break ;
                default:
                    break;
            }
        }];
        

    });
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
