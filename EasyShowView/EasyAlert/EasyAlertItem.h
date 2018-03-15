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

@property (nonatomic,strong)NSString *title ;
@property (nonatomic,assign)AlertItemType itemTpye ;
@property (nonatomic,strong)alertItemCallback callback ;

+ (instancetype)itemWithTitle:(NSString *)title type:(AlertItemType)type callback:(alertItemCallback)callback ;

@end
