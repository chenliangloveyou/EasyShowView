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
    
    
    UIView *greenView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
    
    
    [EasyShowOptions sharedEasyShowOptions].lodingShowType =  LodingShowTypeTurnAround ;
    [EasyShowLodingView showLodingText:@"正在加载中" inView:greenView] ;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [EasyShowLodingView hidenLoingInView:greenView];
        [EasyShowTextView showSuccessText:@"加载完成?" inView:greenView] ;

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
