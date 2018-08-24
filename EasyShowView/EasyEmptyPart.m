//
//  EasyEmptyPart.m
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/14.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyEmptyPart.h"

@implementation EasyEmptyPart

+ (instancetype)shared
{
    return [[self alloc]init] ;
}

- (EasyEmptyPart *(^)(NSString *))setTitle
{
    return ^EasyEmptyPart* (NSString *title) {
        self.title = title;
        return self;
    };
}
- (EasyEmptyPart *(^)(NSString *))setSubtitle
{
    return ^EasyEmptyPart* (NSString *subtitle){
        self.subtitle = subtitle ;
        return self ;
    };
}
- (EasyEmptyPart *(^)(NSString *))setImageName
{
    return ^EasyEmptyPart *(NSString *imageName){
        self.imageName = imageName ;
        return self ;
    };
}
- (EasyEmptyPart *(^)(NSArray<NSString *> *))setButtonArray
{
    return ^EasyEmptyPart *(NSArray *buttonArray){
        self.buttonArray = [buttonArray copy];
        return self ;
    };
}


+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title subtitle:nil];
}
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
    return [self itemWithTitle:title subtitle:subtitle imageName:nil];
}
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName
{
    return [self itemWithTitle:title subtitle:subtitle imageName:imageName buttonArray:nil];
}
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName buttonArray:(NSArray *)buttonArray
{
    EasyEmptyPart *item = [[EasyEmptyPart alloc]init];
    item.title = title ;
    item.subtitle = subtitle ;
    item.imageName = imageName ;
    item.buttonArray = [buttonArray copy];
    return item ;
}






@end
