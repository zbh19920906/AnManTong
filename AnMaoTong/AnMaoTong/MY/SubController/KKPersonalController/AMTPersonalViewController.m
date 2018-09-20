//
//  AMTPersonalViewController.m
//  AnMaoTong
//
//  Created by lk05 on 2018/9/7.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "AMTPersonalViewController.h"
#import "AMTPersonalCell.h"
#import "AMTAnnouncementCell.h"
#import "AMTPersonalVIewModel.h"
#import "CPDatePickerView.h"
@interface AMTPersonalViewController ()<UITableViewDelegate,UITableViewDataSource,CPBottomPromitViewDelegate,PersonalRadioViewDelegate,CPDatePickerViewDelegate>
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) AMTPersonalVIewModel *viewModel;
@end

@implementation AMTPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.titieLab.text = self.isUser ? @"个人资料" : @"商家资料";
    [self.view addSubview:self.tableView];
    [self.navBar.rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.navBar.rightButton setLableColor:@"555555" font:14 bold:0];
    weakSelf(self);
    [[self.navBar.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[weakSelf.viewModel.saveCommand execute:nil] subscribeNext:^(id x) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.titleArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        AMTAnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTAnnouncementCell class]) forIndexPath:indexPath];
        return cell;
    }
    AMTPersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AMTPersonalCell class]) forIndexPath:indexPath];
    cell.isUser = self.isUser;
    NSString *title = self.titleArr[indexPath.section][indexPath.row];
    cell.title = title;
    weakSelf(self);
    [[cell.rightTF rac_textSignal] subscribeNext:^(id x) {
        if ([title isEqualToString:@"昵称"]) {
            if (weakSelf.isUser) {
                weakSelf.viewModel.model.nickname = cell.rightTF.text;
            }else{
                weakSelf.viewModel.model.name = cell.rightTF.text;
            }
        }else if ([title isEqualToString:@"微信号"]){
            weakSelf.viewModel.model.wx = cell.rightTF.text;
        }else{
            weakSelf.viewModel.model.qq = cell.rightTF.text;
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 100 : 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                CPBottomPromitOption *option = [CPBottomPromitOption new];
                option.defCancleColor = BHColor(@"0070FF");
                option.fontForHead = BHFont(12);
                option.colorForHead = BHColor(@"666666");
                option.titleFont = BHFont(18);
                option.separatorColor = BHColor(@"E5E5E5");
                option.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
                CPBottomPromitView *bottomView = [CPBottomPromitView bottomPromitViewWithStyle:CPBlurEffectStyleLight option:option];
                bottomView.cpDelegate = self;
                [bottomView addTitle:@"拍照" detail:nil titleColor:BHColor(@"0070FF") detailColor:nil];
                [bottomView addTitle:@"从相册选择" detail:nil titleColor:BHColor(@"0070FF") detailColor:nil];
                [bottomView addHeadViewHeadTitle:@"选择图像来源"];
                [bottomView showBottomPromit];
            }
                break;
            case 2:
            {
                PersonalRadioView *radioView = [PersonalRadioView radioViewWithTitle:@"选择性别"];
                radioView.cpDelegate = self;
                radioView.dataSource = @[@"男",@"女"];
                [self.navigationController.view addSubview:radioView];
            }
                break;
            case 3:
            {
                CPDatePickerView *dateView = [CPDatePickerView datePickerViewWithTitle:@"选择日期"];
                dateView.cpDelegate = self;
//                [dateView showTime:childModel.content];
                [self.view addSubview:dateView];
            }
                break;
           
            default:
                break;
        }
    }else{
        
    }
}

- (void)radioViewClick:(NSString *)valueStr
{
    AMTPersonalCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [cell.rightBtn setTitle:valueStr forState:UIControlStateNormal];
    self.viewModel.model.sex = [valueStr isEqualToString:@"男"] ? 1 : 2;
    
}

- (void)pickerViewForClick:(NSString *)timeStr
{
    AMTPersonalCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    [cell.rightBtn setTitle:timeStr forState:UIControlStateNormal];
    self.viewModel.model.date_birth = timeStr;
}

-(void)bottomPromitView:(CPBottomPromitView *)bottomPromitView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //拍照
        [self takePhotoForViewController];
    }
    else if ((indexPath.row == 1))
    {
        //从相册选择
        [self takeAlbumForViewControllerWithEditing:YES ischooseMulImage:YES maxCount:1];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    AMTPersonalCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.headImage.image = image;
    [self.viewModel.headImageCommand execute:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    for (UIImage *image in photos){
        AMTPersonalCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.headImage.image = image;
        [self.viewModel.headImageCommand execute:image];
    }
}

- (BaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        [_tableView registerClass:[AMTPersonalCell class] forCellReuseIdentifier:NSStringFromClass([AMTPersonalCell class])];
        [_tableView registerClass:[AMTAnnouncementCell class] forCellReuseIdentifier:NSStringFromClass([AMTAnnouncementCell class])];
    }
    return _tableView;
}

- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = self.isUser ? @[@[@"更换头像",@"昵称",@"性别",@"出生年月",@"微信号",@"QQ号"]] : @[@[@"更换头像",@"商家名称",@"微信号",@"QQ号"],@[@"公告"]];
    }
    return _titleArr;
}

- (AMTPersonalVIewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AMTPersonalVIewModel alloc]init];
    }
    return _viewModel;
}
@end
