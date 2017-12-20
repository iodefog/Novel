//
//  UIViewController+Tool.m
//  geliwuliu
//
//  Created by th on 2017/4/24.
//  Copyright © 2017年 th. All rights reserved.
//

#import "UIViewController+Tool.h"

@implementation UIViewController (Tool)


- (void)addBackItem {
    
    [self.navigationController.navigationBar setBackIndicatorImage:[[UIImage imageNamed:@"backTo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[[UIImage imageNamed:@"backTo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)go2Back {
    if (self.navigationController) {
        if ([self.navigationController viewControllers].count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
