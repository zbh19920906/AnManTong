//
//  BaseViewController.m
//  CloudHome
//
//  Created by lk05 on 2017/9/13.
//  Copyright © 2017年 zhu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cz_ToUIColorByStr:@"ffffff"];
    
    if (@available(iOS 11.0, *)) {
    } else {
        //解决tableview往下偏移问题
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    if (self.navigationController) {
        [self setCustomNavigationBar];
    }
    self.page = 1;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.view bringSubviewToFront:self.navBar];
    }
}

- (void)setCustomNavigationBar
{
    self.navigationController.navigationBar.hidden = YES;

    //类目条
    [self.view addSubview:self.navBar];
    
    _navBar.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topEqualToView(self.view)
    .heightIs(NavHFit);
}

/**
 创建一个导航类目条
 
 @return BaseNavgationBar
 */
-(BaseNavgationBar*)navBar
{
    if (_navBar==nil) {
        _navBar = [[BaseNavgationBar alloc] init];
        _navBar.backgroundColor = [UIColor cz_ToUIColorByStr:@"#ffffff"];
        [_navBar.backButton addTarget:self action:@selector(clickBackButtonAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_navBar.rightButton addTarget:self action:@selector(clickRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.navigationController.viewControllers.count == 1) {
            _navBar.backButton.hidden = YES;
        }
    }
    return _navBar;
}


- (void)dealloc
{
    [myNoti removeObserver:self];
}


- (BOOL)isUserLogin
{
    if ([UserHelper shareInstance].user.user_id.length == 0) {
        
        return NO;
    }
    return YES;
}


//返回按钮事件
- (void)clickBackButtonAcion:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//右侧按钮
- (void)clickRightButtonAction:(id)sender
{
    
}

/**
 下拉控件
 
 @return  MJRefreshNormalHeader
 */
-(YDYRefreshHeader*)header
{
    if (_header==nil) {
        _header = [YDYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
    }
    return _header;
}

/**
 上拉加载
 
 @return MJRefreshBackNormalFooter
 */
-(YDYRefreshFooter*)footer{
    
    if (_footer==nil) {
        _footer = [YDYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreToData)];
    }
    return _footer;
    
}

-(void)loadNewData
{
}

-(void)loadMoreToData
{
}

- (void)endRefresh
{
    [self.footer endRefreshing];
    [self.header endRefreshing];
}

- (void)removeLeftButtonTarget
{
    [_navBar.backButton removeTarget:self action:@selector(clickBackButtonAcion:) forControlEvents:UIControlEventTouchUpInside];
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
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        [UIView showMakeSureAletView:@"" message:@"该设备不支持拍照" btnTitle:@"确定" btnTitleBlock:^{}];
    }
}

- (void)takePhotoForViewControllerForNoEdit
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
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
        [self presentViewController:pick animated:YES completion:nil];
    }
    else
    {
        TZImagePickerController *imageVC = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
//        [imageVC.navigationBar addBottomLineWithOffset:0 color:CPColor(@"e5e5e5")];
        imageVC.allowPickingGif = NO;
        imageVC.allowPickingVideo = NO;
        imageVC.isStatusBarDefault = YES;
        imageVC.naviTitleColor = [UIColor blackColor];
        imageVC.naviBgColor = [UIColor whiteColor];
        imageVC.barItemTextColor = [UIColor blackColor];
        [imageVC.navigationBar setTintColor:[UIColor blackColor]];
        [self presentViewController:imageVC animated:YES completion:nil];
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
}
@end
