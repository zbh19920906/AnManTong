//
//  CPBottomPromitCell.m
//  BottomPromitView
//
//  Created by lk06 on 17/2/15.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "CPBottomPromitCell.h" 
#import "CPBottomPromitManager.h"

@interface CPBottomPromitCell ()
@property (nonatomic , strong) UILabel *cpTitleLab;
@property (nonatomic , strong) UILabel *cpDescripLab;
@end

@implementation CPBottomPromitCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.cpTitleLab];
        [self.contentView addSubview:self.cpDescripLab];
        
    }
    return self;
}

-(void)setManager:(CPBottomPromitManager *)manager{
    self.cpTitleLab.text = manager.title;
    self.cpDescripLab.text = manager.detail;
    
    self.cpTitleLab.font = manager.option.titleFont;
    self.cpDescripLab.font = manager.option.detailFont;
    
    self.cpTitleLab.textColor = manager.titleColor;
    self.cpDescripLab.textColor = manager.detailColor;
    
    [self removeConstraints:self.constraints];
    
    if (manager.isCancle) {
        [self setupLayoutForCancleWithManager:manager];
    }else{
        [self setupLayoutWithManager:manager];
    }
}

-(void)setupLayoutWithManager:(CPBottomPromitManager *)manager{
    
    if (manager.isCenter) {
        [self setupLayoutForCancleWithManager:manager];
        return;
    }
    //self.cpTitleLab
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpTitleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:manager.option.spacingForTitle_Top]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpTitleLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:manager.option.spacingForTitle_Left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpTitleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-manager.option.spacingForTitle_Right]];
    
    //self.cpDescripLab
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpDescripLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.cpTitleLab attribute:NSLayoutAttributeBottom multiplier:1.0 constant:manager.option.spacingForDetail_top]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpDescripLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:manager.option.spacingForDetail_Left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpDescripLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-manager.option.spacingForDetail_Right]];
}

-(void)setupLayoutForCancleWithManager:(CPBottomPromitManager *)manager{
    
    //self.cpTitleLab
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpTitleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:manager.option.spacingForTitle_Top]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpTitleLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:manager.option.spacingForTitle_Left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpTitleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-manager.option.spacingForTitle_Right]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpTitleLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-manager.option.spacingForDetail_Bottom]];
    
    //self.cpDescripLab
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpDescripLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.cpTitleLab attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpDescripLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.cpTitleLab attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpDescripLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.cpTitleLab attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cpDescripLab attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0]];
}


#pragma mark - get
-(UILabel *)cpTitleLab{
    if (_cpTitleLab == nil) {
        _cpTitleLab = [[UILabel alloc] init];
        _cpTitleLab.textAlignment = NSTextAlignmentCenter;
        _cpTitleLab.translatesAutoresizingMaskIntoConstraints = NO;
        _cpTitleLab.numberOfLines = 0;
    }
    return _cpTitleLab;
}

-(UILabel *)cpDescripLab{
    if (_cpDescripLab == nil) {
        _cpDescripLab = [[UILabel alloc] init];
        _cpDescripLab.textAlignment = NSTextAlignmentCenter;
        _cpDescripLab.translatesAutoresizingMaskIntoConstraints = NO;
        _cpDescripLab.numberOfLines = 0;
    }
    return _cpDescripLab;
}


+(NSString *)identifier{
    return @"CPBottomPromitCell";
}


@end
