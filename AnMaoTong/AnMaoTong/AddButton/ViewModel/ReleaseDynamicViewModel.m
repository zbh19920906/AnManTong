//
//  ReleaseDynamicViewModel.m
//  yuexia
//
//  Created by 陈平 on 2018/7/31.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "ReleaseDynamicViewModel.h"
#import "AMTAddButtonVC.h"
#import "AMTPartitionView.h"
#import "AMTAddTitleController.h"
@interface ReleaseDynamicViewModel ()<
CPBaseImageCollectionViewDelegate,PersonalRadioViewDelegate>

@property (nonatomic , strong) UILabel *limitLab;
@property (nonatomic, strong) AMTPartitionView *partitionView;
@property (nonatomic, strong) AMTPartitionView *brandView;
@property (nonatomic, strong) AMTPartitionView *titleView;

@end


@implementation ReleaseDynamicViewModel

#pragma mark - Life
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Public
- (void)setupInitLayout
{
    self.viewController.view.backgroundColor = [UIColor whiteColor];
    [self setupLayout:self.viewController.view];
    [self setupBingding];
}

#pragma mark - Private
- (void)setupLayout:(UIView *)view
{
    BaseView *cuttingView = [[BaseView alloc]init];
    cuttingView.backgroundColor = BHColor(@"F5F5F5");
    
    [view sd_addSubviews:@[self.textView,self.imagesCollectionView,self.locationBtn,self.limitLab,cuttingView,self.partitionView,self.brandView,self.titleView]];
    
    self.textView.sd_layout
    .topSpaceToView(view, NavHFit + 15)
    .leftSpaceToView(view, 10)
    .rightSpaceToView(view, 10)
    .heightIs(140);
    
    self.imagesCollectionView.sd_layout
    .topSpaceToView(self.textView, 10)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(100);
    [self.imagesCollectionView updateLayout];
    
    self.limitLab.sd_layout
    .topSpaceToView(self.imagesCollectionView, 20)
    .leftSpaceToView(view, 15)
    .rightSpaceToView(view, 15)
    .autoHeightRatio(0);
    
    self.locationBtn.sd_layout
    .topSpaceToView(self.limitLab, 10)
    .leftSpaceToView(view, 15);
    [self.locationBtn setupAutoSizeWithHorizontalPadding:15 buttonHeight:25];
    [self.locationBtn setSd_cornerRadiusFromHeightRatio:@0.5];
    
    cuttingView.sd_layout
    .topSpaceToView(self.locationBtn, 24)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(10);
    
    self.partitionView.sd_layout
    .topSpaceToView(cuttingView, 0)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(50);
    
    self.brandView.sd_layout
    .topSpaceToView(self.partitionView, 0)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(50);
    
    self.titleView.sd_layout
    .topSpaceToView(self.brandView, 0)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(50);
}

