//
//  KKSearchGoodsViewController.m
//  CloudMoto
//
//  Created by lk03 on 2018/1/26.
//  Copyright © 2018年 zhu. All rights reserved.
//

#import "KKSearchGoodsViewController.h"
#import "KKHistorySearchView.h"
#import "KKHistorySearchModel.h"
#import "AMTSearchViewModel.h"
#import "AMTFocusShopCell.h"
#import "AMTMerchantDetalisController.h"
@interface KKSearchGoodsViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate,
KKSearchCollectinViewDelegate>
{
    NSInteger _page;
}
@property (nonatomic, strong) BaseTextField *searchTF;
@property (nonatomic, strong) BaseTableView *searchTableView;
@property (nonatomic, strong) AMTDetailsModel *commentModel;


//搜索关键字
@property (nonatomic, copy) NSString *searchKeyword;
@property (nonatomic, strong) AMTHeadView *headView;
//历史搜索视图
@property (nonatomic, strong) KKHistorySearchView *historySearchView;

@property (nonatomic ,strong) NSIndexPath *selectIndexPath;
@property (nonatomic, strong) AMTSearchViewModel *viewModel;
@property (nonatomic, assign) NSInteger searchType;
@property (nonatomic, assign) NSInteger dynamicPage;
@end

@implementation KKSearchGoodsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _searchType = 1;
    _dynamicPage = 1;
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.view.backgroundColor = [UIColor cz_ToUIColorByStr:@"f2f2f2"];
    
    [self.view sd_addSubviews:@[self.searchTableView,  self.historySearchView]];
    [self setupNavigationBar];
    [myNoti addObserver:self selector:@selector(willChange:) name:UIKeyboardDidShowNotification object:nil];
    if ([self.placeholdStr isEqualToString:kSearchPlacehold]) {
        //如果是默认占位文字，则判断搜索按钮状态
        [self listenTextFeild];
    }
}

- (void)setupNavigationBar
{
    self.navBar.titieLab.hidden = YES;
    self.navBar.backButton.hidden = YES;
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 30, 13)];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.image = imageNamed(@"search");
    
    self.searchTF = [[BaseTextField alloc] initWithFrame:CGRectMake(10, NavHFit - 40, WIDTH_SCREEN - 60, 30)];
    [_searchTF setLableColor:@"323232" font:14 bold:0];
    _searchTF.backgroundColor = [UIColor clearColor];
    _searchTF.placeholder = self.placeholdStr;
    _searchTF.keyboardType = UIKeyboardTypeWebSearch;
    _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTF.delegate = self;
    [_searchTF becomeFirstResponder];
    _searchTF.leftViewMode = UITextFieldViewModeAlways;
    _searchTF.leftView = imgV;
    _searchTF.backgroundColor = [UIColor cz_ToUIColorByStr:@"f2f2f2"];
    _searchTF.layer.masksToBounds = YES;
    _searchTF.layer.cornerRadius = 15;
    
    //搜索按钮
    [self.navBar.rightButton setLableColor:@"9F9F9F" font:14 bold:0];
    [self.navBar.rightButton setTitle:@"取消" forState:UIControlStateNormal];

    [self.navBar sd_addSubviews:@[_searchTF]];
}


- (void)clickRightButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)listenTextFeild
{
    [_searchTF.rac_textSignal subscribeNext:^(id x) {
        self.navBar.rightButton.enabled = [x length] > 0;
    }];
}

- (void)loadMoreToData
{
    [self.searchTF.delegate textFieldShouldReturn:self.searchTF];
}

- (void)sendComment
{
    weakSelf(self);
    [[self.viewModel.commentCommand execute:@[self.commentModel,self.keyBoardInputView.inputTF.text]] subscribeNext:^(id x) {
        [weakSelf.keyBoardInputView hidden];
        [weakSelf.keyBoardInputView.inputTF resignFirstResponder];
        [weakSelf.searchTableView reloadData];
    }];
}

