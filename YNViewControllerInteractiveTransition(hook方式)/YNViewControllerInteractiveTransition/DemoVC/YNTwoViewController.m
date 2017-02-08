//
//  YNTwoViewController.m
//  YNViewControllerInteractiveTransition
//
//  Created by ZYN on 17/2/8.
//  Copyright © 2017年 Yongneng Zheng. All rights reserved.
//

#import "YNTwoViewController.h"
#import "YNThreeViewController.h"

@interface YNTwoViewController ()

@end

@implementation YNTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)buttonAction:(id)sender {
    YNThreeViewController *vc = [[YNThreeViewController alloc] initWithNibName:@"YNThreeViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
