//
//  MVCView.h
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-9.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVCView;
typedef void(^TapBlock)(MVCView * view);

@interface MVCView : UIView

@property (nonatomic, copy) TapBlock tapBlock;


@end
