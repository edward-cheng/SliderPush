//
//  QLSlideAnimate.m
//  左右滑动加载VC
//
//  Created by EdwardCheng on 2018/8/9.
//  Copyright © 2018年 EdwardCheng. All rights reserved.
//

#import "QLSlideAnimate.h"

@implementation QLSlideAnimate
- (UITabBar *)fetchTabbar{
    id rootVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarVC = (UITabBarController *)rootVC;
        return tabbarVC.tabBar;
    }
    return nil;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.25;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    //当前控制器
    UIViewController *fromeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //要跳转的控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //自定义动画
    switch (self.animateType) {
        case QLSlideAnimateTypeLeftSlidePush:
            [self leftSlidePushAnimate:transitionContext FromeVC:fromeVC ToVC:toVC];
            break;
        case QLSlideAnimateTypeRightSlidePush:
            [self rightSlidePushAnimate:transitionContext FromeVC:fromeVC ToVC:toVC];
            break;
            
        case QLSlideAnimateTypeLeftSlidePop:
            [self leftSlidePopAnimate:transitionContext FromeVC:fromeVC ToVC:toVC];
            break;
            
        default:
            break;
    }
}

///左滑push动画
-(void)leftSlidePushAnimate:(id<UIViewControllerContextTransitioning>)transitionContext FromeVC:(UIViewController *)fromeVC ToVC:(UIViewController *)toVC{
    //当前控制器
    fromeVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //要跳转的控制器
    toVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //转场动画平台
    UIView *containerView = [transitionContext containerView];
    
    BOOL hiddenTabbar = toVC.hidesBottomBarWhenPushed;
    UITabBar *tabbar = [self fetchTabbar];
    if (hiddenTabbar && tabbar) {
        tabbar.hidden = YES;
        
    }
    
    [containerView insertSubview:toVC.view aboveSubview:fromeVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect fromeFrame = fromeVC.view.frame;
        fromeFrame.origin.x = -[UIScreen mainScreen].bounds.size.width / 2;
        fromeVC.view.frame = fromeFrame;
        
        CGRect toFrame = toVC.view.frame;
        toFrame.origin.x = 0;
        toVC.view.frame = toFrame;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

///右滑push动画
-(void)rightSlidePushAnimate:(id<UIViewControllerContextTransitioning>)transitionContext FromeVC:(UIViewController *)fromeVC ToVC:(UIViewController *)toVC{
    
    //当前控制器
    fromeVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //要跳转的控制器
    toVC.view.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //转场动画平台
    UIView *containerView = [transitionContext containerView];
    
    BOOL hiddenTabbar = toVC.hidesBottomBarWhenPushed;
    UITabBar *tabbar = [self fetchTabbar];
    if (hiddenTabbar && tabbar) {
        tabbar.hidden = YES;
        
    }
    
    [containerView insertSubview:toVC.view aboveSubview:fromeVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect fromeFrame = fromeVC.view.frame;
        fromeFrame.origin.x = [UIScreen mainScreen].bounds.size.width;
        fromeVC.view.frame = fromeFrame;
        
        CGRect toFrame = toVC.view.frame;
        toFrame.origin.x = 0;
        toVC.view.frame = toFrame;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

///左滑pop动画
-(void)leftSlidePopAnimate:(id<UIViewControllerContextTransitioning>)transitionContext FromeVC:(UIViewController *)fromeVC ToVC:(UIViewController *)toVC{
    
    //当前控制器
    fromeVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //要跳转的控制器
    toVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //转场动画平台
    UIView *containerView = [transitionContext containerView];
    
    BOOL hiddenTabbar = toVC.hidesBottomBarWhenPushed;
    UITabBar *tabbar = [self fetchTabbar];
    if (!hiddenTabbar && tabbar) {
        tabbar.hidden = YES;
    }
    
    [containerView insertSubview:toVC.view aboveSubview:fromeVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect fromeFrame = fromeVC.view.frame;
        fromeFrame.origin.x = -[UIScreen mainScreen].bounds.size.width;
        fromeVC.view.frame = fromeFrame;
        
        CGRect toFrame = toVC.view.frame;
        toFrame.origin.x = 0;
        toVC.view.frame = toFrame;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        if (!hiddenTabbar && tabbar) {
            tabbar.hidden = NO;
        }
    }];
}
@end
