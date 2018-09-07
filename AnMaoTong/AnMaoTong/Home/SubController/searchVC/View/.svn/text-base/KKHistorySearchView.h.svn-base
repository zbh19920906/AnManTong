//
//  KKHistorySearchView.h
//  CloudMoto
//
//  Created by lk03 on 2018/3/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "BaseView.h"
@class KKHistorySearchModel;

@protocol KKSearchCollectinViewDelegate <NSObject>
@optional
/**
 *  修改collectionview的高度
 */
- (void)getCollectionViewContentSizeOfHeight:(CGFloat)height;

/**
 *  点击collectionview的cell
 */
- (void)collectionDidSelectItemWithModel:(KKHistorySearchModel *)model;

@end

@interface KKHistorySearchView : BaseView

@property (nonatomic, weak) id <KKSearchCollectinViewDelegate> delegate;

//获取搜索记录
- (NSArray *)getSearchRecords;
//缓存搜索记录
- (void)saveSearchRecordsWithTitle:(NSString *)title;

@end
