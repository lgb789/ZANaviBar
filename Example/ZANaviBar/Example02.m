//
//  Example02.m
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/11.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "Example02.h"
#import "ZAHeaderImageView.h"
#import "Header.h"

@interface Example02 () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation Example02

#pragma mark ------------------------------------------------- 生命周期 ------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        [tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        // Fallback on earlier versions
    }
    
    ZAHeaderImageView *headerView = [[ZAHeaderImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 300) image:[UIImage imageNamed:@"63H"]];
    
    tableView.tableHeaderView = headerView;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ZA_logString(@"will appear...e");
    [self.navigationController.za_bar setBackgroundHidden:YES];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:0]};
//    [self.navigationController.za_bar setBarTitleAlpha:0];
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    ZA_logString(@"disappear...");
    [self.navigationController.za_bar setBackgroundHidden:NO];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:1.0]};
//    [self.navigationController.za_bar setBarTitleAlpha:1];
    
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}



#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%ld", indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint offset = scrollView.contentOffset;
//
//    CGFloat alpha = 1.0 / (200 - CGRectGetMaxY(self.navigationController.navigationBar.frame)) * offset.y;
//    ZA_logFloat(alpha);
////    self.navigationController.navigationBar.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0 - alpha];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:alpha]};
//    [self.navigationController.za_bar setBackgroundAlpha:alpha];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self changeAlpha];
}

-(void)changeAlpha
{
    CGPoint offset = self.tableView.contentOffset;
    
    [(ZAHeaderImageView *)self.tableView.tableHeaderView setScrollOffset:offset.y];
    
    CGFloat alpha = 1.0 / (200 - CGRectGetMaxY(self.navigationController.navigationBar.frame)) * offset.y;
    ZA_logFloat(alpha);
    //    self.navigationController.navigationBar.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0 - alpha];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:alpha]};
//    [self.navigationController.za_bar setBarTitleAlpha:alpha];
    if (alpha >= 0.5) {
        self.title = @"Example02";
    }else{
        self.title = @"";
    }
    [self.navigationController.za_bar setBackgroundAlpha:alpha];
}
#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------

#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------

@end
