//
//  ZADragPop.m
//  LGBNavigation
//
//  Created by mac_256 on 2018/4/28.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "ZADragPop.h"

@interface ZADragPop ()
@property (nonatomic, assign) CGFloat speed;
@end

@implementation ZADragPop
-(instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        self.navigationController = navigationController;
        UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
        pan.edges = UIRectEdgeLeft;
        [self.navigationController.view addGestureRecognizer:pan];
    }
    return self;
}

-(void)onPan:(UIScreenEdgePanGestureRecognizer *)pan
{
    CGPoint offset = [pan translationInView:pan.view];
    CGPoint velocity = [pan velocityInView:pan.view];

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            if (!self.popAnimation.animating && self.navigationController.viewControllers.count > 1) {
                self.interacting = YES;
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            break;
        case UIGestureRecognizerStateChanged:
            if (self.interacting) {
                CGFloat progress = offset.x / pan.view.bounds.size.width;
                progress = MAX(progress, 0);
                [self updateInteractiveTransition:progress];
                [self.delegate zaDragPop:self progress:progress];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (self.interacting) {
    
                if (offset.x >= pan.view.bounds.size.width * 0.3 || velocity.x > 300) {
                    
                    self.speed = 1;
                    [self finishInteractiveTransition];
                    [self.delegate zaDragPopFinish:self];
                }else{
                    
                    self.speed = self.percentComplete;
                    [self cancelInteractiveTransition];
                    [self.delegate zaDragPopCancle:self];
                }
                self.interacting = NO;
            }
            break;
        case UIGestureRecognizerStateCancelled:
            if (self.interacting) {
                [self cancelInteractiveTransition];
                self.interacting = NO;
                [self.delegate zaDragPopCancle:self];
            }
            break;
        default:
            break;
    }
}

- (CGFloat)completionSpeed
{

    return self.speed;
}

@end
