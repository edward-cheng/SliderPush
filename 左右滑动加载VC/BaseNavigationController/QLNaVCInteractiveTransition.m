//
//  QLNaVCInteractiveTransition.m
//  左右滑动加载VC
//
//  Created by EdwardCheng on 2018/8/9.
//  Copyright © 2018年 EdwardCheng. All rights reserved.
//

#import "QLNaVCInteractiveTransition.h"
#import "QLNavigationController.h"
#import "QLSlideAnimate.h"

@interface QLNaVCInteractiveTransition ()<UINavigationControllerDelegate>
@property (nonatomic, weak) QLNavigationController *navigationController;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePushTransition;
@end

@implementation QLNaVCInteractiveTransition
- (instancetype)initWithNavigationController:(QLNavigationController *)navigationController{
    if (self = [super init]) {
        self.navigationController = navigationController;
        self.navigationController.delegate = self;
    }
    return self;
}

- (void)navigationPush:(UIPanGestureRecognizer *)panGesture{
    
    CGFloat progress = [panGesture translationInView:panGesture.view].x / panGesture.view.bounds.size.width;//拖动位置与起始位置的距离
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        
        //translation > 0 向右滑  translation < 0 向左滑
        CGPoint translation = [panGesture velocityInView:panGesture.view];//在指定坐标系统中panGesture拖动的速度
        
        if (translation.x < 0) {//左滑
            //手势开始，新建一个监控对象
            self.interactivePushTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            //告诉控制器开始执行Push的动画或pop动画
            if (self.navigationController.allowLeftSlidePop) {
                self.type = QLNaVCInteractiveTransitionTypeLeftSlidePop;
                if (self.delegate&&[self.delegate respondsToSelector:@selector(interactiveTransitionLeftSlidePop:)]) {
                    [self.delegate interactiveTransitionLeftSlidePop:self];
                }
            }else{
                self.type = QLNaVCInteractiveTransitionTypeLeftSlidePush;
                if (self.delegate&&[self.delegate respondsToSelector:@selector(interactiveTransitionLeftSlidePush:)]) {
                    [self.delegate interactiveTransitionLeftSlidePush:self];
                }
            }
        }else{//右滑
            self.interactivePushTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            self.type = QLNaVCInteractiveTransitionTypeRightSlidePush;
            //告诉控制器开始执行Push的动画
            if (self.delegate&&[self.delegate respondsToSelector:@selector(interactiveTransitionRightSlidePush:)]) {
                [self.delegate interactiveTransitionRightSlidePush:self];
            }
        }
        
    }else if (panGesture.state == UIGestureRecognizerStateChanged) {
        /**
         *  稳定进度区间，让它在0.0（未完成）～1.0（已完成）之间
         */
        //手势的完成进度
        if (self.type == QLNaVCInteractiveTransitionTypeLeftSlidePush) {
            if (progress < 0) {
                progress = fabs(progress);
                progress = MIN(1.0, MAX(0.0, progress));
            }else{
                progress = 0;
            }
        }else if (self.type == QLNaVCInteractiveTransitionTypeRightSlidePush){
            if (progress > 0) {
                progress = fabs(progress);
                progress = MIN(1.0, MAX(0.0, progress));
            }else{
                progress = 0;
            }
        }else if (self.type == QLNaVCInteractiveTransitionTypeLeftSlidePop){
            if (progress < 0) {
                progress = fabs(progress);
                progress = MIN(1.0, MAX(0.0, progress));
            }else{
                progress = 0;
            }
        }
        [self.interactivePushTransition updateInteractiveTransition:progress];
    }else if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled) {
        
        if (self.type == QLNaVCInteractiveTransitionTypeLeftSlidePush || self.type == QLNaVCInteractiveTransitionTypeLeftSlidePop) {
            if (progress > 0) {
                progress = 0;
            }else{
                progress = fabs(progress);
            }
        }
        
        if (progress > 0.3) {
            [self.interactivePushTransition finishInteractiveTransition];
        }else {
            [self.interactivePushTransition cancelInteractiveTransition];
        }
        
        
        
        self.interactivePushTransition = nil;
    }
}

#pragma make -UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (!self.interactivePushTransition) return nil;
    if (operation == UINavigationControllerOperationPush) {
        QLSlideAnimate *pushAnimate = [[QLSlideAnimate alloc]init];
        switch (self.type) {
            case QLNaVCInteractiveTransitionTypeLeftSlidePush:
                pushAnimate.animateType = QLSlideAnimateTypeLeftSlidePush;
                break;
            case QLNaVCInteractiveTransitionTypeRightSlidePush:
                pushAnimate.animateType = QLSlideAnimateTypeRightSlidePush;
                break;
            default:
                break;
        }
        return pushAnimate;
    }
    
    if (operation == UINavigationControllerOperationPop) {
        if (self.navigationController.allowLeftSlidePop) {
            QLSlideAnimate *popAnimate = [[QLSlideAnimate alloc]init];
            popAnimate.animateType = QLSlideAnimateTypeLeftSlidePop;
            return popAnimate;
        }
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if ([animationController isKindOfClass:[QLSlideAnimate class]] && self.interactivePushTransition) {
        return self.interactivePushTransition;
    }
    return nil;
}
@end
