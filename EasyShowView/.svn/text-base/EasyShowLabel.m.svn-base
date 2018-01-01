//
//  EasyShowLabel.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/12/20.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyShowLabel.h"

@interface EasyShowLabel()

@property (nonatomic) UIEdgeInsets contentInset;

@end

@implementation EasyShowLabel


- (instancetype)initWithContentInset:(UIEdgeInsets)contentInset
{
    if (self = [super init]) {
        _contentInset = contentInset ;
    }
    return self ;
}
- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    NSString *tempString = self.text;
    self.text = @"";
    self.text = tempString;
}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    UIEdgeInsets insets = self.contentInset;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}
-(void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentInset)];
}

@end
