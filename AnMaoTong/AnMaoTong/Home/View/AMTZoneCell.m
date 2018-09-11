//
//  AMTZoneCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/11.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTZoneCell.h"
@interface AMTZoneCell ()
@property (nonatomic, strong) NSMutableArray *viewArray;
@end
@implementation AMTZoneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.viewArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)setZoneArray:(NSArray *)zoneArray
{
    _zoneArray = zoneArray;
    for (NSInteger i = self.viewArray.count; i < zoneArray.count; i ++) {
        BaseButton *btn = [BaseButton buttonWithType:UIButtonTypeCustom];
        
        [self.contentView addSubview:btn];
        [self.viewArray addObject:btn];
    }
    
    for (NSInteger i = zoneArray.count; i < self.viewArray.count; i ++) {
        BaseButton *btn = self.viewArray[i];
        btn.hidden = YES;
    }
    for (NSInteger i = 0; i < zoneArray.count; i ++) {
        BaseButton *btn = self.viewArray[i];
        btn.backgroundColor = [UIColor redColor];
        btn.hidden = NO;
        CGFloat width = (WIDTH_SCREEN - 30) / 2;
        btn.frame = CGRectMake(i %2 * (width + 10) + 10, i/2 * (85 + 10) + 10, width, 85);
        
    }
}
@end
