//
//  PersonalRadioView.h
//  yuexia
//
//  Created by 陈平 on 2018/1/14.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalRadioViewDelegate;

@interface PersonalRadioView : UIView

@property (nonatomic , assign) id<PersonalRadioViewDelegate> cpDelegate;

@property (nonatomic , strong) NSArray<NSString *> *dataSource;

+(instancetype)radioViewWithTitle:(NSString *)title;

@end

@protocol PersonalRadioViewDelegate <NSObject>

@optional
- (void)radioViewClickCancel;

@required
- (void)radioViewClick:(NSString *)valueStr;



@end
