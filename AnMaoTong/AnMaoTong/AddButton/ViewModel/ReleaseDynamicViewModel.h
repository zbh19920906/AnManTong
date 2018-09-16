//
//  ReleaseDynamicViewModel.h
//  yuexia
//
//  Created by 陈平 on 2018/7/31.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "BaseObject.h"

#import "ReleaseDynamicDataModel.h"
//#import "ReleaseDynamicBottomView.h"
@class AMTAddButtonVC;
@interface ReleaseDynamicViewModel : NSObject

@property (nonatomic , strong) ReleaseDynamicDataModel *dataModel;

@property (nonatomic , assign) AMTAddButtonVC *viewController;

@property (nonatomic , strong) BaseTextView *textView;

@property (nonatomic , strong) CPBaseImageCollectionView *imagesCollectionView;
//@property (nonatomic , strong) ReleaseDynamicBottomView *bottomView;

@property (nonatomic , strong) UIButton *locationBtn;

- (void)setupInitLayout;

- (void)updataLocation:(NSString *)location;

@end
