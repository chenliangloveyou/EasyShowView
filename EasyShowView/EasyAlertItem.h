//
//  EasyAlertItem.h
//  EasyShowViewDemo
//
//  Created by nf on 2018/3/14.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EasyAlertTypes.h"

@interface EasyAlertItem : NSObject

@property (nonatomic,strong)NSString *title ;           //按钮的标题
@property (nonatomic,assign)AlertItemType itemTpye ;    //按钮的类型
@property (nonatomic,strong)AlertCallback callback ;//点击按钮的回调


+ (instancetype)itemWithTitle:(NSString *)title type:(AlertItemType)type ;
+ (instancetype)itemWithTitle:(NSString *)title type:(AlertItemType)type callback:(AlertCallback)callback ;

@end
