//
//  DisplayLinkWithInterpolateViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-6.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//


/*
 
    使用CADisplayLink实现每帧的动画
    需要用到线性插值的思想
    思考如何将CADisplayLink和线性插值封装起来、如何实现变速动画
 
*/

#import "DisplayLinkWithInterpolateViewController.h"

@interface DisplayLinkWithInterpolateViewController ()

@property (nonatomic, strong) CADisplayLink * displayLink;

// 动画开始的时间，单位秒
@property (nonatomic, assign) NSTimeInterval animationStartTime;

// 进行动画的视图
@property (nonatomic, strong) UIView * animationView;

@end

@implementation DisplayLinkWithInterpolateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initializeAppearance];
    [self beginAnimation];
}

- (void)initializeAppearance
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.animationView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    _animationView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_animationView];
}

- (void)beginAnimation
{
    // 动画开始时的系统当前时间
    _animationStartTime = CACurrentMediaTime();
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
}

- (void)invalidateDisplayLink
{
    if (_displayLink) {
        [_displayLink invalidate];
        self.displayLink = nil;
    }
}

#pragma mark - displayLink 回调方法
- (void)onDisplayLink:(CADisplayLink *)displayLink
{
    // 动画持续时间
    static CGFloat duration = 2;
    // 当前动画已经进行了多少时间
    CGFloat currentDuration = CACurrentMediaTime() - _animationStartTime;
    // 如果动画到了时间，则清除timer
    if (currentDuration >= duration) {
        [self invalidateDisplayLink];
    }
    // 已进行时间占总时间的比例
    CGFloat percent = currentDuration/duration;
    // 插值
    CGFloat x = [ self interpolateFrom:200 to:300 percent:percent];
    CGFloat y = [self interpolateFrom:200 to:300 percent:percent];
    // 绘制view
    _animationView.center = CGPointMake(x, y);
}

#pragma mark - 插值
- (CGFloat)interpolateFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent
{
    return from + (to - from) * percent;
}

#pragma mark - super methods
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self invalidateDisplayLink];
    [self beginAnimation];
}
@end
