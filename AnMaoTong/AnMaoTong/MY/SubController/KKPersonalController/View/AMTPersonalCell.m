
//
//  AMTPersonalCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTPersonalCell.h"
@interface AMTPersonalCell ()

@end
@implementation AMTPersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    [self.textLabel setLableColor:@"666666" font:14 bold:0];
    
    [self.contentView sd_addSubviews:@[self.headImage,self.rightTF,self.rightBtn]];
    
    self.headImage.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 16)
    .widthIs(75)
    .heightEqualToWidth();
    
    self.rightTF.sd_layout
    .centerYEqualToView(self.contentView)
    .rightEqualToView(self.headImage)
    .widthIs(200)
    .heightIs(20);
    
    self.rightBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightEqualToView(self.headImage)
    .widthIs(200)
    .heightIs(20);
}

- (void)setTitle:(NSString *)title
{
    self.headImage.hidden = YES;
    self.rightTF.hidden = YES;
    self.rightBtn.hidden = YES;
    User *user = [UserHelper shareInstance].user;
    if ([title isEqualToString:@"更换头像"]) {
        [self.headImage sd_setImageWithURL:UrlString(user.head_img)];
        self.headImage.hidden = NO;
    }else if ([title isEqualToString:@"性别"]){
        [self.rightBtn setTitle:user.sex == 1 ? @"男" : @"女" forState:UIControlStateNormal];
        self.rightBtn.hidden = NO;
    }else if ([title isEqualToString:@"出生年月"]){
        [self.rightBtn setTitle:user.date_birth forState:UIControlStateNormal];
        self.rightBtn.hidden = NO;
    }else{
        if ([title isEqualToString:@"昵称"]) {
            self.rightTF.text = self.isUser ? user.nickname : user.name;
        }else if ([title isEqualToString:@"微信号"]){
            self.rightTF.text = user.wx;
        }else if ([title isEqualToString:@"QQ号"]){
            self.rightTF.text = user.qq;
        }
        self.rightTF.hidden = NO;
    }
    self.textLabel.text = title;
}

- (BaseImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[BaseImageView alloc]init];
        _headImage.backgroundColor = [UIColor redColor];
        _headImage.hidden = YES;
        _headImage.sd_cornerRadius = @(37.5);
    }
    return _headImage;
}

- (BaseTextField *)rightTF
{
    if (!_rightTF) {
        _rightTF = [[BaseTextField alloc]init];
        _rightTF.hidden = YES;
        [_rightTF setLableColor:@"222222" font:14 bold:0];
        _rightTF.textAlignment = NSTextAlignmentRight;
        _rightTF.contentVerticalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _rightTF;
}

- (BaseButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.hidden = YES;
        [_rightBtn setTitle:@"按钮" forState:UIControlStateNormal];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightBtn setLableColor:@"222222" font:14 bold:0];
        _rightBtn.userInteractionEnabled = NO;
    }
    return _rightBtn;
}
@end
