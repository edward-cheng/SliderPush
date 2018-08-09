//
//  LeftSlideViewController.m
//  全屏左滑Push
//
//  Created by EdwardCheng on 2018/7/4.
//  Copyright © 2018年 qinglin. All rights reserved.
//

#import "LeftSlideViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface LeftSlideViewController ()
@end

@implementation LeftSlideViewController

- (BOOL)fd_interactivePopDisabled{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    lab.center = self.view.center;
    lab.text = @"我是左滑出来哒";
    [self.view addSubview:lab];
}

-(void)dealloc{
    NSLog(@"左滑出来的释放啦");
}
@end
