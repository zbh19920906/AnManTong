//
//  KKHistorySearchView.m
//  CloudMoto
//
//  Created by lk03 on 2018/3/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "KKHistorySearchView.h"
#import "SDCollectionTagsFlowLayout.h"
#import "KKTagCell.h"
#import "KKSearchReusableView.h"
#import "KKHistorySearchModel.h"

@interface KKHistorySearchView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *searchCollectView;
@property(nonatomic, strong) NSMutableArray *searchTagArray;

@end

@implementation KKHistorySearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionFrame];
    }
    return self;
}

- (void)setupCollectionFrame
{
    [self sd_addSubviews:@[self.searchCollectView]];
    
    _searchCollectView.sd_resetLayout
    .spaceToSuperView(UIEdgeInsetsZero);
    
    [self getHistorySearchRecordsData];
}

#pragma mark - 缓存搜索记录
//保存搜索记录
- (void)saveSearchRecordsWithTitle:(NSString *)title
{
    NSDictionary *dic = @{@"title" : title};
    
    NSMutableArray *dataArr = [[self getSearchRecords] mutableCopy];
    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //去掉相同的
        NSDictionary *objDic = (NSDictionary *)obj;
        if ([objDic[@"title"] isEqual:dic[@"title"]] ) {
            [dataArr removeObjectAtIndex:idx];
            *stop = YES;
        }
    }];
    
    [dataArr insertObject:dic atIndex:0];
    
    if (dataArr.count > 10) {
        //最多只显示10个
        [dataArr removeLastObject];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dataArr forKey:HistorySearchRecords];
    [userDefaults synchronize];
    
    [self getHistorySearchRecordsData];
}

//获取搜索记录
- (NSArray *)getSearchRecords
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults arrayForKey:HistorySearchRecords];
    
    return array ? array : @[];
}

//清除搜索记录
- (void)clearSearchRecords
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:HistorySearchRecords];
    [userDefaults synchronize];
    
    //刷新页面
    [self.searchTagArray removeAllObjects];
    [self.searchCollectView reloadData];
    self.hidden = YES;
}

#pragma mark - 赋值
- (void)getHistorySearchRecordsData
{
    NSMutableArray *historyArr = [KKHistorySearchModel mj_objectArrayWithKeyValuesArray:[self getSearchRecords]];
    
    if (historyArr.count > 0) {
        self.searchTagArray = historyArr;
        [self resetCollectionLayout];
    }
}

//计算collectionview的高度
- (void)resetCollectionLayout
{
    [_searchCollectView reloadData];
    [_searchCollectView layoutIfNeeded];
    
    //延迟，放在主线程才能保证collectionViewContentSize的准确性
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGFloat contentHeight = _searchCollectView.collectionViewLayout.collectionViewContentSize.height;
   
        //修改collectionview的高度
        _searchCollectView.sd_resetLayout
        .leftEqualToView(self)
        .topEqualToView(self)
        .rightEqualToView(self)
        .heightIs(contentHeight);
        
        if (_delegate && [_delegate respondsToSelector:@selector(getCollectionViewContentSizeOfHeight:)]) {
            [self.delegate getCollectionViewContentSizeOfHeight:contentHeight];
        }
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchTagArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KKTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([KKTagCell class]) forIndexPath:indexPath];
    cell.searchModel = _searchTagArray[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        KKSearchReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([KKSearchReusableView class]) forIndexPath:indexPath];
        headerView.hidden = self.searchTagArray.count == 0 ? YES : NO;
        
        weakSelf(self);
        [[headerView.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            //清除历史记录
            [weakSelf clearHistorySearchResult];
        }];
        reusableView = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        reusableView = footerview;
        
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KKHistorySearchModel *model = _searchTagArray[indexPath.item];
    CGFloat textW = [NSObject sizeWithFont:[UIFont systemFontOfSize:14] Text:model.title MaxSize:CGSizeMake(WIDTH_SCREEN - 150, MAXFLOAT)].width;
    
    //加上店铺小图标的宽度
    CGFloat imgW = [model.storeID length] > 0 ? 22 : 0;
    return CGSizeMake(textW + 16 + imgW, 30);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KKHistorySearchModel *model = _searchTagArray[indexPath.item];
    
    //选中某个item
    if (_delegate && [_delegate respondsToSelector:@selector(collectionDidSelectItemWithModel:)]) {
        [self.delegate collectionDidSelectItemWithModel:model];
    }
}

#pragma mark - 清除历史记录
- (void)clearHistorySearchResult
{
    weakSelf(self);
    ZLAlertView *alertView = [[ZLAlertView alloc] initWithTitle:@"清除历史记录" message:@""];
    [alertView addBtnTitle:@"取消" action:^{
    }];
    [alertView addBtnTitle:@"确定" action:^{
        [weakSelf clearSearchRecords];
    }];
    [alertView showAlertWithSender:getWindow.rootViewController];
}

#pragma mark - collectionview
- (UICollectionView *)searchCollectView
{
    if (!_searchCollectView) {
        //创建一个layout布局类
        SDCollectionTagsFlowLayout *layout = [[SDCollectionTagsFlowLayout alloc] init];
        layout.betweenOfCell = 10;
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 10, 15);
        layout.minimumLineSpacing = 10;
        layout.headerReferenceSize = CGSizeMake(WIDTH_SCREEN, 50);
        
        _searchCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout: layout];
        _searchCollectView.backgroundColor = [UIColor whiteColor];
        _searchCollectView.delegate = self;
        _searchCollectView.dataSource = self;
        _searchCollectView.scrollEnabled = NO;
        
        [_searchCollectView registerClass:[KKTagCell class] forCellWithReuseIdentifier:NSStringFromClass([KKTagCell class])];
        [_searchCollectView registerClass:[KKSearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([KKSearchReusableView class])];
        [_searchCollectView registerClass:[UICollectionReusableView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    }
    return _searchCollectView;
}

@end
