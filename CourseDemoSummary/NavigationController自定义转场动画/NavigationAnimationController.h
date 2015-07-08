//
//  NavigationManager.h
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-7.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationAnimationController : NSObject <UINavigationControllerDelegate , UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * percentTransition;

@end
