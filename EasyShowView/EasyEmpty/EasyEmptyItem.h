//
//  EasyEmptyItem.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2018/3/5.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyEmptyItem : NSObject

@property (nonatomic,strong)NSString *title ;
@property (nonatomic,strong)NSString *subtitle ;
@property (nonatomic,strong)NSString *imageName ;
@property (nonatomic,strong)NSArray<NSString *> *buttonArray ;

+ (instancetype)shared ;
- (EasyEmptyItem *(^)(NSString *))setTitle ;
- (EasyEmptyItem *(^)(NSString *))setSubtitle ;
- (EasyEmptyItem *(^)(NSString *))setImageName ;
- (EasyEmptyItem *(^)(NSArray<NSString *> *))setButtonArray ;


+ (instancetype)itemWithTitle:(NSString *)title ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName buttonArray:(NSArray *)buttonArray ;

@end
