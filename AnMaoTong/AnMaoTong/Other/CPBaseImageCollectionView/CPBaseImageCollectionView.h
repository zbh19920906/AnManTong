//
//  CPBaseImageCollectionView.h
//  yuexia
//
//  Created by 陈平 on 2018/7/31.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CPBaseImageCollectionOption : NSObject

/**
 是否显示添加按钮
 */
@property (nonatomic , assign) BOOL isShowAddBtn;

/**
 最多几张
 */
@property (nonatomic , assign) NSInteger maxCount;

/**
 大小
 */
@property (nonatomic , assign) CGSize itemSize;

/**
 方向
 */
@property (nonatomic , assign) UICollectionViewScrollDirection direction;

/**
 区间距
 */
@property (nonatomic , assign) UIEdgeInsets insets;

/**
 最小行间距
 */
@property (nonatomic , assign) CGFloat minimumLineSpacing;

/**
 最小列间距
 */
@property (nonatomic , assign) CGFloat minimumInteritemSpacing;

@end

@protocol CPBaseImageCollectionViewDelegate;

@interface CPBaseImageCollectionView : UIView

@property (nonatomic , assign) id<CPBaseImageCollectionViewDelegate> cpDelegate;

@property (nonatomic , strong , readonly) UICollectionView *collectionView;

@property (nonatomic , strong) NSMutableArray<UIImage *> *imageDataSource;

@property (nonatomic , strong , readonly) CPBaseImageCollectionOption *option;

+ (instancetype)baseImageCollectionViewWithOption:(CPBaseImageCollectionOption *)option;

@end

@protocol CPBaseImageCollectionViewDelegate <NSObject>

@optional

/**
 添加图片
 */
- (void)baseImageCollectionViewForAdd:(CPBaseImageCollectionView *)imageCollectionView;


@required


@end

