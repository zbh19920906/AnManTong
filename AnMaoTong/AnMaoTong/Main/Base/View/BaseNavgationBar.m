//
//  BaseNavgationBar.m
//  YunDouYou
//
//  Created by lk06 on 2018/7/3.
//  Copyright © 2018年 lk06. All rights reserved.
//  此类是自定义，导航条

#import "BaseNavgationBar.h"

@implementation BaseNavgationBar

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setingNavgationSubViews];
    }
    return self;
}

-(void)setingNavgationSubViews
{
    //标题
    [self addSubview:self.titieLab];
     self.titieLab.sd_layout
    .centerXEqualToView(self)
    .bottomSpaceToView(self, 12)
    .heightIs(18);
    [self.titieLab setSingleLineAutoResizeWithMaxWidth:200];
    
    //返回按钮
    [self addSubview:self.backButton];
    self.backButton.sd_layout
    .leftSpaceToView(self, 15)
    .bottomSpaceToView(self, 10)
    .widthIs(30)
    .heightIs(30);
    
    //右侧按钮
    [self addSubview:self.rightButton];
    self.rightButton.sd_layout
    .rightSpaceToView(self, 15)
    .bottomSpaceToView(self, 10)
    .widthIs(80)
    .heightIs(30);
    
    [self addSubview:self.lineView];
    self.lineView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self)
    .heightIs(0.5);
    
}

-(void)clearNav
{
   [self setBackgroundColor:[UIColor clearColor]];
    self.lineView.backgroundColor = [UIColor clearColor];
    self.titieLab.hidden = YES;
   
}
/**
 创建标题

 @return UILabel
 */
-(UILabel*)titieLab
{
    if (_titieLab==nil) {
        _titieLab = [[UILabel alloc] init];
        [_titieLab setLableColor:@"333333" font:18 bold:1];
        _titieLab.text = @"";
        [_titieLab setSingleLineAutoResizeWithMaxWidth:200];
    }
    return _titieLab;
}

/**
 返回按钮

 @return BaseButton
 */
-(BaseButton*)backButton
{
    if (_backButton==nil) {
        _backButton = [[BaseButton alloc]init];
        [_backButton setImage:imageNamed(@"fanhui") forState:UIControlStateNormal];
        _backButton.hidden = NO;
    }
    return _backButton;
}

-(BaseView*)lineView
{
    if (_lineView==nil) {
        _lineView = [[BaseView alloc]init];
        _lineView.backgroundColor = [UIColor cz_ToUIColorByStr:@"e5e5e5"];
    }
    return _lineView;
}

- (BaseButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [BaseButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setLableColor:@"333333" font:15 bold:0];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightButton setAdjustsImageWhenHighlighted:NO];
    }
    return _rightButton;
}

@end
