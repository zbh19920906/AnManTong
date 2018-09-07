//
//  KKSearchReusableView.m
//  CloudMoto
//
//  Created by lk03 on 2018/3/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "KKSearchReusableView.h"

@interface KKSearchReusableView ()

@property (nonatomic, strong) BaseLabel *titleLab;
@property (nonatomic, strong) BaseView *bgView;

@end

@implementation KKSearchReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupHeaderFrame];
        self.backgroundColor = [UIColor cz_ToUIColorByStr:@"f2f2f2"];
    }
    return self;
}

- (void)setupHeaderFrame
{
    self.titleLab = [BaseLabel new];
    [_titleLab setLableColor:@"666666" font:14 bold:0];
    _titleLab.text = @"历史搜索";
    
    self.deleteBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:imageNamed(@"delete") forState:UIControlStateNormal];
    
    self.bgView = [BaseView new];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_bgView];
    [_bgView sd_addSubviews:@[_titleLab, _deleteBtn]];
    
    _bgView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomSpaceToView(self, 1)
    .topSpaceToView(self, 10);

    _titleLab.sd_layout
    .leftSpaceToView(_bgView, 15)
    .centerYEqualToView(_bgView)
    .widthIs(100)
    .autoHeightRatio(0);
    
    _deleteBtn.sd_layout
    .rightSpaceToView(_bgView, 10)
    .centerYEqualToView(_titleLab)
    .widthIs(30)
    .heightEqualToWidth();
}

@end
