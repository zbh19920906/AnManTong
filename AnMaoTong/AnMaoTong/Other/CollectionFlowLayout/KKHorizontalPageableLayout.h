//
//  KKHorizontalPageableLayout.h
//  CloudMoto
//
//  Created by lk03 on 2018/3/8.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKHorizontalPageableLayout : UICollectionViewFlowLayout

//  一行中 cell 的个数
@property (nonatomic, assign) NSUInteger itemCountPerRow;

//    一页显示多少行
@property (nonatomic, assign) NSUInteger rowCount;

@end
