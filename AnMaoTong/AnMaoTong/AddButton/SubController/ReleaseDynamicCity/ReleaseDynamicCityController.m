//
//  ReleaseDynamicCityController.m
//  yuexia
//
//  Created by 陈平 on 2018/8/2.
//  Copyright © 2018年 chenp. All rights reserved.
//

#import "ReleaseDynamicCityController.h"
#import "ReleaseDynamicCell.h"
#import "ReleaseDynamicTitleCell.h"

@interface ReleaseDynamicCityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *tableView;

@property (nonatomic , strong) NSMutableArray<NSMutableAttributedString *> *dataSource;

@property (nonatomic , strong) NSArray <AMapPOI *>*poiDataSource;

@property (nonatomic , strong) NSIndexPath *currentIndexPath;

@end

@implementation ReleaseDynamicCityController

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"所在位置";
    
    [self setupInitForReleaseDynamicCityController];
    [self setupBingdingForReleaseDynamicCityController];
}

#pragma mark - Pravite
-(void)setupInitForReleaseDynamicCityController
{
    [self.view addSubview:self.tableView];
    
}


-(void)setupBingdingForReleaseDynamicCityController
{
    weakSelf(self);
    [[CPAMapLocationManager shareManager] searchPOIAroundForCoordinate:[CPAMapLocationManager shareManager].currentCoordinate searchComplete:^(AMapPOISearchResponse *response) {
        weakSelf.poiDataSource = response.pois;
        [weakSelf updataChoose];
    }];
    [RACObserve(self, currentPOI) subscribeNext:^(id  _Nullable x) {
        [weakSelf updataChoose];
    }];
}

- (void)updataChoose
{
    self.currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.currentPOI)
    {
        if ([self.currentPOI isKindOfClass:[NSString class]]){
            self.currentIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        }else{
            weakSelf(self);
            [self.poiDataSource enumerateObjectsUsingBlock:^(AMapPOI * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AMapPOI *poiModel = (AMapPOI *)self.currentPOI;
                if ([poiModel.name isEqualToString:obj.name])
                {
                    weakSelf.currentIndexPath = [NSIndexPath indexPathForRow:idx inSection:1];
                    *stop = YES;
                }
            }];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - Public


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? self.dataSource.count : self.poiDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL flag = NO;
    if (indexPath.section == self.currentIndexPath.section &&
        indexPath.row == self.currentIndexPath.row)
    {
        flag = YES;
    }
    
    if (indexPath.section == 0)
    {
        ReleaseDynamicTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:[ReleaseDynamicTitleCell identifier]];
        cell.textLabel.attributedText = self.dataSource[indexPath.row];
        cell.accessoryType = flag ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        return cell;
    }
    else
    {
        ReleaseDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:[ReleaseDynamicCell identifier]];
        if (cell == nil) {
            cell = [[ReleaseDynamicCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                          reuseIdentifier: [ReleaseDynamicCell identifier]];
        }
       cell.textLabel.text = self.poiDataSource[indexPath.row].name;
        cell.textLabel.textColor = BHColor(@"2b2b2b");
        cell.textLabel.font = BHFont(14);
       cell.detailTextLabel.text = self.poiDataSource[indexPath.row].address;
        cell.detailTextLabel.textColor = BHColor(@"989898");
        cell.detailTextLabel.font = BHFont(9);
        cell.accessoryType = flag ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        self.currentPOI = indexPath.row == 0 ? nil : self.dataSource[indexPath.row].string;
    }
    else
    {
        AMapPOI *model = self.poiDataSource[indexPath.row];
        self.currentPOI = model;
    }
    
    if (self.cpDelegate && [self.cpDelegate respondsToSelector:@selector(releaseDynamicCityController:POI:)]) {
        [self.cpDelegate releaseDynamicCityController:self POI:self.currentPOI];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - get
-(BaseTableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
//        [_tableView registerClass:[ReleaseDynamicCell class] forCellReuseIdentifier:[ReleaseDynamicCell identifier]];
        [_tableView registerClass:[ReleaseDynamicTitleCell class] forCellReuseIdentifier:[ReleaseDynamicTitleCell identifier]];
    }
    return _tableView;
}

- (NSMutableArray<NSMutableAttributedString *> *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:[NSMutableAttributedString attributedWithString:@"不显示位置" color:BHColor(@"#697898") font:BHFont(14)]];
        [_dataSource addObject:[NSMutableAttributedString attributedWithString:[CPAMapLocationManager shareManager].city color:BHColor(@"2b2b2b") font:BHFont(14)]];
    }
    return _dataSource;
}

@end
