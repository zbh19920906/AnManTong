//
//  UIView+extension.m
//  MeetCarefree
//
//  Created by 陈平 on 2017/11/10.
//  Copyright © 2017年 xxf. All rights reserved.
//

#import "UIView+extension.h"

@implementation UIView (extension)


+(void)showTextHUD:(NSString *)text completeBlock:(void (^)(void))complete
{
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showImage:nil status:text];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (complete) complete();
    });
}

+(void)showStatusHUD:(NSString *)statusStr completeBlock:(void (^)(void))complete
{
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showWithStatus:statusStr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (complete) complete();
    });
}

+(void)showHUDWithCompleteBlock:(void (^)(void))complete
{
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (complete) complete();
    });
}

+(void)showSuccessHUD:(NSString *)successStr completeBlock:(void (^)(void))complete
{
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showSuccessWithStatus:successStr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (complete) complete();
    });
}

+(void)showInfoHUD:(NSString *)InfoStr completeBlock:(void (^)(void))complete
{
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showInfoWithStatus:InfoStr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (complete) complete();
    });
}

+(void)showErrorHUD:(NSString *)errorStr completeBlock:(void (^)(void))complete
{
    [SVProgressHUD setMinimumSize:CGSizeZero];
    [SVProgressHUD showErrorWithStatus:errorStr];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (complete) complete();
    });
}

- (void)cp_shouldRasterize
{
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


- (void)takePhotoForViewController
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        imagePicker.allowsEditing = YES;
        [[UIView getViewController] presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        [UIView showMakeSureAletView:@"" message:@"该设备不支持拍照" btnTitle:@"确定" btnTitleBlock:^{}];
    }
}

- (void)takeAlbumForViewControllerWithEditing:(BOOL)isEditing
                             ischooseMulImage:(BOOL)isChooseMul
                                     maxCount:(NSInteger)count
{
    if (!isChooseMul)
    {
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate = self;
        pick.allowsEditing = isEditing;
        [pick.navigationBar setTintColor:[UIColor blackColor]];
        [[UIView getViewController] presentViewController:pick animated:YES completion:nil];
    }
    else
    {
        TZImagePickerController *imageVC = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
        [imageVC.navigationBar addShadow];
        imageVC.allowPickingGif = NO;
        imageVC.allowPickingVideo = NO;
        imageVC.isStatusBarDefault = YES;
        imageVC.naviTitleColor = [UIColor blackColor];
        imageVC.naviBgColor = [UIColor whiteColor];
        imageVC.barItemTextColor = [UIColor blackColor];
        [[UIView getViewController] presentViewController:imageVC animated:YES completion:nil];
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
}

#pragma mark - 去除tableView刷新cell弹跳
+ (void)estimatedForTableView:(__kindof UITableView *)tableView
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    if (@available(ios 11.0, *))
    {
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
#endif
}

#pragma mark - 去除滚动视图安全区
+ (void)contentInsetAdjustmentBehaviorFor:(__kindof UIScrollView *)scrollView
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    if (@available(iOS 11.0, *))
    {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
}

- (UIView *)addBottomLineWithOffset:(CGFloat)offset left:(CGFloat)left right:(CGFloat)right color:(UIColor *)color height:(CGFloat)height{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    if ([self isKindOfClass:[UIVisualEffectView class]])
    {
        UIVisualEffectView *view = (UIVisualEffectView *)self;
        [view.contentView addSubview:line];
    }else{
        [self addSubview:line];
    }
    
    line.sd_layout.rightEqualToView(self).offset(-right).leftEqualToView(self).offset(left).heightIs(height).bottomSpaceToView(self, offset);
    return line;
}
@end

