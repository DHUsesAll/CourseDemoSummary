//
//  HomeViewModel.h
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-6.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject

@property (nonatomic, strong, readonly) id courseInfoContainer;
@property (nonatomic, strong, readonly) id courseControllerInfoContainer;

// 处理tableview 数据源, controller直接拿来用
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)cellInfoAtIndexPath:(NSIndexPath *)indexPath;


@end
