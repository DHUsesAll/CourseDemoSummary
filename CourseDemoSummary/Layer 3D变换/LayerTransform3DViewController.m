//
//  LayerTransform3DViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-6.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "LayerTransform3DViewController.h"

@interface LayerTransform3DViewController ()

@property (nonatomic, strong) CALayer * transformLayer;

- (void)_initializeAppearence;
- (void)_rotateAnimation;

@end

@implementation LayerTransform3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initializeAppearence];
}

- (void)_initializeAppearence
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.transformLayer];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _rotateAnimation];
}

// 旋转动画
- (void)_rotateAnimation
{
    // 声明一个原始的transform3D矩阵
    // The identity transform: [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1]
    CATransform3D transform = CATransform3DIdentity;
    
    // 为3D旋转设置透视效果
    transform.m34 = -1.f/750;
    
    
    // 后面三个参数确定一个三维向量，将沿着这个向量旋转
    transform = CATransform3DRotate(transform, M_PI/3, 0, 1, 0);
    
    // 使用basicAnimation执行3D旋转动画
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = 2.68;
    
    // 如果只设置fromValue不设置toValue的话，basicAnimation会从fromValue到modelLayer的属性值之间进行插值
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    self.transformLayer.transform = transform;
    
    
    [self.transformLayer addAnimation:animation forKey:@"transformAnimation"];
}

#pragma mark - getter
- (CALayer *)transformLayer
{
    if (!_transformLayer) {
        
        _transformLayer = ({
        
            CALayer * layer = [CALayer layer];
            
            layer.frame = CGRectMake(100, 100, 200, 200);
            layer.backgroundColor = [UIColor greenColor].CGColor;
            
            layer;
        
        });
        
    }
    
    return _transformLayer;
}

@end
