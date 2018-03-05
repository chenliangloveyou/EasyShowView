//
//  EasyShowEmptyItem.m
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyShowEmptyItem.h"

@implementation EasyShowEmptyItem

+ (instancetype)shareItem
{
    return [[self alloc]init] ;
}
- (EasyShowEmptyItem *(^)(NSString *title))setTitle
{
    return ^EasyShowEmptyItem* (NSString *title) {
        self.title = title;
        return self;
    };
}
- (EasyShowEmptyItem *(^)(NSString *))setSubtitle
{
    return ^EasyShowEmptyItem* (NSString *subtitle){
        self.subtitle = subtitle ;
        return self ;
    };
}
- (EasyShowEmptyItem *(^)(NSString *))setImageName
{
    return ^EasyShowEmptyItem *(NSString *imageName){
        self.imageName = imageName ;
        return self ;
    };
}
- (EasyShowEmptyItem *(^)(NSArray<NSString *> *))setButtonArray
{
    return ^EasyShowEmptyItem *(NSArray *buttonArray){
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
    EasyShowEmptyItem *item = [[EasyShowEmptyItem alloc]init];
    item.title = title ;
    item.subtitle = subtitle ;
    item.imageName = imageName ;
    item.buttonArray = buttonArray ;
    return item ;
}






@end
