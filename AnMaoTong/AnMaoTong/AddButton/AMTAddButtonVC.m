//
//  AMTAddButtonVC.m
//  AnMaoTong
//
//  Created by lk05 on 2018/8/30.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTAddButtonVC.h"
#import "ReleaseDynamicCityController.h"

@interface AMTAddButtonVC ()<ReleaseDynamicCityControllerDelegate>

@end

@implementation AMTAddButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setSubView];
    [self setBingding];
}

- (void)setBingding
{
    weakSelf(self);
    [self.viewModels.zoneCommand execute:@[@"1"]];
    [self.viewModels.brandCommand execute:@[@"1"]];
    
    
}
- (void)setSubView
{
    [self.navBar.backButton setImage:[UIImage new] forState:UIControlStateNormal];
    self.navBar.backButton.hidden = NO;
    [self.navBar.backButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.navBar.backButton setLableColor:@"000000" font:14 bold:0];
    
    [self.navBar.rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.navBar.rightButton setBackgroundColor:BHColor(@"FF3658")];
    self.navBar.rightButton.sd_cornerRadius = @(15);
    self.navBar.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.navBar.rightButton setLableColor:@"FFFFFF" font:14 bold:0];
    self.navBar.rightButton.sd_layout
    .rightSpaceToView(self.navBar, 11)
    .bottomSpaceToView(self.navBar, 7)
    .widthIs(60)
    .heightIs(30);
    [self.viewModel setupInitLayout];
    weakSelf(self);
    [[self.viewModel.locationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ReleaseDynamicCityController *vc = [ReleaseDynamicCityController new];
        vc.cpDelegate = weakSelf;
        vc.currentPOI = weakSelf.dataModel.locationPOI;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)clickBackButtonAcion:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickRightButtonAction:(id)sender
{
    weakSelf(self);
    [[self.viewModels.releaseCommand execute:@[self.viewModel.textView.text,self.viewModels.position,self.viewModels.zoneID,self.viewModels.brandID,@"1",self.viewModels.customize_label_name,self.dataModel.imageDataSource]]subscribeNext:^(id x) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}
#pragma mark - ReleaseDynamicCityControllerDelegate
- (void)releaseDynamicCityController:(ReleaseDynamicCityController *)viewController POI:(id)poi
{
    self.dataModel.locationPOI = poi;
    if (![poi isKindOfClass:[AMapPOI class]])
    {
        [self.viewModel updataLocation:poi];
    }
    else
    {
        AMapPOI * poiModel = (AMapPOI *)poi;
        [self.viewModel updataLocation:poiModel.name];
    }
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

- (AMTReleaseViewModel *)viewModels
{
    if (!_viewModels) {
        _viewModels = [[AMTReleaseViewModel alloc]init];
    }
    return _viewModels;
}
@end
