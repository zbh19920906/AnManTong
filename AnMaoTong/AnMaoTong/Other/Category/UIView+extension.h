//
//  UIView+extension.h
//  MeetCarefree
//
//  Created by 陈平 on 2017/11/10.
//  Copyright © 2017年 xxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TZImagePickerController/TZImagePickerController.h>


@interface UIView (extension)<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TZImagePickerControllerDelegate>

/**
 显示提示框（只有确定按钮）
 */
+ (void)showMakeSureAletView:(NSString *)title
                     message:(NSString *)message
                    btnTitle:(NSString *)btnTitle
               btnTitleBlock:(void (^)(void))btnTitleBlock;

/**
 显示提示框 (自己添加按钮，接收回调方法)
 */
+ (void)showAletView:(NSString *)title
             message:(NSString *)message
               title:(NSString *)titleStr
          titleBlock:(void (^)(void))titleBlock
            subTitle:(NSString *)subTitle
       subTitleBlock:(void (^)(void))subTitleBlock;

/**
 显示提示框（只有确定按钮，添加文字颜色）
 */
+ (void)showMakeSureAletView:(NSString *)title
                     message:(NSString *)message
                    btnTitle:(NSString *)btnTitle
                  titleColor:(UIColor *)titleColor
               btnTitleBlock:(void (^)(void))btnTitleBlock;

/**
 显示提示框 (自己添加按钮，接收回调方法，添加文字颜色)
 */
+ (void)showAletView:(NSString *)title
             message:(NSString *)message
               title:(NSString *)titleStr
          titleColor:(UIColor *)titleColor
          titleBlock:(void (^)(void))titleBlock
            subTitle:(NSString *)subTitle
       subTitleColor:(UIColor *)subTitleColor
       subTitleBlock:(void (^)(void))subTitleBlock;


+ (void)showAletView:(NSString *)title
             message:(NSString *)message
        messageColor:(UIColor *)messageColor
               title:(NSString *)titleStr
          titleColor:(UIColor *)titleColor
          titleBlock:(void (^)(void))titleBlock
            subTitle:(NSString *)subTitle
       subTitleColor:(UIColor *)subTitleColor
       subTitleBlock:(void (^)(void))subTitleBlock;

/**
 自定义显示提示框（只有确定按钮）
 */
+ (void)showMakeSureAletView:(NSString *)title
                   titleFont:(CGFloat)titilFont
                  titleColor:(UIColor *)titleColor
                     message:(NSString *)message
                 messageFont:(CGFloat)messageFont
                messageColor:(UIColor *)messageColor
                    btnTitle:(NSString *)btnTitle
               btnTitleColor:(UIColor *)btnTitleColor
               btnTitleBlock:(void (^)(void))btnTitleBlock;

/**
 添加阴影
 */
- (void)addShadow;
- (void)addShadowWithOffset:(CGSize)offset;
- (void)addShadowWithOffset:(CGSize)offset color:(UIColor *)color radius:(CGFloat)radius opacity:(CGFloat)opacity;


/**
 获取当前控制器
 */
+ (UIViewController*)getViewController;

/**
 获取当前顶层控制器
 */
+ (UIViewController*)getTopViewController;

+(void)showTextHUD:(NSString *)text completeBlock:(void (^)(void))complete;

+(void)showStatusHUD:(NSString *)statusStr completeBlock:(void (^)(void))completer;

+(void)showHUDWithCompleteBlock:(void (^)(void))complete;

+(void)showSuccessHUD:(NSString *)successStr completeBlock:(void (^)(void))complete;

+(void)showInfoHUD:(NSString *)InfoStr completeBlock:(void (^)(void))complete;

+(void)showErrorHUD:(NSString *)errorStr completeBlock:(void (^)(void))complete;

- (void)cp_shouldRasterize;


/**
 拍照
 */
- (void)takePhotoForViewController;

/**
 相册选取照片
 */
- (void)takeAlbumForViewControllerWithEditing:(BOOL)isEditing
                             ischooseMulImage:(BOOL)isChooseMul
                                     maxCount:(NSInteger)count;

#pragma mark - 去除tableView刷新cell弹跳
+ (void)estimatedForTableView:(__kindof UITableView *)tableView;

#pragma mark - 去除滚动视图安全区
+ (void)contentInsetAdjustmentBehaviorFor:(__kindof UIScrollView *)scrollView;
- (UIView *)addBottomLineWithOffset:(CGFloat)offset left:(CGFloat)left right:(CGFloat)right color:(UIColor *)color height:(CGFloat)height;
@end
