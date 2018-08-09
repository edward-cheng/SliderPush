//
//  QLNavigationController.m
//
//  Created by EdwardCheng on 2018/7/5.
//  Copyright © 2018年 EdwardCheng. All rights reserved.
//

#import "QLNavigationController.h"
#import "QLNaVCInteractiveTransition.h"

@interface QLNavigationController () <UIGestureRecognizerDelegate,QLNaVCInteractiveTransitionDelegate>
@property (nonatomic, strong) QLNaVCInteractiveTransition *navcInteractive;
@end

@implementation QLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    [gesture setEnabled:NO];
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *panges = [[UIPanGestureRecognizer alloc]init];
    panges.maximumNumberOfTouches = 1;
    panges.delegate = self;
    [gestureView addGestureRecognizer:panges];
    _navcInteractive = [[QLNaVCInteractiveTransition alloc]initWithNavigationController:self];
    _navcInteractive.delegate = self;
    [panges addTarget:_navcInteractive action:@selector(navigationPush:)];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    BOOL isTransitioning = ![[self valueForKey:@"_isTransitioning"] boolValue];
    return isTransitioning;
}

#pragma mark -- QLNaVCInteractiveTransitionDelegate
- (void)interactiveTransitionLeftSlidePush:(QLNaVCInteractiveTransition *)interactiveTransition{
    
    if (self.pushDelegate&&[self.pushDelegate respondsToSelector:@selector(ql_NavigationControllerLeftSlidePush)]) {
        [self.pushDelegate ql_NavigationControllerLeftSlidePush];
    }
}

- (void)interactiveTransitionRightSlidePush:(QLNaVCInteractiveTransition *)interactiveTransition{
    if (self.pushDelegate&&[self.pushDelegate respondsToSelector:@selector(ql_NavigationControllerLeftSlidePush)]) {
        [self.pushDelegate ql_NavigationControllerRightSlidePush];
    }
}

- (void)interactiveTransitionLeftSlidePop:(QLNaVCInteractiveTransition *)interactiveTransition{
    if (self.pushDelegate&&[self.pushDelegate respondsToSelector:@selector(ql_NavigationControllerLeftSlidePop)]) {
        [self.pushDelegate ql_NavigationControllerLeftSlidePop];
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) { // 如果push的不是根控制器(不是栈底控制器)
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
