//
//  EasyShowOptions.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EasyShowOptions : NSObject

@property (nonatomic,strong)UIFont *textFount ;
@property (nonatomic,assign)CGFloat maxWidthScale ;
@property (nonatomic,assign)BOOL superViewReceiveEvent ;//在显示的期间，superview是否能接接收事件

+ (instancetype)shareInstance ;
@end
