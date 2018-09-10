//
//  CPBaseImageCollectionCell.m
//  yuexia
//
//  Created by 陈平 on 2018/7/31.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "CPBaseImageCollectionCell.h"


@interface CPBaseImageCollectionCell ()

@end


@implementation CPBaseImageCollectionCell

#pragma mark - Life
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayout];
    }
    return self;
}


#pragma mark - Public


#pragma mark - Private
- (void)setupLayout
{
    [self.contentView addSubview:self.imageView];
    [self.imageView addSubview:self.delBtn];
    
    self.imageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    
    self.delBtn.sd_layout
    .topEqualToView(self.imageView)
    .rightEqualToView(self.imageView)
    .widthIs(20)
    .heightEqualToWidth();
    
    [self.imageView setSd_cornerRadius:@5];
}

#pragma mark - Get
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = BHColor(@"e5e5e5");
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UIButton *)delBtn
{
    if (_delBtn == nil) {
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delBtn setImage:imageNamed(@"deleteImage") forState:UIControlStateNormal];
        _delBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3];
    }
    return _delBtn;
}

+ (NSString *)identifier
{
    return NSStringFromClass([self class]);
}
@end
