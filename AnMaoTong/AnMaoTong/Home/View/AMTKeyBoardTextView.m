
//
//  AMTKeyBoardTextView.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/17.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTKeyBoardTextView.h"

@interface AMTKeyBoardTextView ()<RCEmojiViewDelegate>
@property (nonatomic, strong) BaseView *bgView;
@property (nonatomic, strong) BaseButton *emojiBtn;
@property (nonatomic, strong) BaseButton *determineBtn;
@property (nonatomic , strong) RCEmojiBoardView *emojiBoardView;
@end
@implementation AMTKeyBoardTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubView];
    }
    return self;
}

- (void)setSubView
{
    self.bgView = [[BaseView alloc]init];
    self.bgView.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    [self addSubview:self.bgView];
   self. bgView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(HEIGHT_SCREEN - 280);
    
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    [self.bgView addGestureRecognizer:tap];
    
    weakSelf(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [weakSelf.inputTF resignFirstResponder];
        [weakSelf hidden];
    }];
    
    self.inputView = [[BaseView alloc]initWithFrame:CGRectMake(0, HEIGHT_SCREEN, WIDTH_SCREEN, 280)];
    self.inputView.backgroundColor = BHColor(@"F5F5F5");
    [self addSubview:self.inputView];
    
    self.emojiBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [self.emojiBtn setImage:imageNamed(@"表情") forState:UIControlStateNormal];
    [[self.emojiBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (weakSelf.emojiBtn.selected) {
            //显示键盘
            [weakSelf.inputTF becomeFirstResponder];
        }else{
            //隐藏键盘
            [weakSelf.inputTF resignFirstResponder];
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.inputView.frame = CGRectMake(0, HEIGHT_SCREEN - 280, WIDTH_SCREEN, 280);
            }];
        }
        
        weakSelf.emojiBtn.selected = !weakSelf.emojiBtn.selected;
    }];
    
    self.determineBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    self.determineBtn.sd_cornerRadius = @(18);
    [self.determineBtn setBackgroundColor: BHColor(@"008AFF")];
    [self.determineBtn setLableColor:@"FFFFFF" font:15 bold:0];
    [self.determineBtn setTitle:@"确定" forState:UIControlStateNormal];
    [[self.determineBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [myNoti postNotificationName:sendCommentNoti object:nil];
    }];
    
    self.inputTF = [[BaseTextField alloc]init];
    self.inputTF.placeholder = @"请输入评论";
    self.inputTF.sd_cornerRadius = @(23);
    self.inputTF.backgroundColor = [UIColor whiteColor];
    self.inputTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 45)];
    self.inputTF.leftViewMode = UITextFieldViewModeAlways;
    
    [self.inputView sd_addSubviews:@[self.inputTF,self.determineBtn,self.emojiBtn,self.emojiBoardView]];
    
    self.inputTF.sd_layout
    .topSpaceToView(self.inputView, 7.5)
    .leftSpaceToView(self.inputView, 15)
    .heightIs(45)
    .rightSpaceToView(self.inputView, 15);
    
    self.determineBtn.sd_layout
    .centerYEqualToView(self.inputTF)
    .rightSpaceToView(self.inputView, 21)
    .widthIs(54)
    .heightIs(35);
    
    self.emojiBtn.sd_layout
    .centerYEqualToView(self.inputTF)
    .rightSpaceToView(self.determineBtn, 10)
    .widthIs(24)
    .heightEqualToWidth();
    
    self.emojiBoardView.sd_layout
    .topSpaceToView(self.inputTF, 7.5)
    .leftEqualToView(self.inputView)
    .rightEqualToView(self.inputView)
    .heightIs(220);
}

- (void)show:(CGFloat)height
{
    self.hidden = NO;
    self.emojiBtn.selected = NO;
    self.inputTF.text = @"";
    [UIView animateWithDuration:0.25 animations:^{
        self.inputView.frame = CGRectMake(0, HEIGHT_SCREEN - height - 60, WIDTH_SCREEN, 280);
    }];
}

- (void)hidden
{
    self.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.inputView.frame = CGRectMake(0, HEIGHT_SCREEN, WIDTH_SCREEN, 280);
    }];
}

#pragma mark - RCEmojiViewDelegate
- (void)didTouchEmojiView:(RCEmojiBoardView *)emojiView touchedEmoji:(NSString *)string
{
    if (string){
        [self.inputTF insertText:string];
    }else{
        [self.inputTF deleteBackward];
    }
}

- (RCEmojiBoardView *)emojiBoardView
{
    if (_emojiBoardView == nil) {
        _emojiBoardView = [[RCEmojiBoardView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 220) delegate:self];
        _emojiBoardView.backgroundColor = [UIColor whiteColor];
    }
    return _emojiBoardView;
}

@end
