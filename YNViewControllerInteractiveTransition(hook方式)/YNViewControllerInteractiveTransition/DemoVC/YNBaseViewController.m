//
//  YNBaseViewController.m
//  YNViewControllerInteractiveTransition
//
//  Created by ZYN on 17/2/8.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNBaseViewController.h"

@interface YNBaseViewController ()

@end

/// 在YNViewControllerInteractiveTransition.m 进行了hook
@implementation YNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _interactiveTransition = [YNViewControllerInteractiveTransition interactiveTransitionWithViewController:self];
//    _interactiveTransition.viewControllerAnimationType = ViewControllerAnimationTypeSlider;
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /// 设置代理
//    self.navigationController.delegate = _interactiveTransition;
}

@end
