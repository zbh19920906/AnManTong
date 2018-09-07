//
//  AMTContentView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/5.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTContentView.h"
#import "AMTBrandItemCell.h"
@interface AMTContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) BaseCollectionView *collection;
@end
@implementation AMTContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collection];
    }
    return self;
}

- (void)setItemArr:(NSMutableArray *)itemArr
{
    _itemArr = itemArr;
    [self.collection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AMTBrandItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    AMTBrandModel *model = _itemArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.width - 46) / 3, 32);
    
}

- (BaseCollectionView *)collection
{
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(18, 10, 18, 10);
        _collection = [[BaseCollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerClass:[AMTBrandItemCell class] forCellWithReuseIdentifier:@"cell"];

    }
    return _collection;
}
@end
