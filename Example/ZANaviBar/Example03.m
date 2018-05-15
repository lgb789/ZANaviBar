//
//  Example03.m
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/11.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "Example03.h"
#import "Header.h"

@interface Example03 ()

@end

@implementation Example03

#pragma mark ------------------------------------------------- 生命周期 ------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    ZA_logString(@"view load");
    self.title = @"Example03";
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    ZA_logString(@"show ....");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}



#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------

#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------

@end
