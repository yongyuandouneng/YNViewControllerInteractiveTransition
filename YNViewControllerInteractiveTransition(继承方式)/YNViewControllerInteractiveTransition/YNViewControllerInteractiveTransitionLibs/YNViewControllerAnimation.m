//
//  YNViewControllerAnimation.m
//  YNTest
//
//  Created by ZYN on 17/2/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNViewControllerAnimation.h"

/// 动画时间
#define kYNViewControllerAnimationTime 0.5
/// 蒙版透明度
#define kYNViewControllerAlphaView 0.2

//// 平滑
#pragma mark - Pop

@implementation YNViewControllerPopSliderAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return kYNViewControllerAnimationTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    fromVC.view.frame = finalFrame;
    /// 阴影
    fromVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    fromVC.view.layer.shadowOffset = CGSizeMake(-3, 0);
    fromVC.view.layer.shadowOpacity = 0.2;
    
    /// toVC的蒙版
    UIView *alphaView = [[UIView alloc] initWithFrame:finalFrame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = kYNViewControllerAlphaView;
    
    
    toVC.view.frame = CGRectOffset(finalFrame, -finalFrame.size.width * 0.75, 0);
    
    [container addSubview:toVC.view];
    [container addSubview:alphaView];
    [container addSubview:fromVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = finalFrame;
        alphaView.alpha = 0.0;
        fromVC.view.frame = CGRectOffset(finalFrame, finalFrame.size.width, 0);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [alphaView removeFromSuperview];
        fromVC.view.layer.shadowColor = [UIColor clearColor].CGColor;
        
    }];
    
}


@end

#pragma mark - Push

@implementation YNViewControllerPushSliderAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return kYNViewControllerAnimationTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    fromVC.view.frame = finalFrame;
    /// 阴影
    toVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    toVC.view.layer.shadowOffset = CGSizeMake(-3, 0);
    toVC.view.layer.shadowOpacity = 0.2;
    
    /// fromVC的蒙版
    UIView *alphaView = [[UIView alloc] initWithFrame:finalFrame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.0;
    
    toVC.view.frame = CGRectOffset(finalFrame, finalFrame.size.width, 0);
    
    [container addSubview:fromVC.view];
    
    [container addSubview:alphaView];
    
    [container addSubview:toVC.view];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = finalFrame;
        alphaView.alpha = kYNViewControllerAlphaView;
        fromVC.view.frame = CGRectOffset(finalFrame, -finalFrame.size.width, 0);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [alphaView removeFromSuperview];
        fromVC.view.layer.shadowColor = [UIColor clearColor].CGColor;
        
    }];
    
}


@end


//// 伸缩
#pragma mark - Pop

@implementation YNViewControllerPopScaleAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return kYNViewControllerAnimationTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    fromVC.view.frame = finalFrame;
    /// 阴影
    fromVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    fromVC.view.layer.shadowOffset = CGSizeMake(-3, 0);
    fromVC.view.layer.shadowOpacity = 0.2;
    
    
    /// toVC的蒙版
    UIView *alphaView = [[UIView alloc] initWithFrame:finalFrame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = kYNViewControllerAlphaView;
    
    toVC.view.frame = CGRectMake(10, 15, finalFrame.size.width - 20, finalFrame.size.height - 30);
    ;
    
    [container addSubview:toVC.view];
    [container addSubview:alphaView];
    [container addSubview:fromVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = finalFrame;
        alphaView.alpha = 0.0;
        fromVC.view.frame = CGRectOffset(finalFrame, finalFrame.size.width, 0);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [alphaView removeFromSuperview];
        fromVC.view.layer.shadowColor = [UIColor clearColor].CGColor;
        
    }];
    
}


@end

#pragma mark - Push

@implementation YNViewControllerPushScaleAnimation


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return kYNViewControllerAnimationTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = [transitionContext containerView];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    fromVC.view.frame = finalFrame;
    /// 阴影
    toVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    toVC.view.layer.shadowOffset = CGSizeMake(-3, 0);
    toVC.view.layer.shadowOpacity = 0.2;
    
    /// fromVC的蒙版
    UIView *alphaView = [[UIView alloc] initWithFrame:finalFrame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.0;
    
    toVC.view.frame = CGRectOffset(finalFrame, finalFrame.size.width, 0);
    
    [container addSubview:fromVC.view];
    [container addSubview:alphaView];
    [container addSubview:toVC.view];
    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = finalFrame;
        alphaView.alpha = kYNViewControllerAlphaView;
        fromVC.view.frame = CGRectMake(10, 15, finalFrame.size.width - 20, finalFrame.size.height - 30);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [alphaView removeFromSuperview];
        fromVC.view.layer.shadowColor = [UIColor clearColor].CGColor;
        
    }];
    
    
}


@end
