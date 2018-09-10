//
//  AMTAddButtonVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/8/30.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTAddButtonVC.h"
#import "ReleaseDynamicCityController.h"
@interface AMTAddButtonVC ()

@end

@implementation AMTAddButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[CPAMapLocationManager shareManager] startUpdatingLocationManager];
    [[CPAMapLocationManager shareManager].locationReplaySubject subscribeNext:^(id x) {
        
    }];
    [self setSubView];
}

- (void)setSubView
{
    [self.navBar.backButton setImage:[UIImage new] forState:UIControlStateNormal];
    [self.navBar.backButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.navBar.backButton setLableColor:@"000000" font:14 bold:0];
    
    [self.navBar.rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.navBar.rightButton setBackgroundColor:BHColor(@"")];
    [self.viewModel setupInitLayout];
    weakSelf(self);
    [[self.viewModel.locationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ReleaseDynamicCityController *vc = [ReleaseDynamicCityController new];
        vc.cpDelegate = weakSelf;
        vc.currentPOI = weakSelf.dataModel.locationPOI;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.dataModel.imageDataSource addObject:info[UIImagePickerControllerOriginalImage]];
    self.viewModel.imagesCollectionView.imageDataSource = self.dataModel.imageDataSource;
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    [self.dataModel.imageDataSource addObjectsFromArray:photos];
    self.viewModel.imagesCollectionView.imageDataSource = self.dataModel.imageDataSource;
}


- (ReleaseDynamicViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [ReleaseDynamicViewModel new];
        _viewModel.viewController = self;
        _viewModel.dataModel = self.dataModel;
    }
    return _viewModel;
}

- (ReleaseDynamicDataModel *)dataModel
{
    if (_dataModel == nil) {
        _dataModel = [ReleaseDynamicDataModel new];
    }
    return _dataModel;
}
@end