- (void)willChange:(NSNotification *)notifi
{
    NSValue *value = [notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    [self.keyBoardInputView show:[value CGRectValue].size.height];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.searchTableView.mj_footer.hidden = NO;
    //隐藏历史搜索页面
    self.historySearchView.hidden = YES;
    [self.historySearchView saveSearchRecordsWithTitle:textField.text];
    
    weakSelf(self);
    [[self.viewModel.searchCommand execute:@[@(self.searchType == 1 ? self.dynamicPage : self.page),@(self.searchType),textField.text]] subscribeNext:^(id x) {
        weakSelf.searchTableView.hidden = NO;
        if (weakSelf.searchType ==1) {
            weakSelf.dynamicPage += 1;
        }else{
            weakSelf.page += 1;
        }
        [weakSelf endRefresh];
        [weakSelf.searchTableView reloadData];
    }];
    return YES;
}

#pragma mark - KKSearchCollectinViewDelegate
- (void)getCollectionViewContentSizeOfHeight:(CGFloat)height
{
    //修改collection的高度
    self.historySearchView.mj_h = height;
}

//点击历史搜索记录
- (void)collectionDidSelectItemWithModel:(KKHistorySearchModel *)model
{
    self.searchTF.text = model.title;
    [self.searchTF.delegate textFieldShouldReturn:self.searchTF];
}
#pragma mark - 显示、隐藏界面的各个视图
- (void)showOrHideCurrentView
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchType == 1 ? self.viewModel.dynamicModels.count : self.viewModel.searchRusltModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchType == 1) {
        AMTGoodsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:[AMTGoodsMessageCell identifier] forIndexPath:indexPath];
        AMTDetailsModel *model = self.viewModel.dynamicModels[indexPath.row];
        cell.model = model;
        weakSelf(self);
        [[[cell.headTap rac_gestureSignal] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            AMTMerchantDetalisController *vc = [[AMTMerchantDetalisController alloc]init];
            vc.user_id = model.user_business_id;
            vc.type = model.type;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        
        [[[cell rac_signalForSelector:@selector(changeComment:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            weakSelf.commentModel = x[0];
            [weakSelf.keyBoardInputView.inputTF becomeFirstResponder];
        }];
        [[[cell rac_signalForSelector:@selector(changeCollection:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            AMTDetailsModel *model = x[0];
            [[weakSelf.viewModel.collectionCommand execute:model] subscribeNext:^(id x) {
                [weakSelf.searchTableView reloadData];
            }];
        }];
        [[[cell rac_signalForSelector:@selector(changeLike:)] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            AMTDetailsModel *model = x[0];
            [[weakSelf.viewModel.likeCommand execute:model] subscribeNext:^(id x) {
                [weakSelf.searchTableView reloadData];
            }];
        }];
        return cell;
    }
    AMTFocusShopCell *cell = [tableView dequeueReusableCellWithIdentifier:[AMTFocusShopCell identifier] forIndexPath:indexPath];
    cell.model = self.viewModel.searchRusltModels[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.searchType == 1 ? [tableView cellHeightForIndexPath:indexPath model:self.viewModel.dynamicModels[indexPath.row] keyPath:@"model" cellClass:[AMTGoodsMessageCell class] contentViewWidth:WIDTH_SCREEN] +10 :76;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchTF resignFirstResponder];
}



#pragma mark - 懒加载
- (BaseTableView *)searchTableView
{
    if (!_searchTableView) {
        
        _searchTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, NavHFit, WIDTH_SCREEN, HEIGHT_SCREEN - NavHFit) style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.tableFooterView = [UIView new];
        _searchTableView.separatorInset = UIEdgeInsetsZero;
        _searchTableView.tableHeaderView = self.headView;
        _searchTableView.separatorColor = [UIColor cz_ToUIColorByStr:@"ffffff"];
        _searchTableView.backgroundColor = [UIColor cz_ToUIColorByStr:@"F2F2F2"];
        _searchTableView.hidden = YES;
        _searchTableView.mj_footer = self.footer;
        [_searchTableView registerClass:[AMTGoodsMessageCell class] forCellReuseIdentifier:[AMTGoodsMessageCell identifier]];
        [_searchTableView registerClass:[AMTFocusShopCell class] forCellReuseIdentifier:[AMTFocusShopCell identifier]];
    }
    return _searchTableView;
}

//- (BHStreetView *)searchResultView
//{
//    if (!_searchResultView) {
//        UIImage *img = imageNamed(@"img_search");
//        _searchResultView = [[BHStreetView alloc] initWithBackgroudImage:@"img_search" title:@"无搜索内容" size:img.size];
//        _searchResultView.hidden = YES;
//    }
//    return _searchResultView;
//}

- (KKHistorySearchView *)historySearchView
{
    if (!_historySearchView) {
        _historySearchView = [[KKHistorySearchView alloc] initWithFrame:CGRectMake(0, NavHFit - 10, WIDTH_SCREEN, 0)];
        _historySearchView.backgroundColor = [UIColor whiteColor];
        _historySearchView.delegate = self;
        _historySearchView.hidden = ![self.historySearchView getSearchRecords].count;
    }
    return _historySearchView;
}

- (AMTHeadView *)headView
{
    if (!_headView) {
        weakSelf(self);
        _headView = [[AMTHeadView alloc]initWithFrame:CGRectMake(0, 15, WIDTH_SCREEN, 44) titleArray:@[@"安贸圈",@"商家"] click:^(NSInteger tag) {
            weakSelf.searchType = tag + 1;
            [weakSelf.searchTF.delegate textFieldShouldReturn:weakSelf.searchTF];
        }];
    }
    return _headView;
}

- (AMTSearchViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AMTSearchViewModel alloc]init];
    }
    return _viewModel;
}
@end

