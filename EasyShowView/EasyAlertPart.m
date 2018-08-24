//
//  EasyAlertPart.m
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/14.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyAlertPart.h"

@implementation EasyAlertPart

+ (instancetype)shared
{
    return [self new];
}

- (EasyAlertPart *(^)(NSString *))setTitle
{
    return ^EasyAlertPart* (NSString *title) {
        self.title = title;
        return self;
    };
}
- (EasyAlertPart *(^)(NSString *))setSubtitle
{
    return ^EasyAlertPart* (NSString *subtitle){
        self.subtitle = subtitle ;
        return self ;
    };
}
- (EasyAlertPart *(^)(AlertViewType))setAlertType
{
    return ^EasyAlertPart* (AlertViewType type){
        self.alertType = type ;
        return self ;
    };
}


+ (instancetype)alertPartWithTitle:(NSString *)title
{
    return [self alertPartWithTitle:title subtitle:nil];
}
+ (instancetype)alertPartWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    return [self alertPartWithTitle:title subtitle:subtitle alertype:AlertViewTypeAlert];
}
+ (instancetype)alertPartWithTitle:(NSString *)title subtitle:(NSString *)subtitle alertype:(AlertViewType)alerttype
{
    EasyAlertPart *part = [self shared];
    part.title = title ;
    part.subtitle = subtitle ;
    part.alertType = alerttype ;
    return part ;
}
@end



