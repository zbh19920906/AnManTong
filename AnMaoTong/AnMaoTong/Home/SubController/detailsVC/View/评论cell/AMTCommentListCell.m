//
//  AMTCommentListCell.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/17.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTCommentListCell.h"
@interface AMTCommentListCell ()
@property (nonatomic, strong) BaseImageView *headImage;
@property (nonatomic, strong) BaseLabel *nameLab;
@property (nonatomic, strong) BaseLabel *contentLab;
@property (nonatomic, strong) BaseButton *likeBtn;
@property (nonatomic, strong) BaseLabel *timeLab;
@end
@implementation AMTCommentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.headImage = [[BaseImageView alloc]init];
    
    self.nameLab = [[BaseLabel alloc]init];
    [self.nameLab setLableColor:@"222222" font:15 bold:1];
    
    self.contentLab = [[BaseLabel alloc]init];
    self.contentLab.isAttributedContent = YES;
    
    self.timeLab = [[BaseLabel alloc]init];
    [self.timeLab setLableColor:@"CCCCCC" font:11 bold:0];
    
    self.likeBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setImage:imageNamed(@"like") forState:UIControlStateNormal];
    [self.likeBtn setImage:imageNamed(@"like_pre") forState:UIControlStateSelected];
    [self.likeBtn setLableColor:@"B9B9B9" font:12 bold:0];
    weakSelf(self);
    [[self.likeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [[KKNetWorking getShard] request:POST url:commentLike parameters:@{@"comment_id":weakSelf.model.ID} completion:^(id json, NSInteger code) {
            if (weakSelf.model.is_comment_like_count) {
                weakSelf.model.comment_like_count = weakSelf.model.comment_like_count - 1;
            }else{
                weakSelf.model.comment_like_count = weakSelf.model.comment_like_count + 1;
            }
            weakSelf.model.is_comment_like_count = !weakSelf.model.is_comment_like_count;
            weakSelf.likeBtn.selected = weakSelf.model.is_comment_like_count;
            [weakSelf.likeBtn setTitle:BHIString(weakSelf.model.comment_like_count) forState:UIControlStateNormal];
        } fail:^(NSString *message, NSInteger code) {
            
        }];
    }];
    
    [self.contentView sd_addSubviews:@[self.headImage,self.nameLab,self.contentLab,self.timeLab,self.likeBtn]];
    
    self.headImage.sd_layout
    .topSpaceToView(self.contentView, 12)
    .leftSpaceToView(self.contentView, 11)
    .widthIs(32)
    .heightEqualToWidth();
    
    self.nameLab.sd_layout
    .leftSpaceToView(self.headImage, 12)
    .topEqualToView(self.headImage)
    .heightIs(15);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:250];
    
    self.contentLab.sd_layout
    .topSpaceToView(self.nameLab, 11)
    .leftEqualToView(self.nameLab)
    .rightSpaceToView(self.contentView, 60)
    .autoHeightRatio(0)
    .maxHeightIs(36);
    
    self.likeBtn.sd_layout
    .centerYEqualToView(self.nameLab)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(15)
    .widthIs(50);
    
    self.timeLab.sd_layout
    .topSpaceToView(self.contentLab, 10)
    .leftEqualToView(self.nameLab)
    .heightIs(11);
    [self.timeLab setSingleLineAutoResizeWithMaxWidth:150];
}

- (void)setModel:(AMTCommentModel *)model
{
    _model = model;
    [self.likeBtn setTitle:BHIString(model.comment_like_count) forState:UIControlStateNormal];
    self.likeBtn.selected = model.is_comment_like_count;
    self.timeLab.text = model.generate_time;
    self.nameLab.text = model.reply_user_id.length == 0 ? model.nickname : model.parent_nickname;
    self.contentLab.attributedText = [self setAtt];
    [self.headImage sd_setImageWithURL:UrlString(model.head_img)];
    [self setupAutoHeightWithBottomView:self.timeLab bottomMargin:15];
}

- (NSMutableAttributedString *)setAtt
{
    NSString *str = _model.reply_user_id.length == 0 ? _model.content : [NSString stringWithFormat:@"回复%@：%@",_model.nickname,_model.content];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttributes:@{NSFontAttributeName : BHFont(13) , NSForegroundColorAttributeName : BHColor(@"959595")} range:[str rangeOfString:str]];
    if (_model.reply_user_id.length > 0) {
        [attr addAttributes:@{NSFontAttributeName : BHFont(13) , NSForegroundColorAttributeName : BHColor(@"007AFF")} range:[str rangeOfString:_model.nickname]];
    }
    
    return attr;
}
@end
