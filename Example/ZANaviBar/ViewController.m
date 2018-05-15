//
//  ViewController.m
//  ZANavigationBar
//
//  Created by mac_256 on 2018/5/10.
//  Copyright © 2018年 mac_256. All rights reserved.
//

#import "ViewController.h"
#import "Example01.h"
#import "Header.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.title = @"ViewController";
    self.data = @[
                  @[@"Example01"],
                  @[@"Example02"],
                  @[@"Example03"],
                  @[@"Example04"],
                  @[@"Example05"],
                  ];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
//
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleRightButton)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    UIImage *image = [UIImage imageNamed:@"navibar_back_icon"];
    [self.navigationController.za_bar setBackButtonImage:image];
    
    self.navigationController.za_bar.customBackButton = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.za_bar setBarBackgroundColor:[UIColor purpleColor]];
//    [self.navigationController.za_bar setBarBackgroundImage:[UIImage imageNamed:@"navi_bg_icon"]];
    ZA_logObj(self.navigationController.navigationBar.tintColor);
    self.navigationController.navigationBar.tintColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
//    [self.za_bar setBarBackgroundColor:[UIColor purpleColor]];
//    [self.za_bar setBarTintColor:[[UIColor purpleColor] colorWithAlphaComponent:0]];
    
//    self.za_bar.barStyle = UIBarStyleBlack;
}

-(void)handleRightButton
{
    ZA_logString(@"press...");
    [self.navigationController pushViewController:[Example01 new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.data[indexPath.row][0];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [NSClassFromString(self.data[indexPath.row][0]) new];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
