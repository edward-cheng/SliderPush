//
//  ViewController.m
//  左右滑动加载VC
//
//  Created by EdwardCheng on 2018/8/8.
//  Copyright © 2018年 EdwardCheng. All rights reserved.
//

#import "ViewController.h"
#import "RightSlideViewController.h"
#import "LeftSlideViewController.h"
#import "QLNavigationController.h"

@interface ViewController ()
<QLNavigationControllerDelegate>
@property (nonatomic, weak) QLNavigationController *navigetionVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"控制器一";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController isKindOfClass:[QLNavigationController class]]) {
        _navigetionVC = (QLNavigationController *)self.navigationController;
        _navigetionVC.pushDelegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_navigetionVC) {
        _navigetionVC.pushDelegate = nil;
        _navigetionVC = nil;
    }
}
#pragma mark -- QLNavigationControllerDelegate
- (void)ql_NavigationControllerLeftSlidePush{
    if (self.isViewLoaded && self.view.window) {
        LeftSlideViewController *viewVC = [[LeftSlideViewController alloc]init];
        viewVC.view.backgroundColor = [UIColor redColor];
        [self.navigationController pushViewController:viewVC animated:YES];
    }
}


-(void)ql_NavigationControllerRightSlidePush{
    if (self.isViewLoaded && self.view.window) {
        RightSlideViewController *viewVC = [[RightSlideViewController alloc]init];
        viewVC.view.backgroundColor = [UIColor yellowColor];
        [self.navigationController pushViewController:viewVC animated:YES];
    }
}

@end
