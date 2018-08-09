//
//  RightSlideViewController.m
//  全屏左滑Push
//
//  Created by EdwardCheng on 2018/7/4.
//  Copyright © 2018年 qinglin. All rights reserved.
//

#import "RightSlideViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "QLNavigationController.h"

@interface RightSlideViewController ()<QLNavigationControllerDelegate>
@property (nonatomic, weak) QLNavigationController *navigetionVC;
@end

@implementation RightSlideViewController

- (BOOL)fd_interactivePopDisabled{
    return YES;
}

//- (BOOL)fd_prefersNavigationBarHidden{
//    return YES;
//}
-(BOOL)fd_prefersNavigationBarHidden{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    lab.center = self.view.center;
    lab.text = @"我是右滑出来哒";
    [self.view addSubview:lab];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController isKindOfClass:[QLNavigationController class]]) {
        _navigetionVC = (QLNavigationController *)self.navigationController;
        _navigetionVC.pushDelegate = self;
        _navigetionVC.allowLeftSlidePop = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_navigetionVC) {
        _navigetionVC.allowLeftSlidePop = NO;
        _navigetionVC.pushDelegate = nil;
        _navigetionVC = nil;
    }
}


#pragma mark -- QLNavigationControllerDelegate
- (void)ql_NavigationControllerLeftSlidePop{
    if (self.isViewLoaded && self.view.window) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)dealloc{
    NSLog(@"右滑出来的已完美释放");
}

@end
