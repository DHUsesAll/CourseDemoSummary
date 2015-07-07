//
//  HomeViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-6.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "DHConvenienceAutoLayout.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) HomeViewModel * viewModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAppearance];
}

- (void)initializeAppearance
{
    self.title = @"首页";
    [self.view addSubview:self.tableView];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = ({
        
            UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.tableFooterView = [[UIView alloc] init];
            tableView.rowHeight = 66*[DHConvenienceAutoLayout iPhone5VerticalMutiplier];
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdf"];
            tableView;
        
        });
    }
    return _tableView;
}

- (HomeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = ({
        
            HomeViewModel * viewModel = [[HomeViewModel alloc] init];
            viewModel;
        
        });
    }
    return _viewModel;
}

#pragma mark - tableview protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdf"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.viewModel cellInfoAtIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 跳转controller
    NSString * controllerClassName = [self.viewModel.courseControllerInfoContainer objectAtIndex:indexPath.row];
    NSString * controllerTitle = [self.viewModel.courseInfoContainer objectAtIndex:indexPath.row];
    
    UIViewController * controller = [[NSClassFromString(controllerClassName) alloc] init];
    controller.title = controllerTitle;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
