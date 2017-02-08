# YNViewControllerInteractiveTransition
####先上效果图

![](https://github.com/yongyuandouneng/YNViewControllerInteractiveTransition/blob/master/GifImage/YNNavigationControllerScaleGif2.gif)

喜欢就start鼓励一下，您在使用过程中有任何问题、出现任何(BUG、Crash)，请加QQ群538133294或联系我的扣扣1003580893.
---
```
#import <UIKit/UIKit.h>
#import "YNViewControllerAnimation.h"

typedef NS_ENUM(NSInteger, GestureType) {
    GestureTypeUIPanGestureRecognizer = 0,          /// 全屏 默认
    GestureTypeUIScreenEdgePanGestureRecognizer = 1, /// 边缘
};

typedef NS_ENUM(NSInteger, ViewControllerAnimationType) {
    ViewControllerAnimationTypeSlider = 0, /// 平滑 默认
    ViewControllerAnimationTypeScale = 1, /// 伸缩
};


@interface YNViewControllerInteractiveTransition : NSObject <UINavigationControllerDelegate>
/// 手势边缘类型
@property (nonatomic, assign) GestureType gestureType;
/// 动画模式
@property (nonatomic, assign) ViewControllerAnimationType viewControllerAnimationType;
/// 右滑动要push的控制器
@property (nonatomic, strong) UIViewController *pushViewController;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)interactiveTransitionWithViewController:(UIViewController *)viewController;

@end


/// 控制器分类
@interface UIViewController (YNInteractiveTransition)

/// 禁止左边手势 默认NO
@property (nonatomic, assign) BOOL yn_banLeftGesture;
/// 禁止右边手势 默认YES /// 开启后需要设置pushViewController
@property (nonatomic, assign) BOOL yn_banRightGesture;
/// 禁止push动画 默认NO
@property (nonatomic, assign) BOOL yn_banPushAnimation;
/// 禁止pop动画 默认NO
@property (nonatomic, assign) BOOL yn_banPopAnimation;

@property (nonatomic, strong) YNViewControllerInteractiveTransition *interactiveTransition;

@end


```
