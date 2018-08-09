//
//  QLNaVCInteractiveTransition.h
//  左右滑动加载VC
//
//  Created by EdwardCheng on 2018/8/9.
//  Copyright © 2018年 EdwardCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLNavigationController;
typedef NS_ENUM(NSInteger, QLNaVCInteractiveTransitionType){
    QLNaVCInteractiveTransitionTypeLeftSlidePush = 0,
    QLNaVCInteractiveTransitionTypeRightSlidePush,
    QLNaVCInteractiveTransitionTypeLeftSlidePop
};

@class QLNaVCInteractiveTransition;

@protocol QLNaVCInteractiveTransitionDelegate <NSObject>

@required
///左滑Push
- (void)interactiveTransitionLeftSlidePush:(QLNaVCInteractiveTransition *)interactiveTransition;

///右滑Push
- (void)interactiveTransitionRightSlidePush:(QLNaVCInteractiveTransition *)interactiveTransition;

///左滑Pop
- (void)interactiveTransitionLeftSlidePop:(QLNaVCInteractiveTransition *)interactiveTransition;
@end

@interface QLNaVCInteractiveTransition : NSObject
@property (nonatomic, weak) id<QLNaVCInteractiveTransitionDelegate> delegate;
@property (nonatomic, assign) QLNaVCInteractiveTransitionType type;
- (instancetype)initWithNavigationController:(QLNavigationController *)navigationController;

- (void)navigationPush:(UIPanGestureRecognizer *)panGesture;
@end
