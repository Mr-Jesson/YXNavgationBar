//
//  UIButton+YXButton.h
//  YXNavgationBar
//
//  Created by Mr_Jesson on 2020/8/3.
//  Copyright © 2020 zzyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickAcitonHandler)(UIButton * _Nullable btn);

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (YXButton)

@property (nonatomic, copy) ButtonClickAcitonHandler actionHandler;

+ (UIButton *)yx_createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius target:(id)target  buttonClickAction:(ButtonClickAcitonHandler)handler;


/// 增大button的点击区域
/// @param top top
/// @param right right
/// @param bottom bottom
/// @param left left
- (void)yx_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end

NS_ASSUME_NONNULL_END
