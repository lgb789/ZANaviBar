//
//  ZAPopAnimation.m
//  LGBNavigation
//
//  Created by mac_256 on 2018/4/27.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "ZAPopAnimation.h"

@implementation ZAPopAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.35;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    fromViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
    fromViewController.view.layer.shadowRadius = 5;
    fromViewController.view.layer.shadowOffset = CGSizeMake(0, 0);
    fromViewController.view.layer.shadowOpacity = 0.2;
    

    UIView *maskView = [[UIView alloc] initWithFrame:transitionContext.containerView.bounds];
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    
    [transitionContext.containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [transitionContext.containerView insertSubview:maskView aboveSubview:toViewController.view];

    
    CGRect finalToFrame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = CGRectOffset(finalToFrame, -finalToFrame.size.width / 2, 0);
    
    CGRect originFromFrame = fromViewController.view.frame;

    self.animating = YES;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        fromViewController.view.frame = CGRectOffset(originFromFrame, originFromFrame.size.width, 0);
        toViewController.view.frame = finalToFrame;
        maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        self.animating = NO;
        [maskView removeFromSuperview];
    }];
    
    
}
@end
