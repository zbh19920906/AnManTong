//
//  CPBaseImageCollectionCell.h
//  yuexia
//
//  Created by 陈平 on 2018/7/31.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPBaseImageCollectionCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *imageView;

@property (nonatomic , strong) UIButton *delBtn;

+ (NSString *)identifier;

@end
