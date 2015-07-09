//
//  MVCViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-9.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//


// MVC设计模式
// 规范：C可以引用M和V，而M和V不能相互引用并且不能直接引用C，如果有delegate指针指向C，也不应该知道这个delegate就是C

// 解决方案：V的点击事件等等实现，应该由C来实现，V通过target - action模式将动作的实现传递给C来实现。或者通过delegate进行回调。在现在的开发中，通常使用block进行回调

//  M进行数据获取，如果是异步的，应该在请求结束后通知C，使其拿到新的数据来更新界面。一般通过通知或KVO来在请求结束后通知C。

#import "MVCViewController.h"
#import "MVCView.h"
#import "MVCModel.h"

@interface MVCViewController ()

@property (nonatomic, strong) MVCModel * model;

@end

@implementation MVCViewController

- (void)dealloc
{
    // dealloc时一定要记住移除观察者。不然可能导致野指针
    [_model removeObserver:self forKeyPath:@"dataList"];
    [_model removeObserver:self forKeyPath:@"data"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initializeAppearence];
}

- (void)initializeAppearence
{
    self.view.backgroundColor = [UIColor whiteColor];
    MVCView * view = [[MVCView alloc] initWithFrame:CGRectMake(80, 80, 250, 250)];
    view.backgroundColor = [UIColor greenColor];
    
    // 为避免block循环引用，使用weak指针
    __weak typeof(view) weakView = view;
    view.tapBlock = ^(MVCView * aView) {
        NSLog(@"%p, %p",aView, weakView);
    };
    
    [self.view addSubview:view];
    
    MVCModel * model = [[MVCModel alloc] init];
    self.model = model;
    
    // 给model添加观察者，观察者是自己
    // keypath表示你要观察的属性，遵循KVC，可以a.b.c.....一直点下去
    [model addObserver:self forKeyPath:@"data" options:NSKeyValueObservingOptionNew context:nil];
    
    [model addObserver:self forKeyPath:@"dataList" options:NSKeyValueObservingOptionNew context:nil];
}

// 当被观察的属性被修改时，系统会回调这个方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",keyPath);
    // 当同时观察多个属性时，用keyPath区分
    if ([keyPath isEqualToString:@"dataList"]) {
        
        // 用KVC来取值
        id dataList = [object valueForKeyPath:keyPath];
        
        NSLog(@"%@",dataList);
    }
    
}

@end
