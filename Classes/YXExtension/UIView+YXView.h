//
//  UIView+YXView.h
//  YXNavgationBar
//
//  Created by Mr_Jesson on 2020/8/3.
//  Copyright © 2020 zzyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YXView)

///设置圆角
- (void)yx_setCordWithCornerRadius:(CGFloat)cornerRadius hasBorder:(BOOL)isBorder borderWidth:(CGFloat)width borderColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
