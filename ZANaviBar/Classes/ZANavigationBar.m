//
//  ZANavigationBar.m
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/10.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import <objc/runtime.h>
#import "ZANavigationBar.h"
#import "ZADragPop.h"
#import "ZAPopAnimation.h"

@interface ZANavigationBar () <UINavigationControllerDelegate>
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, assign) CGFloat separatorHeight;
@property (nonatomic, strong) UIBarButtonItem *backButtonItem;
@property (nonatomic, strong) ZADragPop *dragPop;
@property (nonatomic, strong) ZAPopAnimation *popAnimation;
@end

@implementation ZANavigationBar

#pragma mark ------------------------------------------------- 初始化 --------------------------------------------------
-(instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    self = [super init];
    if (self) {
        self.navigationController = navigationController;
        
        self.backgroundView = [UIImageView new];
        self.separatorView = [UIView new];
        self.separatorHeight = 1.0 / [UIScreen mainScreen].scale;
        
        [self.navigationController.navigationBar insertSubview:self.backgroundView atIndex:0];
        [self.navigationController.navigationBar insertSubview:self.separatorView atIndex:1];
        
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.delegate = self;
        
        [self.navigationController.navigationBar addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];

        self.dragPop = [[ZADragPop alloc] initWithNavigationController:navigationController];
        self.popAnimation = [ZAPopAnimation new];
    }
    
    return self;
}
#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------
-(void)updateLayout
{
    CGRect barFrame = self.navigationController.navigationBar.frame;
    self.backgroundView.frame = CGRectMake(0, -CGRectGetMinY(barFrame), CGRectGetWidth(barFrame), CGRectGetHeight(barFrame) + CGRectGetMinY(barFrame));
    self.separatorView.frame = CGRectMake(0, CGRectGetMaxY(self.backgroundView.frame) - self.separatorHeight, CGRectGetWidth(self.backgroundView.bounds), self.separatorHeight);
}

-(void)setBarBackgroundColor:(UIColor *)barBackgroundColor
{
    [self transitionViewController:self.navigationController.topViewController block:^{
        self.backgroundView.backgroundColor = barBackgroundColor;
    }];
    
}

-(void)setBarBackgroundImage:(UIImage *)barBackgroundImage
{
    UIImage *image = [barBackgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    self.backgroundView.image = image;
}

-(void)setNaviBarHidden:(BOOL)naviBarHidden
{

    [self transitionViewController:self.navigationController.topViewController block:^{
        self.backgroundView.alpha = naviBarHidden ? 0 : 1;
        self.separatorView.alpha = naviBarHidden ? 0 : 1;
    }];
}

-(void)setBackgroundAlpha:(CGFloat)backgroundAlpha
{
    CGFloat alpha = MIN(backgroundAlpha, 1.0);
    alpha = MAX(0, alpha);
    self.backgroundView.alpha = alpha;
    self.separatorView.alpha = alpha;
}

-(void)setBarTitleAlpha:(CGFloat)barTitleAlpha
{
    UIColor *color = [self.navigationController.navigationBar.titleTextAttributes objectForKey:NSForegroundColorAttributeName];
    color = color ? color : [UIColor blackColor];
    
    [self transitionViewController:self.navigationController.topViewController block:^{
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [color colorWithAlphaComponent:barTitleAlpha]};
    }];
}

-(void)setBackButtonImage:(UIImage *)backButtonImage
{
    self.navigationController.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
    
    self.backButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(handlePressedBackButton)];
}

-(void)setHideBackButton:(BOOL)hideBackButton
{
    _hideBackButton = hideBackButton;
    
    self.navigationController.topViewController.navigationItem.hidesBackButton = hideBackButton;
}

-(void)setBarShadowImageColor:(UIColor *)barShadowImageColor
{
    self.separatorView.backgroundColor = barShadowImageColor;
}

//-(void)setBarShadowImageAlpha:(CGFloat)barShadowImageAlpha
//{
//    self.separatorView.alpha = barShadowImageAlpha;
//}

#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------
-(void)transitionViewController:(UIViewController *)viewController block:(void(^)(void))block
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinate = viewController.transitionCoordinator;

    if (transitionCoordinate == nil) {
        CGFloat duration = 0.35;
        [UIView animateWithDuration:duration animations:^{
            block();
        }];
    }
    
    [transitionCoordinate animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        block();
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {

    }];
}
#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count >= 2) {
        
        if (!self.hideBackButton) {
            viewController.navigationItem.leftBarButtonItem = self.backButtonItem;
        }
    }
    
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    //只有通过手势pop时才自定义动画，否则用系统的
        if (operation == UINavigationControllerOperationPop && self.dragPop.interacting){
    
            return self.popAnimation;
        }
        return nil;
    
//    return operation == UINavigationControllerOperationPop ? self.popAnimation : self.pushAnimation;
    
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.dragPop.interacting ? self.dragPop : nil;
}
#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{

    if (object == self.navigationController.navigationBar) {
        [self updateLayout];
    }
}

-(void)handlePressedBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------

@end


@implementation UINavigationController (ZANavigationBar)

-(ZANavigationBar *)za_bar
{
    id bar = objc_getAssociatedObject(self, _cmd);
    if (!bar) {
        bar = [[ZANavigationBar alloc] initWithNavigationController:self];
        objc_setAssociatedObject(self, _cmd, bar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return (ZANavigationBar *)bar;
}

@end
