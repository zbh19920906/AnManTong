//
//  AMTAddTitleController.m
//  AnMaoTong
//
//  Created by Jingjing Wu on 2018/9/15.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTAddTitleController.h"
#import "AMTKeyBoardInputView.h"
#import "AMTTitleView.h"
@interface AMTAddTitleController ()
@property (nonatomic, strong) BaseLabel *placeholderLab;
@property (nonatomic, strong) BaseLabel *countLab;
@property (nonatomic, strong) AMTKeyBoardInputView *keyBoardInput;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation AMTAddTitleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
    [self.navBar.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.navBar.rightButton setLableColor:@"222222" font:14 bold:0];
    [self.navBar.rightButton setTitleColor:BHColor(@"0185FE") forState:UIControlStateSelected];
    self.navBar.rightButton.userInteractionEnabled = NO;
    [self setBindding];
}

- (void)clickRightButtonAction:(id)sender
{
    NSString *str = [[NSString alloc]init];
    for (NSInteger i = 0 ; i < self.titleArr.count ; i++) {
        NSString *title = self.titleArr[i];
        if (i == 0) {
            str = title;
        }else{
            str = [str stringByAppendingFormat:@"|%@",title];
        }
    }
    self.saveBlock ? self.saveBlock(str) : nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBindding
{
    weakSelf(self);
    [[weakSelf.keyBoardInput.determineBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        weakSelf.placeholderLab.hidden = YES;
        [weakSelf.titleArr addObject:weakSelf.keyBoardInput.inputTF.text];
        [weakSelf.keyBoardInput.inputTF resignFirstResponder];
        [weakSelf changeButton];
    }];
    [[myNoti rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil]subscribeNext:^(id x) {
        NSNotification *notif = x;
        NSValue *value = [notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        weakSelf.keyBoardInput.inputTF.text = @"";
        [weakSelf.keyBoardInput show:[value CGRectValue].size.height];
    }];
    
    [[myNoti rac_addObserverForName:UIKeyboardWillHideNotification object:nil]subscribeNext:^(id x) {
        [weakSelf.keyBoardInput hidden];
    }];
}

- (void)setSubView
{
    self.keyBoardInput = [[AMTKeyBoardInputView alloc]init];
    self.titleArr = [[NSMutableArray alloc]init];
     self.buttonArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = BHColor(@"F4F3F2");
    BaseView *bgView = [[BaseView alloc]init];
    bgView.backgroundColor = [UIColor cz_ToUIColorByStr:@"ffffff"];
    [self.view addSubview:bgView];
    bgView.sd_layout
    .topSpaceToView(self.navBar, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(170);
    
    BaseLabel *titleLab = [[BaseLabel alloc]init];
    titleLab.text = @"标签";
    [titleLab setLableColor:@"222222" font:19 bold:0];
    
    BaseButton *addBtn = [BaseButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"+ 自定义" forState:UIControlStateNormal];
    [addBtn setLableColor:@"FF3658" font:13 bold:0];
    addBtn.layer.borderColor = BHColor(@"FF3658").CGColor;
    addBtn.layer.borderWidth = 1;
    addBtn.sd_cornerRadius = @(3);
    weakSelf(self);
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (weakSelf.titleArr.count >= 3) {
            [SVProgressHUD showErrorWithStatus:@"标签个数达到上限"];
            return ;
        }
        [weakSelf.keyBoardInput.inputTF becomeFirstResponder];
    }];
    
    self.placeholderLab = [[BaseLabel alloc]init];
    [self.placeholderLab setLableColor:@"B8B8B8" font:13 bold:0];
    self.placeholderLab.text = @"尚未添加";
    
    self.countLab = [[BaseLabel alloc]init];
    [self.countLab setLableColor:@"B8B8B8" font:10 bold:0];
    self.countLab.text = @"0/3";
    self.countLab.textAlignment = NSTextAlignmentRight;
    
    
    
    
    [bgView sd_addSubviews:@[titleLab,addBtn,self.placeholderLab, self.countLab]];
    
    titleLab.sd_layout
    .topSpaceToView(bgView, 46)
    .leftSpaceToView(bgView, 26)
    .heightIs(18)
    .widthIs(50);
    
    addBtn.sd_layout
    .topSpaceToView(bgView, 40)
    .rightSpaceToView(bgView, 28)
    .widthIs(68)
    .heightIs(30);
    
    self.placeholderLab.sd_layout
    .topSpaceToView(titleLab, 29)
    .leftSpaceToView(bgView, 27)
    .heightIs(13)
    .widthIs(55);
    
    self.countLab.sd_layout
    .bottomSpaceToView(bgView, 16)
    .rightSpaceToView(bgView, 11)
    .widthIs(20)
    .heightIs(10);
    
    for (NSInteger i = 0; i < 3; i ++) {
        AMTTitleView *titleView = [[AMTTitleView alloc]init];
        titleView.hidden = YES;
        titleView.tag = i;
        [bgView addSubview:titleView];
    
        [[titleView.button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [weakSelf.titleArr removeObjectAtIndex:titleView.tag];
            [weakSelf changeButton];
        }];
        
        titleView.sd_layout
        .leftSpaceToView(bgView, 25 + 110 * i)
        .topSpaceToView(titleLab, 30)
        .widthIs(100)
        .heightIs(40);
        
        [self.buttonArray addObject:titleView];
    }
    
}

- (void)changeButton
{
    self.navBar.rightButton.selected = self.titleArr.count;
    self.navBar.rightButton.userInteractionEnabled = self.titleArr.count;
    for (NSInteger i = self.titleArr.count; i < self.buttonArray.count; i ++) {
        AMTTitleView *titleView = self.buttonArray[i];
        titleView.hidden = YES;
    }
    
    for (NSInteger i = 0; i < self.titleArr.count; i ++) {
        AMTTitleView *titleView = self.buttonArray[i];
        titleView.hidden = NO;
        titleView.titleLab.text = self.titleArr[i];
    }
}
@end
