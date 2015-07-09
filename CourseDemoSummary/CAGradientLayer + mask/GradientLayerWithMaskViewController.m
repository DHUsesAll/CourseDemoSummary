//
//  GradientLayerWithMaskViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-6.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "GradientLayerWithMaskViewController.h"
#import "GradientLayerModel.h"

@interface GradientLayerWithMaskViewController ()

@property (nonatomic, strong) CAGradientLayer * gradientLayer;
@property (nonatomic, strong) CAShapeLayer * maskLayer;
@property (nonatomic, strong) GradientLayerModel * model;

// 声明私有方法
- (void)_startStroke;
- (CGPoint)_positionFromModel:(CGPoint)aPoint;

@end

@implementation GradientLayerWithMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAppearance];
}

- (void)initializeAppearance
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.gradientLayer];
    [self _startStroke];
}

#pragma mark - getter
- (CAGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = ({
        
            CAGradientLayer * gradientLayer = [CAGradientLayer layer];
            
            gradientLayer.frame = self.view.bounds;
            
            // 起始点和结束点
            // 类似使用PS的线性渐变工具从起始点到结束点拉一条线
            // 点是相对坐标，0表示开始的地方，1表示结束的地方，0.5表示一半
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
            // 渐变的颜色，注意要用桥接将结构体指针转换成OC对象指针
            gradientLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor redColor].CGColor];

            gradientLayer;
        
        });
    }
    return _gradientLayer;
}

- (GradientLayerModel *)model
{
    if (!_model) {
        _model = ({
        
            GradientLayerModel * model = [[GradientLayerModel alloc] init];
            
            model;
        
        });
    }
    
    return _model;
}

- (CAShapeLayer *)maskLayer
{
    if (!_maskLayer) {
        _maskLayer = ({
        
            CAShapeLayer * layer = [CAShapeLayer layer];
            self.gradientLayer.mask = layer;
            layer.frame = self.gradientLayer.bounds;
            layer.lineWidth = 5;
            layer.fillColor = [UIColor clearColor].CGColor;
            layer.strokeColor = [UIColor redColor].CGColor;
            layer;
        
        });
    }
    return _maskLayer;
}

// 点击界面开始动画
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _startStroke];
}

#pragma mark - 私有方法
// model中的点转换成UIKit中的坐标
- (CGPoint)_positionFromModel:(CGPoint)aPoint
{
    CGFloat x = aPoint.x*CGRectGetWidth(self.gradientLayer.bounds);
    CGFloat y = CGRectGetHeight(self.gradientLayer.bounds) - aPoint.y*(CGRectGetHeight(self.gradientLayer.bounds) -64);
    
    return CGPointMake(x, y);
}

- (void)_startStroke
{
    // 设置路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    NSArray * points = [self.model pointsContainer];
    
    CGPoint pointFromModel = [[points objectAtIndex:0] CGPointValue];
    // move to 第一个点
    [bezierPath moveToPoint:[self _positionFromModel:pointFromModel]];
    
    for (int i = 1; i < [points count]; i++) {
        CGPoint pointFromModel = [[points objectAtIndex:i] CGPointValue];
        
        [bezierPath addLineToPoint:[self _positionFromModel:pointFromModel]];
    }
    
    self.maskLayer.path = bezierPath.CGPath;
    
    
    // 开始动画
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"strokeEnd";
    animation.fromValue = @0;
    animation.duration = 1.6;
    [self.maskLayer addAnimation:animation forKey:@"animation"];
}

@end
