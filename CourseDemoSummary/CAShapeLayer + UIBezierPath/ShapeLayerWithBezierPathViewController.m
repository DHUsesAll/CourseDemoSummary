//
//  ShapeLayerWithBezierPathViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-6.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "ShapeLayerWithBezierPathViewController.h"

@interface ShapeLayerWithBezierPathViewController ()

@property (nonatomic, strong) CAShapeLayer * shapeLayer;
@property (nonatomic, strong) UIBezierPath * bezierPath;

@end

@implementation ShapeLayerWithBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAppearance];
}

- (void)initializeAppearance
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.shapeLayer];
}

#pragma mark - getter
- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = ({
        
            // layer的子类初始化均使用该便利构造
            CAShapeLayer * shapeLayer = [CAShapeLayer layer];
            
            shapeLayer.frame = CGRectMake(100, 100, 200, 200);
            // 设置路径，shapeLayer就拥有了这个路径的内容
            shapeLayer.path = self.bezierPath.CGPath;
            // 背景颜色
            shapeLayer.backgroundColor = [UIColor greenColor].CGColor;
            // 描线颜色（路径颜色）
            shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
            shapeLayer.lineWidth = 5;
            // 填充颜色（路径封闭起来后路径内的颜色）
            shapeLayer.fillColor = [UIColor blueColor].CGColor;
            
            shapeLayer;
        
        });
    }
    return _shapeLayer;
}

/*
 
 返回一个矩形的路径
+ (UIBezierPath *)bezierPathWithRect:(CGRect)rect;
 返回一个矩形的内切圆的路径
+ (UIBezierPath *)bezierPathWithOvalInRect:(CGRect)rect;
 返回一个圆角矩形的路径
+ (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius; // rounds all corners with the same horizontal and vertical radius
 指定一个矩形哪些角是圆角，返回该矩形的路径
+ (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
 返回一段圆弧的路径
+ (UIBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
 返回一个CGPath的路径
+ (UIBezierPath *)bezierPathWithCGPath:(CGPathRef)CGPath;
*/

- (UIBezierPath *)bezierPath
{
    if (!_bezierPath) {
        _bezierPath = ({
        
            // 关于贝塞尔曲线构成原理和数学推导公式，参见维基百科
            UIBezierPath * bezierPath = [UIBezierPath bezierPath];
            // 以shapeLayer自身坐标系为参考系
            
            [bezierPath moveToPoint:CGPointMake(0, 0)];
            [bezierPath addCurveToPoint:CGPointMake(200, 200) controlPoint1:CGPointMake(80, 210) controlPoint2:CGPointMake(160, 0)];
            bezierPath;
        });
    }
    return _bezierPath;
}

@end
