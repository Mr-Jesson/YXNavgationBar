//
//  YXNavigationBar.h
//  YXNavgationBar
//
//  Created by Mr_Jesson on 2020/7/28.
//  Copyright © 2020 zzyxx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define isFullIphone \
({BOOL isFull = NO;\
    if(@available(iOS 13.0, *)){\
        if([UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height > 20){\
            isFull = YES;\
        }\
    }\
    else{\
        if([[UIApplication sharedApplication] statusBarFrame].size.height>20){\
            isFull = YES;\
        }\
    }\
(isFull);})

@interface YXNavigationBar : UIView
+ (CGFloat)navBarBottom;
+ (CGFloat)tabBarHeight;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

@end


#pragma mark - Default
@interface YXNavigationBar (YXDefault)

/// 局部使用该库       待开发
//+ (void)yx_local;
/// 广泛使用该库       default 暂时是默认， yx_local 完成后，yx_local就会变成默认
+ (void)yx_widely;

/// 局部使用该库时，设置需要用到的控制器      待开发
//+ (void)yx_setWhitelist:(NSArray<NSString *> *)list;
/// 广泛使用该库时，设置需要屏蔽的控制器
+ (void)yx_setBlacklist:(NSArray<NSString *> *)list;

/** set default barTintColor of UINavigationBar */
+ (void)yx_setDefaultNavBarBarTintColor:(UIColor *)color;

/** set default barBackgroundImage of UINavigationBar */
/** warning: yx_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//+ (void)yx_setDefaultNavBarBackgroundImage:(UIImage *)image;

/** set default tintColor of UINavigationBar */
+ (void)yx_setDefaultNavBarTintColor:(UIColor *)color;

/** set default titleColor of UINavigationBar */
+ (void)yx_setDefaultNavBarTitleColor:(UIColor *)color;

/** set default statusBarStyle of UIStatusBar */
+ (void)yx_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)yx_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end



#pragma mark - UINavigationBar
@interface UINavigationBar (YXAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)yx_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)yx_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)yx_getTranslationY;

@end




#pragma mark - UIViewController
@interface UIViewController (YXAddition)

/** record current ViewController navigationBar backgroundImage */
/** warning: yx_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//- (void)yx_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)yx_navBarBackgroundImage;

/** record current ViewController navigationBar barTintColor */
- (void)yx_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)yx_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)yx_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)yx_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)yx_setNavBarTintColor:(UIColor *)color;
- (UIColor *)yx_navBarTintColor;

/** record current ViewController titleColor */
- (void)yx_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)yx_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)yx_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)yx_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)yx_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)yx_navBarShadowImageHidden;

@end
