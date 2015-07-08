//
//  NavigationManager.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-7.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "NavigationManager.h"

@interface NavigationManager ()

@property (nonatomic, strong) UINavigationController * navigationController;
@property (nonatomic, strong) NSMutableArray * delegateStack;

@end

@implementation NavigationManager

- (void)dealloc
{
    self.navigationController = nil;
    self.delegateStack = nil;
}


#pragma mark - 接口方法

- (instancetype)initWithRootViewController:(UIViewController *)controller
{
    self = [super init];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    return self;
}

- (void)pushToViewController:(UIViewController *)viewController withTransitionDelegate:(id<UINavigationControllerDelegate>)transitionDelegate
{
    self.navigationController.delegate = transitionDelegate;
    [self.delegateStack addObject:transitionDelegate];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)popViewController
{
    self.navigationController.delegate = [self.delegateStack lastObject];
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegateStack removeLastObject];
}

- (void)popToRootViewController
{
    self.navigationController.delegate = [self.delegateStack firstObject];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.delegateStack removeAllObjects];
}

@end
