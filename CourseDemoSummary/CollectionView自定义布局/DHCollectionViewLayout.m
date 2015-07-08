//
//  DHCollectionViewLayout.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-7.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "DHCollectionViewLayout.h"

@implementation DHCollectionViewLayout
{
    CGFloat width_ ;
    CGFloat height_ ;
    CGFloat interval_ ;
}

- (void)prepareLayout
{
    [super prepareLayout];
    width_ = 120;
    height_ = 220;
    interval_ = 10;
}

- (CGSize)collectionViewContentSize
{
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    CGFloat contentHeight = numberOfItems * height_ + (numberOfItems - 1) * interval_;
    
    CGFloat contentWidth = CGRectGetWidth(self.collectionView.frame);
    
    return CGSizeMake(contentWidth, contentHeight);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layoutAttributes.size = CGSizeMake(width_, height_);
    
    UICollectionView * collectionView = self.collectionView;
    
    CGFloat centerX = CGRectGetWidth(collectionView.frame) - width_/2;
    
    if (indexPath.row % 2 == 0) {
        centerX = width_/2;
    }
    
    CGFloat centerY = indexPath.row * (interval_ + height_) + height_/2;
    
    layoutAttributes.center = CGPointMake(centerX, centerY);
    
    
    
    return layoutAttributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * layoutAttributes = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        
        UICollectionViewLayoutAttributes * layoutAttribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        [layoutAttributes addObject:layoutAttribute];
        
        
    }
    
    
    return layoutAttributes;
    
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSInteger cellIndex = proposedContentOffset.y / (height_+interval_);
    CGFloat referenceLineY = cellIndex * (height_+interval_) - interval_/2;
    if (proposedContentOffset.y > referenceLineY) {
        cellIndex ++;
    }
    return CGPointMake(proposedContentOffset.x, cellIndex*(height_+interval_));
}

@end











