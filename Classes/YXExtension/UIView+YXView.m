//
//  UIView+YXView.m
//  YXNavgationBar
//
//  Created by Mr_Jesson on 2020/8/3.
//  Copyright © 2020 zzyxx. All rights reserved.
//

#import "UIView+YXView.h"

@implementation UIView (YXView)

- (void)yx_setCordWithCornerRadius:(CGFloat)cornerRadius hasBorder:(BOOL)isBorder borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    if (isBorder) {
        self.layer.borderWidth = width;
        self.layer.borderColor = color.CGColor;
    }
}

@end
