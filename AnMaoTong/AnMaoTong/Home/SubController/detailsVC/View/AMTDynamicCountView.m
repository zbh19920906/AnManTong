//
//  AMTDynamicCountView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDynamicCountView.h"
@interface AMTDynamicCountView ()

@end
@implementation AMTDynamicCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    weakSelf(self);
    self.commentBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setImage:imageNamed(@"comment") forState:UIControlStateNormal];
    [self.commentBtn setLableColor:@"B9B9B9" font:12 bold:0];
    [[self.commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [myNoti postNotificationName:commentNoti object:nil userInfo:@{@"model" : weakSelf.model}];
    }];
    
    self.collectionBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.collectionBtn setImage:imageNamed(@"collection") forState:UIControlStateNormal];
    [self.collectionBtn setImage:imageNamed(@"collection_pre") forState:UIControlStateSelected];
    [self.collectionBtn setLableColor:@"B9B9B9" font:12 bold:0];
    [[self.collectionBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [myNoti postNotificationName:collectionNoti object:nil userInfo:@{@"model" : weakSelf.model}];
    }];
    
    self.likeBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setImage:imageNamed(@"like") forState:UIControlStateNormal];
    [self.likeBtn setImage:imageNamed(@"like_pre") forState:UIControlStateSelected];
    [self.likeBtn setLableColor:@"B9B9B9" font:12 bold:0];
    [[self.likeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [myNoti postNotificationName:likeNoti object:nil userInfo:@{@"model" : weakSelf.model}];
    }];
    
    self.browseBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.browseBtn setImage:imageNamed(@"browse") forState:UIControlStateNormal];
    [self.browseBtn setLableColor:@"B9B9B9" font:12 bold:0];
    
    [self sd_addSubviews:@[self.commentBtn,self.collectionBtn,self.likeBtn,self.browseBtn]];
    CGFloat width = (WIDTH_SCREEN - 24 - 30) / 4;
    self.commentBtn.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, 12)
    .heightIs(15)
    .widthIs(width);
    
    self.collectionBtn.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self.commentBtn, 10)
    .heightIs(15)
    .widthIs(width);
    
    self.likeBtn.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self.collectionBtn, 10)
    .heightIs(15)
    .widthIs(width);
    
    self.browseBtn.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self.likeBtn, 10)
    .heightIs(15)
    .widthIs(width);
}

- (void)setModel:(AMTDetailsModel *)model
{
    _model = model;
    [self.commentBtn setTitle:BHIString(model.dynamic_num.comment_count) forState:UIControlStateNormal];
    [self.collectionBtn setTitle:BHIString(model.dynamic_num.collection_count) forState:UIControlStateNormal];
    [self.likeBtn setTitle:BHIString(model.dynamic_num.like_count) forState:UIControlStateNormal];
    [self.browseBtn setTitle:BHIString(model.dynamic_num.browse_count) forState:UIControlStateNormal];
    self.collectionBtn.selected = model.dynamic_num.my_collection;
    self.likeBtn.selected = model.dynamic_num.my_like;
}
@end
