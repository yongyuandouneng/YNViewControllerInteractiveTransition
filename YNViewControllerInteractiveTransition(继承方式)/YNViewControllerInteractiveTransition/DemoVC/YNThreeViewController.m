//
//  YNThreeViewController.m
//  YNViewControllerInteractiveTransition
//
//  Created by ZYN on 17/2/8.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNThreeViewController.h"
#import "YNOneViewController.h"

@interface YNThreeViewController ()

@end

@implementation YNThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (IBAction)buttonAction:(id)sender {
    UIViewController *VC = nil;

    for (UIViewController *v in self.navigationController.viewControllers) {
        if ([v isKindOfClass:[YNOneViewController class]]) {
            VC = v;
        }
    }
    [self.navigationController popToViewController:VC animated:YES];
}

@end
