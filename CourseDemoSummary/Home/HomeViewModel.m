//
//  HomeViewModel.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-6.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel ()

// id类型增加安全性，hacker们并不能轻易知道这里面的内容是神马

// 课程信息
@property (nonatomic, strong) id courseInfoContainer;

// 各课程controller的类名
@property (nonatomic, strong) id courseControllerInfoContainer;


// 声明私有方法
- (void)_addCourseInfo:(id)courseInfo;
- (void)_addCourseControllerInfo:(id)courseControllerInfo;
- (void)_tempInitialize;

@end

@implementation HomeViewModel

- (instancetype)init
{
    self = [super init];
    
    [self _tempInitialize];
    
    return self;
}

#pragma mark - 接口方法
- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self.courseInfoContainer count];
}

- (id)cellInfoAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.courseInfoContainer objectAtIndex:indexPath.row];
}

#pragma mark - getter
- (id)courseInfoContainer
{
    if (!_courseInfoContainer) {
        
        _courseInfoContainer = [NSMutableArray arrayWithCapacity:0];
    }
    return _courseInfoContainer;
}

- (id)courseControllerInfoContainer
{
    if (!_courseControllerInfoContainer) {
        _courseControllerInfoContainer = [NSMutableArray arrayWithCapacity:0];
    }
    return _courseControllerInfoContainer;
}

#pragma mark - 私有方法
- (void)_addCourseInfo:(id)courseInfo
{
    [self.courseInfoContainer addObject:courseInfo];
}

- (void)_addCourseControllerInfo:(id)courseControllerInfo
{
    [self.courseControllerInfoContainer addObject:courseControllerInfo];
}

// 添加课程信息
- (void)_tempInitialize
{
    [self _addCourseInfo:@"UIView动画原理"];
    [self _addCourseControllerInfo:@"AnimationPrincipleViewController"];
    
    [self _addCourseInfo:@"Layer 3D变换"];
    [self _addCourseControllerInfo:@"LayerTransform3DViewController"];
    
    [self _addCourseInfo:@"动画时间控制"];
    [self _addCourseControllerInfo:@"AnimationTimeControllingViewController"];
    
    [self _addCourseInfo:@"CADisplayLink + 插值"];
    [self _addCourseControllerInfo:@"DisplayLinkWithInterpolateViewController"];
    
    [self _addCourseInfo:@"CAShapeLayer + UIBezierPath"];
    [self _addCourseControllerInfo:@"ShapeLayerWithBezierPathViewController"];
    
    [self _addCourseInfo:@"CAGradientLayer + mask"];
    [self _addCourseControllerInfo:@"GradientLayerWithMaskViewController"];
}

@end
