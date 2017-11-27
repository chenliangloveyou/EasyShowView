//
//  EasyShowBgView.h
//  EasyShowViewDemo
//
//  Created by Mr_Chen on 2017/11/27.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowStatus) {
    
    ShowStatusText ,    /** 纯文字 */
    ShowStatusSuccess, /** 成功 */
    ShowStatusError,   /** 失败 */
    ShowStatusInfo,    /** 提示 */
    ShowStatusScore,   /** 积分 */
    ShowStatusImage,   /** 自定义图片 */
    ShwoStatusLoding,  /** 正在加载 */
};

@interface EasyShowBgView : UIView

- (instancetype)initWithFrame:(CGRect)frame status:(ShowStatus)status text:(NSString *)text image:(UIImage *)image ;

@end
