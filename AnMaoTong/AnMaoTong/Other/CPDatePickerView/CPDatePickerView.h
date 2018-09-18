//
//  CPDatePickerView.h
//  yuexia
//
//  Created by 陈平 on 2018/1/14.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPDatePickerViewDelegate;

@interface CPDatePickerView : UIView

@property (nonatomic , assign) id<CPDatePickerViewDelegate> cpDelegate;

+(instancetype)datePickerViewWithTitle:(NSString *)title;

- (void)showTime:(NSString *)time;
@end

@protocol CPDatePickerViewDelegate <NSObject>

@required
- (void)pickerViewForClick:(NSString *)timeStr;

- (void)pickerViewForClickCancel;
@end
