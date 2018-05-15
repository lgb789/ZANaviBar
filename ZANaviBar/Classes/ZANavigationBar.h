//
//  ZANavigationBar.h
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/10.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZANavigationBar : NSObject

@property (nonatomic, assign) BOOL customBackButton;
@property (nonatomic, assign) BOOL hideBackButton;

-(void)setBarBackgroundColor:(UIColor *)barBackgroundColor;

-(void)setBarBackgroundImage:(UIImage *)barBackgroundImage;

-(void)setBackgroundHidden:(BOOL)backgroundHidden;

-(void)setBackgroundAlpha:(CGFloat)backgroundAlpha;

-(void)setBarTitleAlpha:(CGFloat)barTitleAlpha;

-(void)setBackButtonImage:(UIImage *)backButtonImage;

-(void)setBarShadowImageColor:(UIColor *)barShadowImageColor;

-(void)setBarShadowImageAlpha:(CGFloat)barShadowImageAlpha;

@end


@interface UINavigationController (ZANavigationBar)
@property (nonatomic, readonly, nullable) ZANavigationBar *za_bar;
@end
