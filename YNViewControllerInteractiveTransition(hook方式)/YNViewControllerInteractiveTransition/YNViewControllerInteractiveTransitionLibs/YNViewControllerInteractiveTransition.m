//
//  YNInteractiveTransition.m
//  YNTest
//
//  Created by ZYN on 17/2/7.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNViewControllerInteractiveTransition.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, PanStateDirectionType) {
    PanStateDirectionTypeNone = 0,
    PanStateDirectionTypeLeft = 1,
    PanStateDirectionTypeRight = 2,
};

@interface YNViewControllerInteractiveTransition () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) YNViewControllerPopSliderAnimation *popSliderAnimation;
@property (nonatomic, strong) YNViewControllerPushSliderAnimation *pushSliderAnimation;

@property (nonatomic, strong) YNViewControllerPopScaleAnimation *popScaleAnimation;
@property (nonatomic, strong) YNViewControllerPushScaleAnimation *pushScaleAnimation;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, assign) PanStateDirectionType panStateDirectionType;

@end

@implementation YNViewControllerInteractiveTransition


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _popSliderAnimation = [[YNViewControllerPopSliderAnimation alloc] init];
        _pushSliderAnimation = [[YNViewControllerPushSliderAnimation alloc] init];
        
        _popScaleAnimation = [[YNViewControllerPopScaleAnimation alloc] init];
        _pushScaleAnimation = [[YNViewControllerPushScaleAnimation alloc] init];
        
        _viewControllerAnimationType = ViewControllerAnimationTypeSlider;
    }
    return self;
}

+ (instancetype)interactiveTransitionWithViewController:(UIViewController *)viewController {
    
    YNViewControllerInteractiveTransition *transition = [[self alloc] init];
    viewController.yn_banLeftGesture = NO;
    viewController.yn_banRightGesture = YES;
    transition.viewController = viewController;
   
    [transition addPanGestureRecognizerWithViewController:viewController gestureType:GestureTypeUIPanGestureRecognizer];
    
    return transition;
}

- (void)addPanGestureRecognizerWithViewController:(UIViewController *)viewController gestureType:(GestureType)type{
    
    if (_panGestureRecognizer) {
        [viewController.view removeGestureRecognizer:_panGestureRecognizer]; 
    }
    
    if (type == GestureTypeUIScreenEdgePanGestureRecognizer) {
        
        UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [gestureRecognizer setDelegate:self];
        [gestureRecognizer setEdges:UIRectEdgeLeft];
        [gestureRecognizer setEdges:UIRectEdgeRight];
        [viewController.view addGestureRecognizer:gestureRecognizer];
    
        _panGestureRecognizer = gestureRecognizer;
        
    } else {
        
        UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [gestureRecognizer setDelegate:self];
        [viewController.view addGestureRecognizer:gestureRecognizer];
        
        _panGestureRecognizer = gestureRecognizer;
    }
    
    
}


