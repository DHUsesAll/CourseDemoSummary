//
//  HomeViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-6.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//


// 首页
// 自定义navigationController转场动画和可交互的转场均在这里实现

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "DHConvenienceAutoLayout.h"
#import "NavigationAnimationController.h"


@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) HomeViewModel * viewModel;
@property (nonatomic, strong) NavigationAnimationController * delegate;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAppearance];
    
    // 屏幕边缘的拖动手势
    UIScreenEdgePanGestureRecognizer * gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onGesture:)];
    // 响应屏幕左边缘
    gesture.edges =  UIRectEdgeLeft;
    [self.navigationController.view addGestureRecognizer:gesture];
}

- (void)onGesture:(UIPanGestureRecognizer *)sender
{
    // 为当前的delegate设置返回的interactiveTransition对象
    NavigationAnimationController * delegate = (NavigationAnimationController *)self.navigationController.delegate;
    
    UIPercentDrivenInteractiveTransition * transition = delegate.percentTransition;
    
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ([sender velocityInView:self.navigationController.view].x < 0) {
            return;
        } else {
            UIPercentDrivenInteractiveTransition * transition = [[UIPercentDrivenInteractiveTransition alloc] init];
            // 设置正确的对象以返回，这样在Pop的时候系统才会让我们来控制转场动画的进程
            delegate.percentTransition = transition;
            
            // pop，由于我们设置了percenTransition，这样系统在pop的时候会暂停动画，由我们手动控制动画的进程
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        // 手指距屏幕左边的距离/屏幕总宽度作为我们的percent
        CGPoint translation = [sender translationInView:self.navigationController.view];
        
        CGFloat percent = translation.x / CGRectGetWidth(self.navigationController.view.frame);
        
        // 调用UIPercentDrivenInteractiveTransition的方法来控制动画走势
        [transition updateInteractiveTransition:percent];
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        // 手指放开屏幕时如果手指的速度是向右的，pop成功
        if ([sender velocityInView:self.navigationController.view].x > 0) {
            
            [transition finishInteractiveTransition];
        } else {
            [transition cancelInteractiveTransition];
        }
        // 重新设为nil，这样我们默认的pop操作是不需要可交互的控制
        delegate.percentTransition = nil;
    }
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
    
    // 自定义转场动画
    NavigationAnimationController * delegate = [[NavigationAnimationController alloc] init];
    self.navigationController.delegate = delegate;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    // strong属性持有，避免野指针
    self.delegate = delegate;
}


@end
