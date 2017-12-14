//
//  EasyShowAlertItem.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/4.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EasyShowOptions.h"
@class EasyShowView ;

typedef void (^alertItemCallback)(EasyShowView *showview);

@interface EasyShowAlertItem : NSObject

@property (nonatomic,strong)NSString *title ;
@property (nonatomic,assign)ShowAlertItemType itemTpye ;
@property (nonatomic,strong)alertItemCallback callback ;

@end
