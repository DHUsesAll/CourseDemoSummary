//
//  MVCModel.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-9.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "MVCModel.h"

@implementation MVCModel

- (instancetype)init
{
    self = [super init];
    
    [self performSelector:@selector(didComplete) withObject:nil afterDelay:2];
    
    return self;
}

- (void)didComplete
{
    // KVO必须使用self.进行辅助，否则无法触发keyValue coding
    self.dataList = @[@"a123",@"adzxc"];
}


@end
