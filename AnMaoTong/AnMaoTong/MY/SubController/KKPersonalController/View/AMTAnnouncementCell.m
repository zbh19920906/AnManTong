//
//  AMTAnnouncementCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTAnnouncementCell.h"
@interface AMTAnnouncementCell ()
@property (nonatomic, strong) BaseTextView *textView;
@property (nonatomic, strong) BaseLabel *countLab;
@end
@implementation AMTAnnouncementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    BaseLabel *titleLab = [[BaseLabel alloc]init];
    [titleLab setLableColor:@"666666" font:14 bold:0];
    titleLab.text = @"公告";
    
    self.textView = [[BaseTextView alloc]init];
    self.textView.placeholder = @"在这里输入公告…";
    self.textView.kMaxNumber = 150;
    [self.textView setLableColor:@"222222" font:12 bold:0];
    weakSelf(self);
    [[self.textView rac_textSignal] subscribeNext:^(id x) {
        NSInteger length = weakSelf.textView.text.length > 150 ? 150 : weakSelf.textView.text.length;
        weakSelf.countLab.text = [NSString stringWithFormat:@"%ld/150",length];
    }];
    
    self.countLab = [[BaseLabel alloc]init];
    [self.countLab setLableColor:@"CCCCCC" font:11 bold:0];
    self.countLab.text = @"0/150";
    [self.contentView sd_addSubviews:@[titleLab,self.textView,self.countLab]];
    
    titleLab.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 16)
    .heightIs(14);
    [titleLab setSingleLineAutoResizeWithMaxWidth:100];
    
    self.textView.sd_layout
    .topSpaceToView(titleLab, 10)
    .leftSpaceToView(self.contentView, 16)
    .rightSpaceToView(self.contentView, 16)
    .heightIs(44);
    
    self.countLab.sd_layout
    .rightSpaceToView(self.contentView, 11)
    .bottomSpaceToView(self.contentView, 8)
    .heightIs(11);
    [self.countLab setSingleLineAutoResizeWithMaxWidth:150];
    
}
@end
