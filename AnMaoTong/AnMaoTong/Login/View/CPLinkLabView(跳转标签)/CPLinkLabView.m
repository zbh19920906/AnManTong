//
//  CPLinkLabView.m
//  yuexia
//
//  Created by 陈平 on 2018/4/13.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "CPLinkLabView.h"

@interface CPLinkLabView ()<
UITextViewDelegate>
@property (nonatomic , strong) UITextView *textView;
@end

@implementation CPLinkLabView

#pragma mark - set
-(void)setTextInsets:(UIEdgeInsets)textInsets
{
    _textInsets = textInsets;
    self.textView.contentInset = _textInsets;
}

#pragma mark - Life
+ (instancetype)linkLabView
{
    return [[self alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 0)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self setupInitForCPLinkLabView];
        [self setupBingdingForCPLinkLabView];
    }
    return self;
}

#pragma mark - Pravite
-(void)setupInitForCPLinkLabView
{
    [self addSubview:self.textView];
    
    self.textView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(0);
    
    [self setupAutoHeightWithBottomView:self.textView bottomMargin:0];
}

-(void)setupBingdingForCPLinkLabView
{
    weakSelf(self);
    [[[RACObserve(self.textView, contentSize) distinctUntilChanged] take:20] subscribeNext:^(id  _Nullable x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.textView.sd_layout
            .heightIs(weakSelf.textView.contentSize.height + weakSelf.textInsets.top + weakSelf.textInsets.bottom);
            
            if (weakSelf.cpDeleagte &&
                [weakSelf.cpDeleagte respondsToSelector:@selector(updataLayoutForSuperView:)])
            {
                [weakSelf.textView updateLayout];
                [weakSelf.cpDeleagte updataLayoutForSuperView:weakSelf];
            }
        });
    }];
    
}

- (void)clickLink:(NSString *)url
{
    if (self.cpDeleagte && [self.cpDeleagte respondsToSelector:@selector(linkLabViewClickLink:linkUrl:)]) {
        [self.cpDeleagte linkLabViewClickLink:self linkUrl:url];
    }
}

#pragma mark - Public
-(void)addContent:(NSString *)content linkInContent:(NSString *)linkInContent toLink:(NSString *)toLink
{
    NSRange range = [content rangeOfString:linkInContent];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                          NSForegroundColorAttributeName : [UIColor cz_ToUIColorByStr:@"ADADAD"]
                          };
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:content attributes:dic];
    [att addAttribute:NSLinkAttributeName value:UrlString(toLink) range:range];
    self.textView.attributedText = att;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    [self clickLink:URL.absoluteString];
    return NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    [self clickLink:URL.absoluteString];
    return NO;
}

#pragma mark - get
-(UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectZero];
        _textView.delegate = self;
        _textView.editable = NO;
        _textView.alwaysBounceVertical = NO;
        _textView.alwaysBounceHorizontal = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.contentInset = self.textInsets;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        _textView.dataDetectorTypes = UIDataDetectorTypeAll;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
        if (@available(iOS 11.0, *))
        {
            _textView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
    }
    return _textView;
}



@end
