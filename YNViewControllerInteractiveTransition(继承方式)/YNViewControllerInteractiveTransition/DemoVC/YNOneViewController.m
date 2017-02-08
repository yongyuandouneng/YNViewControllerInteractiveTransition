//
//  YNOneViewController.m
//  YNViewControllerInteractiveTransition
//
//  Created by ZYN on 17/2/8.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNOneViewController.h"
#import "YNTwoViewController.h"

@interface YNOneViewController ()

@end

@implementation YNOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 开启右滑
    self.yn_banRightGesture = NO;
    /// 设置控制器
    YNTwoViewController *vc = [[YNTwoViewController alloc] initWithNibName:@"YNTwoViewController" bundle:nil];
    self.interactiveTransition.pushViewController = vc;
    
    
    
}
- (IBAction)buttonAction:(id)sender {
    
    YNTwoViewController *vc = [[YNTwoViewController alloc] initWithNibName:@"YNTwoViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
