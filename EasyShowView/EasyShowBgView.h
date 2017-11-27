//
//  EasyShowBgView.h
//  EFHealth
//
//  Created by nf on 16/7/20.
//  Copyright © 2016年 ef. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShowStatus) {
    
    ShowStatusText ,    /** 纯文字 */
    ShowStatusSuccess, /** 成功 */
    ShowStatusError,   /** 失败 */
    ShowStatusInfo,    /** 提示 */
    ShowStatusImage,   /** 自定义图片 */
    ShowStatusLoding,  /** 正在加载 */
};

@interface EasyShowBgView : UIView

- (instancetype)initWithFrame:(CGRect)frame status:(ShowStatus)status text:(NSString *)text image:(UIImage *)image ;

- (void)showStartAnimationWithDuration:(CGFloat)duration ;
- (void)showEndAnimationWithDuration:(CGFloat)duration  ;

@end
