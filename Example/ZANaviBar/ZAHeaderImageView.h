//
//  ZAHeaderImageView.h
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/11.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZAHeaderImageView : UIView
@property (nonatomic, assign) CGFloat scrollOffset;

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
@end