- (void)setupBingding
{
    weakSelf(self);
    [[self.textView rac_textSignal] subscribeNext:^(id x) {
        weakSelf.limitLab.text = [NSString stringWithFormat:@"%ld/%ld",weakSelf.textView.text.length >= 200 ? 200 : weakSelf.textView.text.length,weakSelf.textView.kMaxNumber];
    }];
    
    [[self.partitionView.tap rac_gestureSignal] subscribeNext:^(id x) {
        weakSelf.dataModel.isBrand = NO;
        PersonalRadioView *radioView = [PersonalRadioView radioViewWithTitle:@"选择专区"];
        radioView.cpDelegate = weakSelf;
        NSMutableArray *zoneArray = [[NSMutableArray alloc]init];;
        for (AMTZoneModel *model in weakSelf.viewController.viewModels.model.zoneArray) {
            [zoneArray addObject:model.name];
        }
        radioView.dataSource = zoneArray;
        [weakSelf.viewController.navigationController.view addSubview:radioView];
    }];
    
    [[self.brandView.tap rac_gestureSignal] subscribeNext:^(id x) {
        weakSelf.dataModel.isBrand = YES;
        PersonalRadioView *radioView = [PersonalRadioView radioViewWithTitle:@"选择品牌"];
        radioView.cpDelegate = weakSelf;
        NSMutableArray *brandArray = [[NSMutableArray alloc]init];;
        for (AMTZoneModel *model in weakSelf.viewController.viewModels.model.brandArray) {
            [brandArray addObject:model.name];
        }
        radioView.dataSource = brandArray;
        [weakSelf.viewController.navigationController.view addSubview:radioView];
    }];
    
    [[self.titleView.tap rac_gestureSignal]subscribeNext:^(id x) {
        AMTAddTitleController *vc = [[AMTAddTitleController alloc]init];
        vc.saveBlock = ^(NSString *titles) {
            weakSelf.viewController.viewModels.customize_label_name = titles;
            weakSelf.titleView.customize_label_name = titles;
        };
        [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)radioViewClick:(NSString *)valueStr
{
    if (self.dataModel.isBrand) {
        self.brandView.contentLab.text = valueStr;
        self.brandView.contentLab.textColor = BHColor(@"222222");
        for (AMTBrandModel *model in self.viewController.viewModels.model.brandArray) {
            if ([model.name isEqualToString:valueStr]) {
                self.viewController.viewModels.brandID = model.ID;
                break;
            }
        }
        
    }else{
        self.partitionView.contentLab.text = valueStr;
        self.partitionView.contentLab.textColor = BHColor(@"222222");
        for (AMTZoneModel *model in self.viewController.viewModels.model.zoneArray) {
            if ([model.name isEqualToString:valueStr]) {
                self.viewController.viewModels.zoneID = model.ID;
                break;
            }
        }
    }
}

- (void)updataLocation:(NSString *)location
{
    if (location)
    {
        self.viewController.viewModels.position = location;
        [self.locationBtn setTitle:[NSString stringWithFormat:@"   %@  ㄨ",location] forState:UIControlStateNormal];
        [self.locationBtn setImage:[imageNamed(@"releaseLocation") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.locationBtn setTintColor:BHColor(@"FFD800")];
        [self.locationBtn setTitleColor:BHColor(@"FFD800") forState:UIControlStateNormal];
        self.locationBtn.backgroundColor = [UIColor clearColor];
    }
    else
    {
        self.viewController.viewModels.position = @"";
        [self.locationBtn setTitle:@"   你在哪里" forState:UIControlStateNormal];
        [self.locationBtn setImage:[imageNamed(@"releaseLocation") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [self.locationBtn setTintColor:BHColor(@"999999")];
        [self.locationBtn setTitleColor:BHColor(@"999999") forState:UIControlStateNormal];
        self.locationBtn.backgroundColor = BHColor(@"#F5F5F5");
    }
}

#pragma mark - CPBaseImageCollectionViewDelegate
- (void)baseImageCollectionViewForAdd:(CPBaseImageCollectionView *)imageCollectionView
{
    [self.viewController takeAlbumForViewControllerWithEditing:NO ischooseMulImage:YES maxCount:9 - self.imagesCollectionView.imageDataSource.count];
}


#pragma mark - Get
- (BaseTextView *)textView
{
    if (_textView == nil) {
        _textView = [[BaseTextView alloc]init];;
        _textView.placeholder = @"描述下您发布的内容...";
        _textView.kMaxNumber = 200;
        _textView.placeholderColor = BHColor(@"CCCCCC");
    }
    return _textView;
}

- (CPBaseImageCollectionView *)imagesCollectionView
{
    if (_imagesCollectionView == nil) {
        CPBaseImageCollectionOption *option = [CPBaseImageCollectionOption new];
        option.direction = UICollectionViewScrollDirectionHorizontal;
        option.itemSize = CGSizeMake(100, 100);
        option.insets = UIEdgeInsetsMake(0, 10, 0, 10);
        _imagesCollectionView = [CPBaseImageCollectionView baseImageCollectionViewWithOption:option];
        _imagesCollectionView.cpDelegate = self;
        _imagesCollectionView.imageDataSource = self.dataModel.imageDataSource;
    }
    return _imagesCollectionView;
}

- (UILabel *)limitLab
{
    if (_limitLab == nil) {
        _limitLab = [UILabel new];
        _limitLab.textColor = BHColor(@"C8C8C8");
        _limitLab.font = BHFont(12);
        _limitLab.textAlignment = NSTextAlignmentRight;
    }
    return _limitLab;
}

- (UIButton *)locationBtn
{
    if (_locationBtn == nil) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.titleLabel.font = BHFont(13);
        [self updataLocation:nil];
    }
    return _locationBtn;
}

- (AMTPartitionView *)partitionView
{
    if (!_partitionView) {
        _partitionView = [[AMTPartitionView alloc]init];
        _partitionView.titleLab.text = @"专区";
        _partitionView.contentLab.text = @"请选择专区";
        
        [_partitionView addBottomLineWithOffset:-1 left:0 right:0 color:BHColor(@"EEEEEE") height:1];
    }
    return _partitionView;
}

- (AMTPartitionView *)brandView
{
    if (!_brandView) {
        _brandView = [[AMTPartitionView alloc]init];
        _brandView.titleLab.text = @"品牌";
        _brandView.contentLab.text = @"请选择品牌";
        
        [_brandView addBottomLineWithOffset:-1 left:0 right:0 color:BHColor(@"EEEEEE") height:1];
    }
    return _brandView;
}

- (AMTPartitionView *)titleView
{
    if (!_titleView) {
        _titleView = [[AMTPartitionView alloc]init];
        _titleView.titleLab.text = @"标签";
        _titleView.contentLab.text = @"请设置标签";
    }
    return _titleView;
}
@end

