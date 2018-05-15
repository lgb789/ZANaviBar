//
//  Example01.m
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/11.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "Example01.h"
#import "Header.h"

@interface Example01 ()

@end

@implementation Example01

#pragma mark ------------------------------------------------- 生命周期 ------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
 
//    self.title = @"Example01";
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.za_bar.navigationItem.title = @"Example01";
//    self.za_bar.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleLeftButton)];
    
//    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"navibar_back_icon"];
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"navibar_back_icon"];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleRightButton)];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.za_bar setBarBackgroundColor:[UIColor orangeColor]];
//    [self.navigationController.za_bar setBarBackgroundImage:[self imageFromColor:[UIColor purpleColor]]];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    [self.navigationItem.backBarButtonItem setTitle:@"ooo"];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navibar_back_icon"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.title = @"Example01";
}

-(void)handleLeftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleRightButton
{
    ZA_logString(@"press...");
    [self.navigationController pushViewController:[Example01 new] animated:YES];
}
#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------
-(UIImage *)imageFromColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, [UIScreen mainScreen].scale);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 1, 1)];
    [color setFill];
    [color setStroke];
    
    [path addClip];
    [path fill];
    [path stroke];
    
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------

#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------

@end
