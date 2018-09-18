//
//  CPBottomPromitHeadView.m
//  BottomPromitView
//
//  Created by lk06 on 17/2/15.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "CPBottomPromitHeadView.h"

@interface CPBottomPromitHeadView ()
@property (nonatomic , strong) UILabel *titleLab;
@end

@implementation CPBottomPromitHeadView

+(__kindof CPBottomPromitHeadView *)bottomPromitHeadViewWithOption:(CPBottomPromitOption *)option{
    return [[CPBottomPromitHeadView alloc]initWithFrame:CGRectMake(0, 0, CPBP_ScreenSize.width, 50) option:option];
}

- (instancetype)initWithFrame:(CGRect)frame option:(CPBottomPromitOption *)option
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLab.font = option.fontForHead;
        [self addSubview:self.titleLab];
        [self setupLayout:option];
        
    }
    return self;
}

-(void)addHeadViewTitle:(NSString *)title option:(CPBottomPromitOption *)option complete:(void(^)())complete;{
    
    self.titleLab.text = title;
    self.titleLab.textColor = option.colorForHead;
    self.titleLab.font = option.fontForHead;
    
    CGRect rect_self = self.frame;
    CGFloat height = [self cpChangeTitleLabFrame:title option:option];
    rect_self.size.height = height + option.spacingForHead_Bottom + option.spacingForHead_Top;
    
    self.frame = rect_self;
    
    if (complete) {
        complete();
    }
}

-(CGFloat)cpChangeTitleLabFrame:(NSString *)title option:(CPBottomPromitOption *)option{
    CGFloat width = CPBP_ScreenSize.width - option.spacingForHead_Right - option.spacingForHead_Left;
    return [title boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:option.fontForHead} context:nil].size.height;
}


-(void)setupLayout:(CPBottomPromitOption *)option{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:option.spacingForHead_Top]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:option.spacingForHead_Left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-option.spacingForHead_Right]]; 
    
}


#pragma mark - get
-(UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}



@end
