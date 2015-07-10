//
//  DrawerViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-10.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "DrawerViewController.h"
#import "LeftDrawerViewController.h"
#import "HomeViewController.h"

#define DRAWER_ANIMATION_DURATION   0.28

@interface DrawerViewController : UIViewController



@end

@interface DrawerContainerViewController () <UIGestureRecognizerDelegate>

// 当我们的手指的方向正确时，手指的移动才能控制抽屉动画显示的进程
@property (nonatomic, assign) BOOL shouldBeginAnimation;

// 抽屉视图
@property (nonatomic, strong) LeftDrawerViewController * leftVC;

// 首页导航控制器
@property (nonatomic, strong) UINavigationController * naVC;
// 抽屉出来后，用这个view盖在homeController上面响应关闭抽屉的手势
@property (nonatomic, strong) UIView * maskGestureView;

@end

@implementation DrawerContainerViewController
#pragma mark - 重写方法
- (void)addChildViewController:(UIViewController *)childController
{
    [super addChildViewController:childController];
    
    [childController didMoveToParentViewController:self];
    [self.view addSubview:childController.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.shouldBeginAnimation = NO;
    
    [self initializeControllers];
    
    [self initializeGesture];
    
}

#pragma mark - 各种初始化
- (void)initializeControllers
{
    HomeViewController * homeVC = [[HomeViewController alloc] init];
    self.naVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.view.backgroundColor = [UIColor whiteColor];
    LeftDrawerViewController * leftDrawerVC = [[LeftDrawerViewController alloc] init];
    leftDrawerVC.view.alpha = 0;
    self.leftVC = leftDrawerVC;
    
    [self addChildViewController:leftDrawerVC];
    [self addChildViewController:_naVC];
}

- (void)initializeGesture
{
    UIScreenEdgePanGestureRecognizer * gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onScreenEdgeGesture:)];
    gesture.edges = UIRectEdgeLeft;
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}


#pragma mark - 手势的回调
// 解决手势冲突
// 因为我们实现了可交互的转场动画，navigationController里面也有屏幕左边的手势
// 手势代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

// 手势拖动事件
// 抽屉即将打开
- (void)onScreenEdgeGesture:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ([sender velocityInView:self.view].x < 0) {
            return;
        }
        
        // 接下来在手指移动的时候可以动画
        _shouldBeginAnimation = YES;
        _leftVC.view.center = CGPointMake(0, CGRectGetHeight(self.view.bounds));
        _leftVC.view.transform = CGAffineTransformMakeScale(0.7, 0.7);
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        if (!_shouldBeginAnimation) {
            return;
        }
        // 当前手指距离屏幕左边的距离
        CGFloat offsetX = [sender translationInView:self.view].x;
        
        // 距离占屏幕宽度的百分比（用来表示动画进行的百分比）
        CGFloat percent = offsetX/CGRectGetWidth(self.view.bounds);
        
        [self handlerAnimationWithPercent:percent];
        
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        // 速度向左，则关闭抽屉
        if ([sender velocityInView:self.view].x < 0) {
            [UIView animateWithDuration:DRAWER_ANIMATION_DURATION animations:[self drawerCloseAnimation] completion:^(BOOL finished) {
                // 移除maskView
                [self removeMaskView];
                _shouldBeginAnimation = NO;
            }];
        } else {
            
            // 动画打开抽屉
            [UIView animateWithDuration:DRAWER_ANIMATION_DURATION animations:[self drawerOpenAnimation] completion:^(BOOL finished) {
                // 添加maskView
                [self addMaskView];
                _shouldBeginAnimation = NO;
            }];
        }
        
        
    }
}

// 点击到maskGestureView上面。动画关闭抽屉
- (void)onTap:(UIGestureRecognizer *)gesture
{
    [UIView animateWithDuration:DRAWER_ANIMATION_DURATION animations:[self drawerCloseAnimation] completion:^(BOOL finished) {
        [self removeMaskView];
        
    }];
}

