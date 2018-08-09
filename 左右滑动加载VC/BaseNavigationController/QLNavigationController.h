//
//  QLNavigationController.h
//
//  Created by EdwardCheng on 2018/7/5.
//  Copyright © 2018年 EdwardCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QLNavigationControllerDelegate <NSObject>
@optional
///左滑push
- (void)ql_NavigationControllerLeftSlidePush;

///右滑push
- (void)ql_NavigationControllerRightSlidePush;

///左滑pop
- (void)ql_NavigationControllerLeftSlidePop;
@end

@interface QLNavigationController : UINavigationController
@property (nonatomic, weak) id<QLNavigationControllerDelegate> pushDelegate;
@property (nonatomic, assign) BOOL allowLeftSlidePop;///是否允许左滑pop
@end
