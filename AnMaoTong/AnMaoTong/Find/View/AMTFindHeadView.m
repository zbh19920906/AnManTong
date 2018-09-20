//
//  AMTFindHeadView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/14.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTFindHeadView.h"
#import "AMTFindHeadCell.h"
@interface AMTFindHeadView ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)SDCycleScrollView *  cycleScrollView;
@property (nonatomic, strong) BaseCollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end
@implementation AMTFindHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    [self addSubview:self.cycleScrollView];
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [[self.pageControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        
    }];
}

- (void)setImages:(NSArray *)images
{
    NSMutableArray *imgs = [[NSMutableArray alloc]init];
    for (AMTBannerModel *model in images) {
        [imgs addObject:model.img_url];
    }
    self.cycleScrollView.imageURLStringsGroup = imgs;
}

- (void)setBrands:(NSArray *)brands
{
    _brands = brands;
    self.pageControl.numberOfPages = brands.count / 10;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _brands.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AMTFindHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = _brands[indexPath.row];
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(16, 0, 34, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / WIDTH_SCREEN;
    self.pageControl.currentPage = page;
}

//图片轮播视图
-(SDCycleScrollView*)cycleScrollView
{
    if (!_cycleScrollView) {
        // 网络加载图片的轮播器
        _cycleScrollView= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 188) delegate:self placeholderImage:imageNamed(@"banner_empty")];
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}

- (BaseCollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((WIDTH_SCREEN - 8) / 5, 60);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[BaseCollectionView alloc]initWithFrame:CGRectMake(0, 188, WIDTH_SCREEN, 191) collectionViewLayout:layout];
        _collectionView.backgroundColor = BHColor(@"ffffff");
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AMTFindHeadCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 369 - 19, WIDTH_SCREEN, 7)];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = BHColor(@"F4003F");
        _pageControl.pageIndicatorTintColor = BHColor(@"D2D2D2");
        _pageControl.hidesForSinglePage = YES;
        
    }
    return _pageControl;
}
@end
