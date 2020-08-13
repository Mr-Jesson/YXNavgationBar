//
//  YXNavigationBar.m
//  YXNavgationBar
//
//  Created by Mr_Jesson on 2020/7/28.
//  Copyright © 2020 zzyxx. All rights reserved.
//

#import "YXNavigationBar.h"
#import <objc/runtime.h>
#import "sys/utsname.h"

@implementation YXNavigationBar

+ (CGFloat)navBarBottom {
    return isFullIphone ? 88 : 64;
}
+ (CGFloat)tabBarHeight {
    return isFullIphone ? 83 : 49;
}
+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end

//=============================================================================
#pragma mark - default navigationBar barTintColor、tintColor and statusBarStyle YOU CAN CHANGE!!!
//=============================================================================
@implementation YXNavigationBar (YXDefault)

static char kYXIsLocalUsedKey;
static char kYXWhiteistKey;
static char kYXBlacklistKey;

static char kYXDefaultNavBarBarTintColorKey;
static char kYXDefaultNavBarBackgroundImageKey;
static char kYXDefaultNavBarTintColorKey;
static char kYXDefaultNavBarTitleColorKey;
static char kYXDefaultStatusBarStyleKey;
static char kYXDefaultNavBarShadowImageHiddenKey;

+ (BOOL)isLocalUsed {
    id isLocal = objc_getAssociatedObject(self, &kYXIsLocalUsedKey);
    return (isLocal != nil) ? [isLocal boolValue] : NO;
}
+ (void)yx_local {
    objc_setAssociatedObject(self, &kYXIsLocalUsedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)yx_widely {
    objc_setAssociatedObject(self, &kYXIsLocalUsedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray<NSString *> *)whitelist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kYXWhiteistKey);
    return (list != nil) ? list : nil;
}
+ (void)yx_setWhitelist:(NSArray<NSString *> *)list {
    NSAssert([self isLocalUsed], @"白名单是在设置 局部使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kYXWhiteistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (NSArray<NSString *> *)blacklist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &kYXBlacklistKey);
    return (list != nil) ? list : nil;
}
+ (void)yx_setBlacklist:(NSArray<NSString *> *)list {
    NSAssert(list, @"list 不能设置为nil");
    NSAssert(![self isLocalUsed], @"黑名单是在设置 广泛使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &kYXBlacklistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)needUpdateNavigationBar:(UIViewController *)vc {
    NSString *vcStr = NSStringFromClass(vc.class);
    if ([self isLocalUsed]) {
        return [[self whitelist] containsObject:vcStr]; // 当白名单里 有 表示需要更新
    } else {
        return ![[self blacklist] containsObject:vcStr];// 当黑名单里 没有 表示需要更新
    }
}

+ (UIColor *)defaultNavBarBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kYXDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}
+ (void)yx_setDefaultNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kYXDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)yx_setDefaultNavBarBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kYXDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kYXDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)yx_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kYXDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)yx_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &kYXDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)yx_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kYXDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kYXDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)yx_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kYXDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha {
    return 1.0;
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent {
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat neYXed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:neYXed green:newGreen blue:newBlue alpha:newAlpha];
}
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end


//=============================================================================
#pragma mark - UINavigationBar
//=============================================================================
@implementation UINavigationBar (YXAddition)

static char kYXBackgroundViewKey;
static char kYXBackgroundImageViewKey;
static char kYXBackgroundImageKey;

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kYXBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView {
    if (backgroundView) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yx_keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yx_keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    objc_setAssociatedObject(self, &kYXBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kYXBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kYXBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)backgroundImage {
    return (UIImage *)objc_getAssociatedObject(self, &kYXBackgroundImageKey);
}
- (void)setBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kYXBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar backgroundImage
- (void)yx_setBackgroundImage:(UIImage *)image {
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0) {
            self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [YXNavigationBar navBarBottom])];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            // _UIBarBackground is first subView for navigationBar
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        }
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

// set navigationBar barTintColor
- (void)yx_setBackgroundColor:(UIColor *)color {
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil) {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [YXNavigationBar navBarBottom])];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

