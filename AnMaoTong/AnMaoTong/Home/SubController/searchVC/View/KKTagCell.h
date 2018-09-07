//
//  KKTagCell.h
//  CloudMoto
//
//  Created by lk03 on 2018/3/10.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKHistorySearchModel;

@interface KKTagCell : UICollectionViewCell

//搜索页-历史搜索标签
@property (nonatomic, strong) KKHistorySearchModel *searchModel;

//首页-满减标签和店铺优势标签
- (void)tagTitle:(NSString *)title advantage:(NSString *)advantage;

@end
