//
//  EasyShowView+Alert.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/30.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowView+Alert.h"
#import <objc/runtime.h>

#import "EasyShowUtils.h"

#import "EasyShowAlertBgView.h"

@interface EasyShowView()

//@property (nonatomic,strong)showAlertCallback showAlertCallback ;

@end

@implementation EasyShowView (Alert)

//- (showAlertCallback)showAlertCallback
//{
//    return objc_getAssociatedObject(self, _cmd);
//}
//- (void)setShowAlertCallback:(showAlertCallback)showAlertCallback
//{
//    [self willChangeValueForKey:@"showAlertCallback"];
//    objc_setAssociatedObject(self, @selector(showAlertCallback), showAlertCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    [self didChangeValueForKey:@"showAlertCallback"];
//}


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    if (self = [super init]) {
        
    }
    return self ;
}
+ (instancetype)showActionSheetWithTitle:(NSString *)title message:(NSString *)message
{
    if (ISEMPTY(title) && ISEMPTY(message)) {
        NSAssert(NO, @"you should set title or message") ;
        return nil;
    }
    EasyShowView *showView = [EasyShowView showAlertWithTitle:title message:message];
    return showView ;
}

- (void)addItemWithTitle:(NSString *)title itemType:(ShowAlertItemType)itemType callback:(alertItemCallback)callback
{
    EasyShowAlertItem *item = [[EasyShowAlertItem alloc]init];
    item.title = title ;
    item.itemTpye = itemType ;
    item.callback = callback ;
    [self addAlertItem:item];
}
- (void)show
{
    [self showAlert];
}












//+ (void)showAlertSystemWithTitle:(NSString *)title
//                            desc:(NSString *)desc
//                     buttonArray:(NSArray *)buttonArray
//                        callBack:(showAlertCallback)callback
//{
//    
//    
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:desc preferredStyle:UIAlertControllerStyleActionSheet];
//        
//        [buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSString *tempTitle = (NSString *)obj ;
//            
//            UIAlertActionStyle showStyle = UIAlertActionStyleDefault ;
//            if (idx == 0) {
//                showStyle = UIAlertActionStyleDestructive ;
//            }
//            else if (idx == 1){
//                showStyle = UIAlertActionStyleCancel ;
//            }
//            UIAlertAction *action = [UIAlertAction actionWithTitle:tempTitle style:showStyle handler:^(UIAlertAction *action){
//                dispatch_after(0.2, dispatch_get_main_queue(), ^{
////                    if (sure) sure() ;
//                    [alertController dismissViewControllerAnimated:YES completion:nil];
//                });
//            }];
//            [alertController addAction:action];
//            
//        }];
//        
//        
////        UIAlertAction *action2 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
////
////            dispatch_after(0.2, dispatch_get_main_queue(), ^{
////                if (cancel)  cancel() ;
////                [alertController dismissViewControllerAnimated:YES completion:nil];
////            });
////        }];
////        [alertController addAction:action2];
//        [kTopViewController presentViewController:alertController animated:YES completion:nil];
//    }
//    else{
//        
////        if (ISEMPTY(sureTitle)) {
////
////            _alertMessageCancel = cancel ;
////            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:contentMessage delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
////            [alertView show];
////        }
////        else{
////
////            _alertMessageSure = sure ;
////            _alertMessageCancel = cancel ;
////            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:contentMessage delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:sureTitle, nil];
////            [alertView show];
////        }
//    }
//    
//}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (buttonIndex == 0) {
//        if(_alertMessageCancel) _alertMessageCancel() ;
//    }
//    else if (buttonIndex == 1){
//        if(_alertMessageSure) _alertMessageSure() ;
//    }
}
@end