- (void)yx_keyboardDidShow {
    [self yx_restoreUIBarBackgroundFrame];
}
- (void)yx_keyboardWillHide {
    [self yx_restoreUIBarBackgroundFrame];
}
- (void)yx_restoreUIBarBackgroundFrame {
    // IQKeyboardManager change _UIBarBackground frame sometimes, so I need restore it
    for (UIView *view in self.subviews) {
        Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
        if (_UIBarBackgroundClass != nil) {
            if ([view isKindOfClass:_UIBarBackgroundClass]) {
                view.frame = CGRectMake(0, self.frame.size.height-[YXNavigationBar navBarBottom], [YXNavigationBar screenWidth], [YXNavigationBar navBarBottom]);
            }
        }
    }
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)yx_setBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {   // sometimes we can't change _UIBarBackground alpha
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

- (void)yx_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator {
    for (UIView *view in self.subviews) {
        if (hasSystemBackIndicator == YES)
        {   // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil) {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil) {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO) {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil) {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil) {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离   CGAffineTransformMakeTranslation  平移
- (void)yx_setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)yx_getTranslationY {
    return self.transform.ty;
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[1] = {
            @selector(setTitleTextAttributes:)
        };
      
        for (int i = 0; i < 1;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [NSString stringWithFormat:@"yx_%@", NSStringFromSelector(selector)];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)yx_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes {
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self yx_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self yx_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self yx_setTitleTextAttributes:newTitleTextAttributes];
}

@end

@interface UIViewController (Addition)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
@end

//==========================================================================
#pragma mark - UINavigationController
//==========================================================================
@implementation UINavigationController (YXAddition)

static CGFloat YXPopDuration = 0.12;
static int YXPopDisplayCount = 0;
- (CGFloat)YXPopProgress {
    CGFloat all = 60 * YXPopDuration;
    int current = MIN(all, YXPopDisplayCount);
    return current / all;
}

static CGFloat YXPushDuration = 0.10;
static int YXPushDisplayCount = 0;
- (CGFloat)YXPushProgress {
    CGFloat all = 60 * YXPushDuration;
    int current = MIN(all, YXPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController yx_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar yx_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar yx_setBackgroundColor:barTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar yx_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor {
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress {
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC yx_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC yx_navBarBarTintColor];
    UIColor *newBarTintColor = [YXNavigationBar middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    if ([YXNavigationBar needUpdateNavigationBar:fromVC] || [YXNavigationBar needUpdateNavigationBar:toVC]) {
        [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    }
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC yx_navBarTintColor];
    UIColor *toTintColor = [toVC yx_navBarTintColor];
    UIColor *newTintColor = [YXNavigationBar middleColor:fromTintColor toColor:toTintColor percent:progress];
    if ([YXNavigationBar needUpdateNavigationBar:fromVC]) {
        [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    }

    // change navBarTitleColor（在yx_popToViewController:animated:方法中直接改变标题颜色）
    UIColor *fromTitleColor = [fromVC yx_navBarTitleColor];
    UIColor *toTitleColor = [toVC yx_navBarTitleColor];
    UIColor *newTitleColor = [YXNavigationBar middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC yx_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC yx_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [YXNavigationBar middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            NSSelectorFromString(@"_updateInteractiveTransition:"),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(pushViewController:animated:)
        };
      
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"yx_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (NSArray<UIViewController *> *)yx_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // pop 的时候直接改变 barTintColor、tintColor
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController yx_navBarTitleColor]];
    [self setNeedsNavigationBarUpdateForTintColor:[viewController yx_navBarTintColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        YXPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:YXPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self yx_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)yx_popToRootViewControllerAnimated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        YXPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:YXPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self yx_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        YXPopDisplayCount += 1;
        CGFloat popProgress = [self YXPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)yx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        YXPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:YXPushDuration];
    [CATransaction begin];
    [self yx_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        YXPushDisplayCount += 1;
        CGFloat pushProgress = [self YXPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        } else {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIViewController *vc = [context viewControllerForKey:key];
        UIColor *curColor = [vc yx_navBarBarTintColor];
        CGFloat curAlpha = [vc yx_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES) {
        double cancelDuration = 0;
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)yx_updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    [self yx_updateInteractiveTransition:percentComplete];
}

@end


//==========================================================================
#pragma mark - UIViewController
//==========================================================================
@implementation UIViewController (YXAddition)

static char kYXPushToCurrentVCFinishedKey;
static char kYXPushToNextVCFinishedKey;
static char kYXNavBarBackgroundImageKey;
static char kYXNavBarBarTintColorKey;
static char kYXNavBarBackgroundAlphaKey;
static char kYXNavBarTintColorKey;
static char kYXNavBarTitleColorKey;
static char kYXStatusBarStyleKey;
static char kYXNavBarShadowImageHiddenKey;
static char kYXCustomNavBarKey;
static char kYXSystemNavBarBarTintColorKey;
static char kYXSystemNavBarTintColorKey;
static char kYXSystemNavBarTitleColorKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kYXPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kYXPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kYXPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kYXPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)yx_navBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kYXNavBarBackgroundImageKey);
    image = (image == nil) ? [YXNavigationBar defaultNavBarBackgroundImage] : image;
    return image;
}
- (void)yx_setNavBarBackgroundImage:(UIImage *)image {
    if ([[self yx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self yx_customNavBar];
    //  [navBar yx_setBackgroundImage:image];
    } else {
        objc_setAssociatedObject(self, &kYXNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar systemBarTintColor
- (UIColor *)yx_systemNavBarBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kYXSystemNavBarBarTintColorKey);
}
- (void)yx_setSystemNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXSystemNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)yx_navBarBarTintColor {
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kYXNavBarBarTintColorKey);
    if (![YXNavigationBar needUpdateNavigationBar:self]) {
        if ([self yx_systemNavBarBarTintColor] == nil) {
            barTintColor = self.navigationController.navigationBar.barTintColor;
        } else {
            barTintColor = [self yx_systemNavBarBarTintColor];
        }
    }
    return (barTintColor != nil) ? barTintColor : [YXNavigationBar defaultNavBarBarTintColor];
}
- (void)yx_setNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self yx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self yx_customNavBar];
    //  [navBar yx_setBackgroundColor:color];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)yx_navBarBackgroundAlpha {
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kYXNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [YXNavigationBar defaultNavBarBackgroundAlpha];
}
- (void)yx_setNavBarBackgroundAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, &kYXNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self yx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self yx_customNavBar];
    //  [navBar yx_setBackgroundAlpha:alpha];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar systemTintColor
- (UIColor *)yx_systemNavBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kYXSystemNavBarTintColorKey);
}
- (void)yx_setSystemNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXSystemNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar tintColor
- (UIColor *)yx_navBarTintColor {
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kYXNavBarTintColorKey);
    if (![YXNavigationBar needUpdateNavigationBar:self]) {
        if ([self yx_systemNavBarTintColor] == nil) {
            tintColor = self.navigationController.navigationBar.tintColor;
        } else {
            tintColor = [self yx_systemNavBarTintColor];
        }
    }
    return (tintColor != nil) ? tintColor : [YXNavigationBar defaultNavBarTintColor];
}
- (void)yx_setNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self yx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self yx_customNavBar];
    //  navBar.tintColor = color;
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBar systemTitleColor
- (UIColor *)yx_systemNavBarTitleColor {
    return (UIColor *)objc_getAssociatedObject(self, &kYXSystemNavBarTitleColorKey);
}
- (void)yx_setSystemNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXSystemNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBarTitleColor
- (UIColor *)yx_navBarTitleColor {
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kYXNavBarTitleColorKey);
    if (![YXNavigationBar needUpdateNavigationBar:self]) {
        if ([self yx_systemNavBarTitleColor] == nil) {
            titleColor = self.navigationController.navigationBar.titleTextAttributes[@"NSColor"];
        } else {
            titleColor = [self yx_systemNavBarTitleColor];
        }
    }
    return (titleColor != nil) ? titleColor : [YXNavigationBar defaultNavBarTitleColor];
}
- (void)yx_setNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kYXNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self yx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self yx_customNavBar];
    //  navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)yx_statusBarStyle {
    id style = objc_getAssociatedObject(self, &kYXStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [YXNavigationBar defaultStatusBarStyle];
}
- (void)yx_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kYXStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)yx_setNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kYXNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}
- (BOOL)yx_navBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kYXNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [YXNavigationBar defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)yx_customNavBar {
    UIView *navBar = objc_getAssociatedObject(self, &kYXCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)yx_setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, &kYXCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       SEL needSwizzleSelectors[4] = {
           @selector(viewWillAppear:),
           @selector(viewWillDisappear:),
           @selector(viewDidAppear:),
           @selector(viewDidDisappear:)
       };
        
       for (int i = 0; i < 4;  i++) {
           SEL selector = needSwizzleSelectors[i];
           NSString *newSelectorStr = [NSString stringWithFormat:@"yx_%@", NSStringFromSelector(selector)];
           Method originMethod = class_getInstanceMethod(self, selector);
           Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
           method_exchangeImplementations(originMethod, swizzledMethod);
       }
    });
}

