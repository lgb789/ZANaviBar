//
//  Example04.m
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/11.
//Copyright © 2018年 mac_256. All rights reserved.
//

#import "Example04.h"
#import "Header.h"

@interface Example04 () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL firstLoad;
@end

@implementation Example04

#pragma mark ------------------------------------------------- 生命周期 ------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.firstLoad = YES;
    self.title = @"Example04";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}



#pragma mark ------------------------------------------------- 公有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 私有方法 -------------------------------------------------

#pragma mark ------------------------------------------------- 代理方法 -------------------------------------------------
#pragma mark - UITableViewDelegate
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    ZA_logString(NSStringFromCGPoint(offset));
    if (self.firstLoad) {
        self.firstLoad = NO;
        return;
    }
    CGFloat y = offset.y + 64;
    ZA_logFloat(y);
    if (y >= CGRectGetHeight(self.navigationController.navigationBar.bounds)) {
        return;
    }
    
    CGFloat alpha = 1.0 - 1.0 / CGRectGetHeight(self.navigationController.navigationBar.bounds) * y;
    ZA_logFloat(alpha);
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[UIColor whiteColor] colorWithAlphaComponent:alpha]};
    self.navigationController.navigationBar.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
    self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0, -y);
}
#pragma mark ------------------------------------------------- 事件处理 -------------------------------------------------

#pragma mark ------------------------------------------------- 成员变量 -------------------------------------------------

@end
