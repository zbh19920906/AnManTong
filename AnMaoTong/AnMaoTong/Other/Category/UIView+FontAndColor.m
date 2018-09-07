//
//  UIView+FontAndColor.m
//  CloudMoto
//
//  Created by lk05 on 2017/10/23.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "UIView+FontAndColor.h"

@implementation UIView (FontAndColor)
- (void)setLableColor:(NSString *)color
                 font:(NSInteger)font
                bold:(CGFloat)bold
{
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton * button  = (UIButton *)self;
        [button setTitleColor:[UIColor cz_ToUIColorByStr:color] forState:UIControlStateNormal];
        if (bold) {
            button.titleLabel.font = [UIFont boldSystemFontOfSize:font];
        }else{
            button.titleLabel.font = [UIFont systemFontOfSize:font];
        }
    }else if([self isKindOfClass:[UILabel class]]){
        UILabel * label = (UILabel *)self;
        label.textColor = [UIColor cz_ToUIColorByStr:color];
        if (bold) {
            label.font = [UIFont boldSystemFontOfSize:font];
        }else{
            label.font = [UIFont systemFontOfSize:font];
        }
        
    }else if ([self isKindOfClass:[UITextField class]]){
        UITextField * textView = (UITextField *)self;
        textView.textColor = [UIColor cz_ToUIColorByStr:color];
        if (bold) {
            textView.font = [UIFont boldSystemFontOfSize:font];
        }else{
            textView.font = [UIFont systemFontOfSize:font];
        }
    }else if ([self isKindOfClass:[UITextView class]]){
        UITextView * textView = (UITextView *)self;
        textView.textColor = [UIColor cz_ToUIColorByStr:color];
        if (bold) {
            textView.font = [UIFont boldSystemFontOfSize:font];
        }else{
            textView.font = [UIFont systemFontOfSize:font];
        }
    }
}

-(CGSize)sizeWithFont:(UIFont *)font AndText:(NSString *)text AndMaxSize:(CGSize)maxSize{
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size;
    return size;
}
@end
