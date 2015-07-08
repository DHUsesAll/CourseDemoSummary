//
//  CollectionViewLayoutViewController.m
//  CourseDemoSummary
//
//  Created by DreamHack on 15-7-7.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "CollectionViewLayoutViewController.h"
#import "DHCollectionViewLayout.h"

@interface CollectionViewLayoutViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation CollectionViewLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAppearance];
}

- (void)initializeAppearance
{
    self.view.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = ({
        
            UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[DHCollectionViewLayout alloc] init]];
            
            collectionView.backgroundColor = [UIColor clearColor];
            [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdf"];
            collectionView.dataSource = self;
            collectionView;
        
        });
    }
    return _collectionView;
}

#pragma mark - collection view protocol


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdf" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}



@end
