//
//  AMTDetailsHeadView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/12.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTDetailsHeadView.h"
@interface AMTDetailsHeadView ()
@property (nonatomic, strong) BaseImageView *bgImageView;
@property (nonatomic, strong) BaseImageView *headIamgeView;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseLabel *announcementLab;
@property (nonatomic, strong) BaseButton *focusBtn;
@end
@implementation AMTDetailsHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.bgImageView = [[BaseImageView alloc]init];
    self.bgImageView.image = imageNamed(@"bgImage");
    
    
    self.headIamgeView = [[BaseImageView alloc]init];
    self.headIamgeView.sd_cornerRadius = @(40);
    
    self.nameLab = [[BaseLabel alloc]init];
    [self.nameLab setLableColor:@"FFFFFF" font:20 bold:1];
    
    self.announcementLab = [[BaseLabel alloc]init];
    [self.announcementLab setLableColor:@"FFFFFF" font:13 bold:0];
    
    
    self.focusBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    self.focusBtn.sd_cornerRadius = @(3);
    [self.focusBtn setLableColor:@"FFFFFF" font:13 bold:0];
    [self.focusBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
    [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
    weakSelf(self);
    [[self.focusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[KKNetWorking getShard] request:POST url:attention parameters:@{@"user_id_from_id":weakSelf.userInfoModel.ID,@"user_id_from_type":@(weakSelf.userInfoModel.type)} completion:^(id json, NSInteger code) {
            weakSelf.userInfoModel.is_attention = !weakSelf.userInfoModel.is_attention;
            weakSelf.focusBtn.selected = !weakSelf.focusBtn.selected;
            weakSelf.focusBtn.sd_layout
            .widthIs(weakSelf.focusBtn.selected ? 60 : 40);
            [weakSelf.focusBtn setBackgroundColor:[UIColor colorWithWhite:weakSelf.focusBtn.selected ? 1 : 0 alpha:0.3]];
        } fail:^(NSString *message, NSInteger code) {
            
        }];
    }];
    
    [self sd_addSubviews:@[self.bgImageView,self.headIamgeView,self.nameLab,self.focusBtn]];
    
    self.bgImageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
//    .leftEqualToView(self)
//    .rightEqualToView(self)
//    .topEqualToView(self)
//    .heightIs(325);
    
    self.headIamgeView.sd_layout
    .topSpaceToView(self, 85)
    .leftSpaceToView(self, 16)
    .widthIs(80)
    .heightEqualToWidth();
    
    self.nameLab.sd_layout
    .topSpaceToView(self.headIamgeView, 16)
    .leftSpaceToView(self, 17)
    .heightIs(20);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    self.announcementLab.sd_layout
    .topSpaceToView(self.nameLab, 20)
    .leftSpaceToView(self, 16)
    .rightSpaceToView(self, 19)
    .autoHeightRatio(0)
    .maxHeightIs(35);
    
    self.focusBtn.sd_layout
    .centerYEqualToView(self.headIamgeView)
    .rightSpaceToView(self, 16)
    .widthIs(40)
    .heightIs(40);
}

- (void)setUserInfoModel:(AMTUserInfoModel *)userInfoModel
{
    _userInfoModel = userInfoModel;
    [self.headIamgeView sd_setImageWithURL:UrlString(userInfoModel.head_img)];
    self.nameLab.text = userInfoModel.type == 1 ? userInfoModel.nickname : userInfoModel.name;
    self.announcementLab.text = userInfoModel.announcement;
    self.focusBtn.selected = userInfoModel.is_attention;
    self.focusBtn.sd_layout
    .widthIs(self.focusBtn.selected ? 60 : 40);
    [self.focusBtn setBackgroundColor:[UIColor colorWithWhite:self.focusBtn.selected ? 1 : 0 alpha:0.3]];
}
@end
