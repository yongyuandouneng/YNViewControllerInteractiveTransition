//
//  YNBaseViewController.h
//  YNViewControllerInteractiveTransition
//
//  Created by ZYN on 17/2/8.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//  公共控制器

#import <UIKit/UIKit.h>
#import "YNViewControllerInteractiveTransition.h"

@interface YNBaseViewController : UIViewController

/// 交互动画
@property (nonatomic, strong) YNViewControllerInteractiveTransition *interactiveTransition;


@end
