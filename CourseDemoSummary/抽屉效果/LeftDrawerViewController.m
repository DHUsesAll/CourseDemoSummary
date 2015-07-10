//
//  LeftDrawerViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-10.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "LeftDrawerViewController.h"

@interface LeftDrawerViewController () <UITableViewDataSource>

@end

@implementation LeftDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdf"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdf"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