- (void)setGestureType:(GestureType)gestureType {
    
    _gestureType = gestureType;
    
    [self addPanGestureRecognizerWithViewController:_viewController gestureType:gestureType];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    
    if([gestureRecognizer translationInView:_viewController.view].x >= 0 && _panStateDirectionType !=PanStateDirectionTypeRight)
    {
        //手势滑动的比例
        CGFloat tranX = [gestureRecognizer translationInView:_viewController.view].x;
        CGFloat per = tranX / (_viewController.view.bounds.size.width);

        per = MIN(1.0,(MAX(0.0, per)));
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            _panStateDirectionType = PanStateDirectionTypeLeft;
            _interactiveTransition = [UIPercentDrivenInteractiveTransition new];
            [_viewController.navigationController popViewControllerAnimated:YES];
            
        }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            [_interactiveTransition updateInteractiveTransition:per];
        }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled || gestureRecognizer.state == UIGestureRecognizerStateFailed){
            /// 完成时的比例
            if (per > 0.3) {
                
                [_interactiveTransition finishInteractiveTransition];
                
            }else{
                [_interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
            
            _panStateDirectionType = PanStateDirectionTypeNone;
        }
    } else if ([gestureRecognizer translationInView:_viewController.view].x <= 0 && _panStateDirectionType != PanStateDirectionTypeLeft && !_viewController.yn_banRightGesture) {
        //手势滑动的比例
        CGFloat tranX = ABS([gestureRecognizer translationInView:_viewController.view].x);
        CGFloat per = tranX / (_viewController.view.bounds.size.width);
        
        per = MIN(1.0,(MAX(0.0, per)));
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            _panStateDirectionType = PanStateDirectionTypeRight;
            _interactiveTransition = [UIPercentDrivenInteractiveTransition new];
            
            NSAssert(_pushViewController != nil, @"您忘记请提供一个push控制器了~~~");
            
            [_viewController.navigationController pushViewController:_pushViewController animated:YES];
            
        }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
            [_interactiveTransition updateInteractiveTransition:per];
        }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled || gestureRecognizer.state == UIGestureRecognizerStateFailed){
            /// 完成时的比例
            if (per > 0.5) {
                
                [_interactiveTransition finishInteractiveTransition];
                
            }else{
                [_interactiveTransition cancelInteractiveTransition];
            }
            self.interactiveTransition = nil;
            
            _panStateDirectionType = PanStateDirectionTypeNone;
        }
    }
    
    else if ((gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled || gestureRecognizer.state == UIGestureRecognizerStateFailed))
    {
        [_interactiveTransition cancelInteractiveTransition];
        self.interactiveTransition = nil;
        _panStateDirectionType = PanStateDirectionTypeNone;
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return !_viewController.yn_banLeftGesture;
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        if (_viewController.yn_banPushAnimation) {
            return nil;
        }
        if (_viewControllerAnimationType == ViewControllerAnimationTypeSlider) {
            return _pushSliderAnimation;
        } else {
            return _pushScaleAnimation;
        }
        
    } else if (operation == UINavigationControllerOperationPop) {
        if (_viewController.yn_banPopAnimation) {
            return nil;
        }
        if (_viewControllerAnimationType == ViewControllerAnimationTypeSlider) {
            return _popSliderAnimation;
        } else {
            return _popScaleAnimation;
        }
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    return self.interactiveTransition;
}

@end



@implementation UIViewController (YNInteractiveTransition)


/// hook
+ (void)load {

    [self swizzleInstanceMethod:@selector(viewDidLoad) with:@selector(yn_viewDidLoad)];
    
    [self swizzleInstanceMethod:@selector(viewWillAppear:) with:@selector(yn_viewWillAppear:)];
};

- (void)yn_viewDidLoad {
    [self yn_viewDidLoad];
    
    YNViewControllerInteractiveTransition *transition = [YNViewControllerInteractiveTransition interactiveTransitionWithViewController:self];
    
    self.interactiveTransition = transition;
    
}

- (void)yn_viewWillAppear:(BOOL)animated {
    [self yn_viewWillAppear:animated];
    
    self.navigationController.delegate = self.interactiveTransition;
    
}


- (BOOL)yn_banLeftGesture {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYn_banLeftGesture:(BOOL)yn_banLeftGesture {
    objc_setAssociatedObject(self, NSSelectorFromString(@"yn_banLeftGesture"), @(yn_banLeftGesture),OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)yn_banRightGesture {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYn_banRightGesture:(BOOL)yn_banRightGesture {
    objc_setAssociatedObject(self, NSSelectorFromString(@"yn_banRightGesture"), @(yn_banRightGesture),OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)yn_banPopAnimation {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYn_banPopAnimation:(BOOL)yn_banPopAnimation {
    
    objc_setAssociatedObject(self, NSSelectorFromString(@"yn_banPopAnimation"), @(yn_banPopAnimation),OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)yn_banPushAnimation {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setYn_banPushAnimation:(BOOL)yn_banPushAnimation {
    
    objc_setAssociatedObject(self, NSSelectorFromString(@"yn_banPushAnimation"), @(yn_banPushAnimation),OBJC_ASSOCIATION_ASSIGN);
}

- (YNViewControllerInteractiveTransition *)interactiveTransition {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setInteractiveTransition:(YNViewControllerInteractiveTransition *)interactiveTransition {
    objc_setAssociatedObject(self, NSSelectorFromString(@"interactiveTransition"), interactiveTransition,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    
    return YES;
}


@end

