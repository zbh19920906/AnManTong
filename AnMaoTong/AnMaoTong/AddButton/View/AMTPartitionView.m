//
//  AMTPartitionView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/10.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTPartitionView.h"
@interface AMTPartitionView ()
@property (nonatomic, strong) NSMutableArray *labels;
@end
@implementation AMTPartitionView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.labels = [[NSMutableArray alloc]init];
    
    self.titleLab = [[BaseLabel alloc]init];
    [self.titleLab setLableColor:@"959595" font:13 bold:0];
    
    
    self.contentLab = [[BaseLabel alloc]init];
    [self.contentLab setLableColor:@"CCCCCC" font:13 bold:0];
    
    [self sd_addSubviews:@[self.titleLab,self.contentLab]];
    
    self.titleLab.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, 11)
    .heightIs(13);
    [self.titleLab setSingleLineAutoResizeWithMaxWidth:100];
    
    self.contentLab.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, 63)
    .heightIs(13);
    [self.contentLab setSingleLineAutoResizeWithMaxWidth:250];
    
     self.tap = [UITapGestureRecognizer new];
    [self addGestureRecognizer:self.tap];
    
    for (NSInteger i = 0; i < 3; i ++) {
        BaseLabel *lable = [[BaseLabel alloc]init];
        lable.sd_cornerRadius = @(4);
        [lable setLableColor:@"222222" font:11 bold:0];
        lable.layer.borderColor = BHColor(@"222222").CGColor;
        lable.layer.borderWidth = 1;
        lable.textAlignment = NSTextAlignmentCenter;
        lable.hidden = YES;
        [self addSubview:lable];
        
        lable.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self.titleLab, 26 + 70 *i)
        .widthIs(60)
        .heightIs(25);
        [self.labels addObject:lable];
    }
}

- (void)setCustomize_label_name:(NSString *)customize_label_name
{
    NSArray *titles = [customize_label_name componentsSeparatedByString:@"|"];
    self.contentLab.hidden = titles.count;
    for (NSInteger i = titles.count; i < self.labels.count; i ++) {
        BaseLabel *lable = self.labels[i];
        lable.hidden = YES;
    }
    
    for (NSInteger i = 0; i < titles.count; i ++) {
        BaseLabel *lable = self.labels[i];
        lable.hidden = NO;
        lable.text = titles[i];
    }
}
@end
