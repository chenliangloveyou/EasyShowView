//
//  SecondViewController.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2017/12/23.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "SecondViewController.h"
#import "EasyShowView.h"
@interface SecondViewController ()<UIWebViewDelegate>

@end

@implementation SecondViewController
- (void)dealloc{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    static int index = 0 ;
    NSString *url = ++index%2 ? @"https://github.com/chenliangloveyou/EasyShowView" : @"https://github.com/chenliangloveyou/EasyNavigation" ;
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self ;
    [webView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];
    
    [EasyLoadingView showLoadingText:@"加载中..."];
   
    
    // Do any additional setup after loading the view.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    dispatch_queue_after_S(2, ^{
        [EasyLoadingView hidenLoading];
//    });
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
