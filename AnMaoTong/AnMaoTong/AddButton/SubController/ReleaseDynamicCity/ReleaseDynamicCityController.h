//
//  ReleaseDynamicCityController.h
//  yuexia
//
//  Created by 陈平 on 2018/8/2.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "BaseViewController.h"

@protocol ReleaseDynamicCityControllerDelegate;

@interface ReleaseDynamicCityController : BaseViewController

@property (nonatomic , assign) id<ReleaseDynamicCityControllerDelegate> cpDelegate;

/**
 当前选择的位置
 */
@property (nonatomic , strong) id currentPOI;

@end

@protocol ReleaseDynamicCityControllerDelegate <NSObject>

@optional
- (void)releaseDynamicCityController:(ReleaseDynamicCityController *)viewController POI:(id)poi;

@end

