//
//  MVCView.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-9.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "MVCView.h"

@implementation MVCView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        
        [self addGestureRecognizer:gesture];
    }
    
    return self;
}


- (void)onTap:(UIGestureRecognizer *)sender
{
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

@end
