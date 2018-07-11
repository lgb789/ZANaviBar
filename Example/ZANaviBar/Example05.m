//
//  Example05.m
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/15.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "Example05.h"
#import "Header.h"

@interface Example05 ()

@end

@implementation Example05

#pragma mark ------------------------------------------------- 生命周期 ------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.za_bar.hideBackButton = YES;
    ZA_logBool(self.navigationItem.hidesBackButton);
    [self.navigationController.za_bar setBarShadowImageColor:[UIColor blueColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.za_bar.hideBackButton = NO;
    
}



#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------

#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------

@end
