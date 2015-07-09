//
//  GradientLayerModel.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-9.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "GradientLayerModel.h"

@interface GradientLayerModel ()

@property (nonatomic, strong) id pointsContainer;

@end

@implementation GradientLayerModel

- (id)pointsContainer
{
    self.pointsContainer = ({
        
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
        
        // 左下角为0,0，右上角为1,1
        [array addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
        // 画10个点，y值从0-1取随机数，x值每次叠加0.1
        // 剩余9个点
        for (int i = 1; i <= 10; i++) {
            CGFloat x = i * 0.1;
            CGFloat y = (arc4random()%11)/10.f;
            [array addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            NSLog(@"%f",y);
        }
        array;
        
    });
    
    
    return _pointsContainer;
}

@end
