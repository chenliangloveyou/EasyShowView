//
//  EasyEmptyItem.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyEmptyItem.h"

@implementation EasyEmptyItem

+ (instancetype)shared
{
    return [[self alloc]init] ;
}

- (EasyEmptyItem *(^)(NSString *))setTitle
{
    return ^EasyEmptyItem* (NSString *title) {
        self.title = title;
        return self;
    };
}
- (EasyEmptyItem *(^)(NSString *))setSubtitle
{
    return ^EasyEmptyItem* (NSString *subtitle){
        self.subtitle = subtitle ;
        return self ;
    };
}
- (EasyEmptyItem *(^)(NSString *))setImageName
{
    return ^EasyEmptyItem *(NSString *imageName){
        self.imageName = imageName ;
        return self ;
    };
}
- (EasyEmptyItem *(^)(NSArray<NSString *> *))setButtonArray
{
    return ^EasyEmptyItem *(NSArray *buttonArray){
        self.buttonArray = buttonArray ;
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
    EasyEmptyItem *item = [[EasyEmptyItem alloc]init];
    item.title = title ;
    item.subtitle = subtitle ;
    item.imageName = imageName ;
    item.buttonArray = buttonArray ;
    return item ;
}






@end
