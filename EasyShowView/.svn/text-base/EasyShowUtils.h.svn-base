//
//  EasyShowUtils.h
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 是否为空
#define ISEMPTY_S(_v) (_v == nil || _v.length == 0)


//屏幕宽度
#define  SCREEN_WIDTH_S [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define  SCREEN_HEIGHT_S [[UIScreen mainScreen] bounds].size.height
//屏幕的高度
#define SCREEN_MAX_LENGTH_S (MAX(SCREEN_WIDTH_S, SCREEN_HEIGHT_S))

//屏幕是否是横屏状态
#define ISHORIZONTALSCREEM_S UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)
//retain屏
#define ISRETAIN_S ([[UIScreen mainScreen] scale] >= 2.0)
//屏幕尺寸判断
#define ISIPHONE_S   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//#define ISIPHONE_4  (ISIPHONE && SCREEN_MAX_LENGTH == 480.0f)  // 4/4s            3.5寸   320*480
//#define ISIPHONE_5  (ISIPHONE && SCREEN_MAX_LENGTH == 568.0f)  // 5/5s/se           4寸   320*568
//#define ISIPHONE_6  (ISIPHONE && SCREEN_MAX_LENGTH == 667.0f)  // 6/6s/7/8        4.7寸   375*667
//#define ISIPHONE_6P (ISIPHONE && SCREEN_MAX_LENGTH == 736.0f)  // 6p/6ps/7p/8p    5.5寸   414*736
#define ISIPHONE_X_S  (ISIPHONE_S && SCREEN_MAX_LENGTH_S == 812.0f)  // iPhonex         5.8寸   375*812

//iOS版本判断
//#define SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
//#define IS_IOS7_OR_LATER (SYSTEM_VERSION >= 7.0)
//#define IS_IOS8_OR_LATER (SYSTEM_VERSION >= 8.0)
//#define IS_IOS9_OR_LATER (SYSTEM_VERSION >= 9.0)
//#define IS_IOS10_OR_LATER (SYSTEM_VERSION >= 10.0)
//#define IS_IOS11_OR_LATER (SYSTEM_VERSION >= 11.0)


//statusbar默认高度 orginal
#define STATUSBAR_HEIGHT_S  (ISIPHONE_X_S ? (50) : 20 )

//导航栏原始高度
#define kNavNormalHeight_S 44.0f

//大标题增加出来的高度
#define kNavBigTitleHeight_S 55.0f

#define kEasyShowSafeBottomMargin_S  (ISIPHONE_X_S ? 34.0f : 0.0f )

//状态栏高度
#define NAVIGATION_HEIGHT_S (STATUSBAR_HEIGHT_S + kNavNormalHeight_S)
//#define STATUSBAR_HEIGHT (ISHORIZONTALSCREEM ? (ISIPHONE_X ? 0 : STATUSBAR_HEIGHT) : STATUSBAR_HEIGHT )




@interface EasyShowUtils : NSObject

+ (CGSize)textWidthWithStirng:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)maxWidth ;

+ (UIViewController *)topViewController ;

+ (UIImage *)imageWithColor:(UIColor *)color ;
@end













