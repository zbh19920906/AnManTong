//
//  CPBaseImageCollectionView.m
//  yuexia
//
//  Created by 陈平 on 2018/7/31.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "CPBaseImageCollectionView.h"
#import "CPBaseImageCollectionCell.h"

@implementation CPBaseImageCollectionOption

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(120, 120);
        self.direction = UICollectionViewScrollDirectionVertical;
        self.insets = UIEdgeInsetsZero;
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 20;
        self.isShowAddBtn = YES;
        self.maxCount = 9;
    }
    return self;
}

@end

@interface CPBaseImageCollectionView ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong , readwrite) UICollectionView *collectionView;

@property (nonatomic , strong , readwrite) CPBaseImageCollectionOption *option;

@property (nonatomic , assign) BOOL showAdd;

@property (nonatomic , strong) NSMutableArray<UIImage *> *dataSouce;

@end

@implementation CPBaseImageCollectionView

#pragma mark - set
- (void)setImageDataSource:(NSMutableArray<UIImage *> *)imageDataSource
{
    _imageDataSource = imageDataSource;
    self.dataSouce = [_imageDataSource mutableCopy];
    
    self.showAdd = NO;
    if (self.option.isShowAddBtn &&
        self.dataSouce.count < self.option.maxCount) {
        self.showAdd = YES;
        [self.dataSouce addObject:imageNamed(@"releaseDynamic")];
    }
    [self.collectionView reloadData];
}

#pragma mark - Life
+ (instancetype)baseImageCollectionViewWithOption:(CPBaseImageCollectionOption *)option
{
    return [[CPBaseImageCollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 100) option:option];
}

- (instancetype)initWithFrame:(CGRect)frame option:(CPBaseImageCollectionOption *)option
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.option = option;
        [self setupLayout];
    }
    return self;
}

#pragma mark - Public


#pragma mark - Private
- (void)setupLayout
{
    [self addSubview:self.collectionView];
    
    self.collectionView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = self.dataSouce.count;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CPBaseImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CPBaseImageCollectionCell identifier] forIndexPath:indexPath];
    cell.imageView.image = self.dataSouce[indexPath.row];
    cell.delBtn.hidden = NO;
    
    if (indexPath.row == self.dataSouce.count - 1) {
        cell.delBtn.hidden = self.showAdd;
    }
    
    weakSelf(self);
    [[[cell.delBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:[cell rac_prepareForReuseSignal]] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.imageDataSource removeObjectAtIndex:indexPath.row];
        weakSelf.imageDataSource = weakSelf.imageDataSource;
    }];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.option.itemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.option.minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.option.minimumInteritemSpacing;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showAdd && (indexPath.row == self.dataSouce.count - 1))
    {
        if (self.cpDelegate && [self.cpDelegate respondsToSelector:@selector(baseImageCollectionViewForAdd:)]) {
            [self.cpDelegate baseImageCollectionViewForAdd:self];
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.option.insets;
}

#pragma mark - Get
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = self.option.direction;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[CPBaseImageCollectionCell class] forCellWithReuseIdentifier:[CPBaseImageCollectionCell identifier]];
        
    }
    return _collectionView;
}
@end
