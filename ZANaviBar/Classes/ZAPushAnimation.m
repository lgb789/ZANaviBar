//
//  ZAPushAnimation.m
//  LGBNavigation
//
//  Created by mac_256 on 2018/4/27.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "ZAPushAnimation.h"

@implementation ZAPushAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [transitionContext.containerView addSubview:toViewController.view];
    
    CGRect originFromFrame = fromViewController.view.frame;
    
    CGRect finalToFrame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = CGRectOffset(finalToFrame, finalToFrame.size.width, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toViewController.view.frame = finalToFrame;
        fromViewController.view.frame = CGRectOffset(originFromFrame, -originFromFrame.size.width / 2, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
    
}
@end
