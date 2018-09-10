//
//  ReleaseDynamicCell.m
//  yuexia
//
//  Created by 陈平 on 2018/8/3.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "ReleaseDynamicCell.h"

@interface ReleaseDynamicCell ()

@end

@implementation ReleaseDynamicCell

#pragma mark - Life
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addBottomLineWithOffset:0 left:20 right:0 color:BHColor(@"e5e5e5") height:0.5];
    }
    return self;
}

#pragma mark - Public


#pragma mark - Private
- (void)setupLayout
{
    
}

#pragma mark - Get

@end
