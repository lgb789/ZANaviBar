//
//  ZAHeaderImageView.m
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/11.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "ZAHeaderImageView.h"

@interface ZAHeaderImageView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ZAHeaderImageView

#pragma mark ------------------------------------------------- 初始化 --------------------------------------------------
-(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        self.imageView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.imageView.frame;
    frame.size = self.bounds.size;
    frame.origin = CGPointZero;
    
    if (self.scrollOffset < 0) {
        CGFloat offset = fabs(self.scrollOffset);
        frame.origin.y = -offset;
        frame.size.height += offset;
    }
    
    self.imageView.frame = frame;
    
}
#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------

#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------
- (void)setScrollOffset:(CGFloat)scrollOffset
{
    if (_scrollOffset == scrollOffset) { return; }
    _scrollOffset = scrollOffset;
    [self setNeedsLayout];
}
@end
