//
//  EFShowView.h
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "EasyShowUtils.h"
#import "EasyShowOptions.h"

@interface EasyShowView : UIView

@property (nonatomic,strong)NSString *showText ;//展示的文字
@property (nonatomic,strong)UIImage *showImage ;//展示的图片
@property (nonatomic,assign)ShowType showType ;//展示的类型
@property (nonatomic,assign)ShowTextStatus showTextStatus ;//展示的类型


@property (nonatomic,strong)EasyShowOptions *options ;
@property (nonatomic,assign)BOOL isShowedStatusBar ;
@property (nonatomic,assign)BOOL isShowedNavigation ;



- (void)showViewWithSuperView:(UIView *)superView ;
- (void)removeSelfFromSuperView ;

//获取显示区域的大小。
- (CGRect)showRectWithSpuerView:(UIView *)superView ;



@end
