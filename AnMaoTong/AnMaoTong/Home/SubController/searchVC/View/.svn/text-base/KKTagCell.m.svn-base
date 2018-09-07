//
//  KKTagCell.m
//  CloudMoto
//
//  Created by lk03 on 2018/3/10.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "KKTagCell.h"
#import "KKHistorySearchModel.h"

@interface KKTagCell ()

@property (nonatomic, strong) BaseButton *itemBtn;

@end

@implementation KKTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupFrame];
    }
    return self;
}

- (void)setupFrame
{
    self.itemBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    _itemBtn.userInteractionEnabled = NO;
    [self addSubview:_itemBtn];
    
    _itemBtn.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

#pragma mark - 首页-满减标签和店铺优势标签
- (void)tagTitle:(NSString *)title advantage:(NSString *)advantage;
{
    _itemBtn.hidden = title.length == 0;
    //判断显示的颜色
    NSString *colorStr = [title isEqualToString:advantage] ? @"37d2ba" : @"fe402c";
    [_itemBtn setLableColor:colorStr font:10 bold:0];
    _itemBtn.layer.borderWidth = 0.4;
    _itemBtn.layer.borderColor = [[UIColor cz_ToUIColorByStr:colorStr] colorWithAlphaComponent:0.5].CGColor;
    _itemBtn.layer.cornerRadius = 2;
    
    //赋值
    [_itemBtn setTitle:title forState:UIControlStateNormal];
}

#pragma mark - 搜索页，历史搜索记录
- (void)setSearchModel:(KKHistorySearchModel *)searchModel
{
    _searchModel = searchModel;
    
    [_itemBtn setLableColor:@"323232" font:14 bold:0];
    _itemBtn.layer.borderWidth = 0.6;
    _itemBtn.layer.borderColor = [UIColor cz_ToUIColorByStr:@"e0e0e0"].CGColor;
    
    //赋值
    [_itemBtn setTitle:[NSString stringWithFormat:@" %@ ", searchModel.title] forState:UIControlStateNormal];
    UIImage *img = searchModel.storeID.length != 0 ? imageNamed(@"search_store_icon") : nil;
    [_itemBtn setImage:img forState:UIControlStateNormal];
    
}

@end
