//
//  NavigationManager.h
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-7.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationManager : NSObject

- (instancetype)initWithRootViewController:(UIViewController *)controller;


- (UINavigationController *)navigationController;

- (void)pushToViewController:(UIViewController *)viewController withTransitionDelegate:(id <UINavigationControllerDelegate>)transitionDelegate;

- (void)popViewController;
- (void)popToRootViewController;

@end
