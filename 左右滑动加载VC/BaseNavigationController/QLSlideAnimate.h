//
//  QLSlideAnimate.h
//  左右滑动加载VC
//
//  Created by EdwardCheng on 2018/8/9.
//  Copyright © 2018年 EdwardCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, QLPushAnimateType){
    QLSlideAnimateTypeLeftSlidePush = 0,
    QLSlideAnimateTypeRightSlidePush,
    QLSlideAnimateTypeLeftSlidePop
};

@interface QLSlideAnimate : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) QLPushAnimateType animateType;
@end