// 打开抽屉后，拖动主要视图的响应手势（该手势实际上加在maskView上的）
- (void)onPan:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ([sender velocityInView:self.view].x > 0) {
            return;
        }
        _shouldBeginAnimation = YES;
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        if (!_shouldBeginAnimation) {
            return;
        }
        
        // 手指的位移
        CGFloat offsetX = [sender translationInView:self.view].x;
        
        if (offsetX > 0) {
            return;
        }
        
        // 距离占屏幕宽度的百分比（用来表示动画进行的百分比）
        // fabs是取绝对值的函数
        CGFloat percent = 1-fabs(offsetX)/CGRectGetWidth(self.view.bounds);
        
        NSLog(@"%f",percent);
        [self handlerAnimationWithPercent:percent];
        
        
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        // 速度向左，则关闭抽屉
        if ([sender velocityInView:self.view].x < 0) {
            [UIView animateWithDuration:DRAWER_ANIMATION_DURATION animations:[self drawerCloseAnimation] completion:^(BOOL finished) {
                // 移除maskView
                [self removeMaskView];
                _shouldBeginAnimation = NO;
            }];
        } else {
            
            // 动画打开抽屉
            [UIView animateWithDuration:DRAWER_ANIMATION_DURATION animations:[self drawerOpenAnimation] completion:^(BOOL finished) {
                // 添加maskView
                [self addMaskView];
                _shouldBeginAnimation = NO;
            }];
        }
        
        
    }

}

// 通过手指的百分比控制动画
- (void)handlerAnimationWithPercent:(CGFloat)percent
{
    // 对缩放倍数进行插值
    CGFloat scale = [self interpolateFrom:1 to:0.7 percent:percent];
    
    // 缩放大小
    _naVC.view.transform = CGAffineTransformMakeScale(scale, scale);
    
    // 对center进行插值
    CGFloat x = [self interpolateFrom:CGRectGetWidth(self.view.bounds)/2 to:CGRectGetWidth(self.view.bounds) percent:percent];
    
    // 重新设置center
    _naVC.view.center = CGPointMake(x, _naVC.view.center.y);
    
    // 对抽屉视图缩放大小进行插值
    CGFloat scaleB = [self interpolateFrom:0.7 to:1 percent:percent];
    
    // 对抽屉式图center进行插值
    CGFloat xB = [self interpolateFrom:0 to:CGRectGetWidth(self.view.bounds)/2 percent:percent];
    
    _leftVC.view.transform = CGAffineTransformMakeScale(scaleB, scaleB);
    _leftVC.view.center = CGPointMake(xB, CGRectGetHeight(self.view.bounds)/2);
    
    // 对抽屉视图alpha进行插值
    CGFloat alpha = [self interpolateFrom:0 to:1 percent:percent];
    _leftVC.view.alpha = alpha;
}


#pragma mark - 插值公式
- (CGFloat)interpolateFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent
{
    return from + (to - from)*percent;
}

#pragma mark - 抽屉打开与关闭的动画

// 抽屉打开动画
// 主要视图缩小到0.7倍，并且center.x移到屏幕的右边界
// left大小还原，center到屏幕中心， alpha为1
- (void (^)(void))drawerOpenAnimation
{
    void (^animationBlock)(void);
    animationBlock = ^void(void) {
        _naVC.view.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _naVC.view.center = CGPointMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)/2);
        
        _leftVC.view.transform = CGAffineTransformMakeScale(1, 1);
        _leftVC.view.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2);
        _leftVC.view.alpha = 1;
    };
    return animationBlock;
}

// 抽屉关闭动画
// 缩放和center全部还原到原来的大小和位置
- (void (^)(void))drawerCloseAnimation
{
    void (^animationBlock)(void);
    animationBlock = ^void(void) {
        _naVC.view.transform = CGAffineTransformIdentity;
        _naVC.view.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2, CGRectGetHeight(self.view.bounds)/2);
        
        _leftVC.view.transform = CGAffineTransformMakeScale(0.7, 0.7);
        _leftVC.view.center = CGPointMake(0, CGRectGetHeight(self.view.bounds)/2);
        _leftVC.view.alpha = 0;
    };
    return animationBlock;
}

#pragma mark - 移除和添加maskView
- (void)addMaskView
{
    if (!_maskGestureView) {
        self.maskGestureView = [[UIView alloc] initWithFrame:_naVC.view.frame];
        [self.maskGestureView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
        [self.maskGestureView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)]];
        [self.view addSubview:self.maskGestureView];
    }
}

- (void)removeMaskView
{
    if (self.maskGestureView) {
        [self.maskGestureView removeFromSuperview];
        self.maskGestureView = nil;
    }
}

@end
