//
//  ViewController.m
//  YNViewControllerInteractiveTransition
//
//  Created by ZYN on 17/2/8.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "ViewController.h"
#import "YNOneViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 隐藏导航条 最好自定义加在vc的view上 网易 淘宝都是自定义的。
    [self.navigationController setNavigationBarHidden:YES];
    
    
    
    
}

- (IBAction)buttonAction:(id)sender {
    
    YNOneViewController *vc = [[YNOneViewController alloc] initWithNibName:@"YNOneViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
