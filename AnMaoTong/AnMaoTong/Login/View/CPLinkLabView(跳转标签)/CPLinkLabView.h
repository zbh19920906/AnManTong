//
//  CPLinkLabView.h
//  yuexia
//
//  Created by 陈平 on 2018/4/13.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPLinkLabViewDelegate;

@interface CPLinkLabView : UIView

@property (nonatomic , assign) id<CPLinkLabViewDelegate> cpDeleagte;

@property (nonatomic , assign) UIEdgeInsets textInsets;

+ (instancetype)linkLabView;

- (void)addContent:(NSString *)content linkInContent:(NSString *)linkInContent toLink:(NSString *)toLink;


@end

@protocol CPLinkLabViewDelegate <NSObject>

@required

@optional
- (void)updataLayoutForSuperView:(CPLinkLabView *)linkView;

- (void)linkLabViewClickLink:(CPLinkLabView *)linkLabView linkUrl:(NSString *)linkUrl;

@end
