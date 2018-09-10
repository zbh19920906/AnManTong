//
//  BaseViewController.h
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavgationBar.h"

@interface BaseViewController : UIViewController <
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TZImagePickerControllerDelegate>

@property (nonatomic , strong)BaseNavgationBar * navBar;

//是否登录
- (BOOL)isUserLogin;

//返回按钮
- (void)clickBackButtonAcion:(id)sender;
//右侧按钮
- (void)clickRightButtonAction:(id)sender;
- (void)removeLeftButtonTarget;
#pragma mark - 跳转到他人主页
- (void)gotoWeiboPersonVC:(NSString *)userID;
/**
 拍照，编辑
 */
- (void)takePhotoForViewController;

/**
 拍照，不编辑
 */
- (void)takePhotoForViewControllerForNoEdit;

/**
 相册选择照片
 */
- (void)takeAlbumForViewControllerWithEditing:(BOOL)isEditing
                             ischooseMulImage:(BOOL)isChooseMul
                                     maxCount:(NSInteger)count;
@end
