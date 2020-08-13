//
//  UIButton+YXButton.m
//  YXNavgationBar
//
//  Created by Mr_Jesson on 2020/8/3.
//  Copyright © 2020 zzyxx. All rights reserved.
//

#import "UIButton+YXButton.h"
#import <objc/runtime.h>

static const void *UtilityKey = &UtilityKey;

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (YXButton)

@dynamic actionHandler;

- (ButtonClickAcitonHandler)actionHandler
{
    return objc_getAssociatedObject(self, UtilityKey);
}

- (void)setActionHandler:(ButtonClickAcitonHandler)actionHandler
{
    objc_setAssociatedObject(self, UtilityKey, actionHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIButton *)yx_createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius target:(id)target  buttonClickAction:(ButtonClickAcitonHandler)handler
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.backgroundColor = backgroundColor;
    btn.titleLabel.font = font;
    if (cornerRadius > 0) {
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = cornerRadius;
    }
    [btn addTarget:target action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.actionHandler = handler;
    return btn;
}

- (void)backAction:(id)send
{
    if (self.actionHandler) {
        self.actionHandler(send);
    }
}

- (void)yx_setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect rect = [self enlargedRect];
    //如果按钮设置为不可点击、隐藏、透明度小于等于0.01或者点击在按钮内部，则直接执行父类方法
    if (CGRectEqualToRect(rect, self.bounds) || self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return [super hitTest:point withEvent:event];
    }
    //判断点击是否在放大的范围内
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end
