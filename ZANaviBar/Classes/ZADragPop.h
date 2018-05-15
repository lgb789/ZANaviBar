//
//  ZADragPop.h
//  LGBNavigation
//
//  Created by mac_256 on 2018/4/28.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZAPopAnimation.h"

@class ZADragPop;

@protocol ZADragPopDelegate <NSObject>

-(void)zaDragPop:(ZADragPop *)dragPop progress:(CGFloat)progress;
-(void)zaDragPopFinish:(ZADragPop *)dragPop;
-(void)zaDragPopCancle:(ZADragPop *)dragPop;

@end

@interface ZADragPop : UIPercentDrivenInteractiveTransition

@property (nonatomic, weak) id<ZADragPopDelegate> delegate;
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, assign) BOOL interacting;
@property (nonatomic, weak) ZAPopAnimation *popAnimation;

-(instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end
