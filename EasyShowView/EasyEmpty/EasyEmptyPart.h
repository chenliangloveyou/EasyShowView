//
//  EasyEmptyPart.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/14.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyEmptyPart : NSObject

@property (nonatomic,strong)NSString *title ;
@property (nonatomic,strong)NSString *subtitle ;
@property (nonatomic,strong)NSString *imageName ;
@property (nonatomic,strong)NSArray<NSString *> *buttonArray ;

+ (instancetype)shared ;
- (EasyEmptyPart *(^)(NSString *))setTitle ;
- (EasyEmptyPart *(^)(NSString *))setSubtitle ;
- (EasyEmptyPart *(^)(NSString *))setImageName ;
- (EasyEmptyPart *(^)(NSArray<NSString *> *))setButtonArray ;


+ (instancetype)itemWithTitle:(NSString *)title ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName buttonArray:(NSArray *)buttonArray ;


@end
