//
//  BaseTextField.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField
- (instancetype)init
{
    if (self = [super init]) {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
    if (self.positionHeight != 0) {
        originalRect.size.height = self.positionHeight;
    }
    return originalRect;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.kMaxNumber == 0) {
        return;
    }
    NSString *toBeString = textField.text;
    
//    NSLog(@" 打印信息toBeString:%@",toBeString);
    
    NSString *lang = [[textField textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
        //可以计算文字长度。否则此时计算出来的字符长度可能不正确
        
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分(感觉输入中文的时候才有)
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            //中文和字符一起检测  中文是两个字符
            if ([toBeString getStringLenthOfBytes] > self.kMaxNumber)
            {
                textField.text = [toBeString subBytesOfstringToIndex:self.kMaxNumber];
                self.limitBlock ? self.limitBlock() : nil;
            }
        }
    }
    else
    {
        if ([toBeString getStringLenthOfBytes] > self.kMaxNumber)
        {
            textField.text = [toBeString subBytesOfstringToIndex:self.kMaxNumber];
            self.limitBlock ? self.limitBlock() : nil;
        }
    }
}

-(NSInteger)limitText:(NSString *)string
                    number:(NSInteger)number{
    NSString *toBeString = self.text;
    NSString *lang = self.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"])
    { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position || !selectedRange)
        {
            if (toBeString.length > number)
            {
                [SVProgressHUD setMinimumDismissTimeInterval:1];
                [UIView showInfoHUD:string completeBlock:^{
                    [SVProgressHUD setMinimumDismissTimeInterval:10];
                }];
                self.text = [toBeString substringToIndex:number];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > number)
        {
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [UIView showInfoHUD:string completeBlock:^{
                [SVProgressHUD setMinimumDismissTimeInterval:10];
            }];
            self.text = [toBeString substringToIndex:number];
        }
    }
    return self.text.length;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
