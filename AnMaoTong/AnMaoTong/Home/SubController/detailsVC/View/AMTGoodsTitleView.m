//
//  AMTGoodsTitleView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTGoodsTitleView.h"
@interface AMTGoodsTitleView ()
@property (nonatomic, strong) NSMutableArray *labels;
@end
@implementation AMTGoodsTitleView

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
    for (NSInteger i = 0; i < 3; i ++) {
        BaseLabel *lab = [[BaseLabel alloc]init];
        if (i ==  0) {
            lab.backgroundColor = [UIColor cz_ToUIColorByStr:@"4FABFE"];
        }else if (i ==  1) {
            lab.backgroundColor = [UIColor cz_ToUIColorByStr:@"FF568F"];
        }else{
            lab.backgroundColor = [UIColor cz_ToUIColorByStr:@"DBB470"];
        }
        [lab setLableColor:@"FFFFFF" font:9 bold:0];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        lab.sd_cornerRadius = @(2);
        [self.labels addObject:lab];
    }
}

- (void)setTitles:(NSArray *)titles
{
    for (NSInteger i = titles.count; i < self.labels.count; i ++) {
        BaseLabel *lab = self.labels[i];
        lab.hidden = YES;
    }
    for (NSInteger i = 0; i < titles.count; i ++) {
        BaseLabel *lab = self.labels[i];
        lab.text = titles[i];
        lab.hidden = NO;
//        lab.frame = CGRectMake(i * (45 +6) + 10, 0, 45, 15);
        lab.sd_layout
        .topEqualToView(self)
        .leftSpaceToView(self, i * (45 +6) + 10)
        .widthIs(45)
        .heightIs(15);
    }
}
@end