- (void)yx_viewWillAppear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        if (![YXNavigationBar needUpdateNavigationBar:self]) {
            if ([self yx_systemNavBarBarTintColor] == nil) {
                [self yx_setSystemNavBarBarTintColor:[self yx_navBarBarTintColor]];
            }
            if ([self yx_systemNavBarTintColor] == nil) {
                [self yx_setSystemNavBarTintColor:[self yx_navBarTintColor]];
            }
            if ([self yx_systemNavBarTitleColor] == nil) {
                [self yx_setSystemNavBarTitleColor:[self yx_navBarTitleColor]];
            }
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self yx_navBarTintColor]];
        }
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self yx_navBarTitleColor]];
    }
    [self yx_viewWillAppear:animated];
    
    if ([self isRootViewController] == NO) {
        self.pushToCurrentVCFinished = YES;
    }
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self yx_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            if ([YXNavigationBar needUpdateNavigationBar:self]) {
                [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self yx_navBarBarTintColor]];
            }
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self yx_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self yx_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self yx_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self yx_navBarShadowImageHidden]];
    }
}

- (void)yx_viewWillDisappear:(BOOL)animated {
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self yx_viewWillDisappear:animated];
}

- (void)yx_viewDidAppear:(BOOL)animated
{
//    if ([self isRootViewController] == NO) {
//        self.pushToCurrentVCFinished = YES;
//    }
//    if ([self canUpdateNavigationBar] == YES)
//    {
//        UIImage *barBgImage = [self yx_navBarBackgroundImage];
//        if (barBgImage != nil) {
//            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
//        } else {
//            if ([YXNavigationBar needUpdateNavigationBar:self]) {
//                [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self yx_navBarBarTintColor]];
//            }
//        }
//        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self yx_navBarBackgroundAlpha]];
//        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self yx_navBarTintColor]];
//        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self yx_navBarTitleColor]];
//        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self yx_navBarShadowImageHidden]];
//    }
//    [self yx_viewDidAppear:animated];
}

- (void)yx_viewDidDisappear:(BOOL)animated {
    if (![YXNavigationBar needUpdateNavigationBar:self] && !self.navigationController) {
        [self yx_setSystemNavBarBarTintColor:nil];
        [self yx_setSystemNavBarTintColor:nil];
        [self yx_setSystemNavBarTitleColor:nil];
    }
    [self yx_viewDidDisappear:animated];
}

- (BOOL)canUpdateNavigationBar {
    return [self.navigationController.viewControllers containsObject:self];
}

- (BOOL)isRootViewController
{
    UIViewController *rootViewController = self.navigationController.viewControllers.firstObject;
    if ([rootViewController isKindOfClass:[UITabBarController class]] == NO) {
        return rootViewController == self;
    } else {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [tabBarController.viewControllers containsObject:self];
    }
}


@end
