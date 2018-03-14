//
//  EasyAlertPart.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/14.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyAlertTypes.h"

@interface EasyAlertPart : NSObject

@property (nonatomic,strong)NSString *title ;

@property (nonatomic,strong)NSString *subtitle ;

@property (nonatomic,assign)AlertViewType alertType ;

+ (instancetype)shared ;

- (EasyAlertPart *(^)(NSString *))setTitle ;
- (EasyAlertPart *(^)(NSString *))setSubtitle ;
- (EasyAlertPart *(^)(AlertViewType))setAlertType ;

+ (instancetype)alertPartWithTitle:(NSString *)title ;
+ (instancetype)alertPartWithTitle:(NSString *)title subtitle:(NSString *)subtitle ;
+ (instancetype)alertPartWithTitle:(NSString *)title subtitle:(NSString *)subtitle alertype:(AlertViewType)alerttype ;


@end
