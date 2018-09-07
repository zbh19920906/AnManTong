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

//点击搜索按钮的搜索结果
@property (nonatomic, strong) NSMutableArray *searchRusltModels;

//搜索关键字
@property (nonatomic, copy) NSString *searchKeyword;

//历史搜索视图
@property (nonatomic, strong) KKHistorySearchView *historySearchView;

@property (nonatomic ,strong) NSIndexPath *selectIndexPath;

@end

@implementation KKSearchGoodsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _page = 0;
    self.searchRusltModels = [[NSMutableArray alloc] init];
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.view.backgroundColor = [UIColor cz_ToUIColorByStr:@"f2f2f2"];
    
    [self.view sd_addSubviews:@[self.searchTableView,  self.historySearchView]];
    [self setupNavigationBar];
    [self addRefreshView];
    
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

#pragma mark - 上拉、下拉刷新
- (void)addRefreshView
{
    weakSelf(self);
    MJRefreshBackNormalFooter * foot = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];
    [foot setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.searchTableView.mj_footer = foot;
}

- (void)endRefresh
{
    [self.searchTableView.mj_footer endRefreshing];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
}

#pragma mark - 显示、隐藏界面的各个视图
- (void)showOrHideCurrentView
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.searchRusltModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BaseTableViewCell identifier] forIndexPath:indexPath];
    
        return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.1;
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

#pragma mark - KKSearchCollectinViewDelegate
- (void)getCollectionViewContentSizeOfHeight:(CGFloat)height
{
    //修改collection的高度
    self.historySearchView.mj_h = height;
}

//点击历史搜索记录
- (void)collectionDidSelectItemWithModel:(KKHistorySearchModel *)model
{
    _searchTF.text = model.title;
    
    //根据关键字搜索相关数据
    [self clickRightButtonAction:nil];
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
        _searchTableView.separatorColor = [UIColor cz_ToUIColorByStr:@"ffffff"];
        _searchTableView.backgroundColor = [UIColor cz_ToUIColorByStr:@"F2F2F2"];
        _searchTableView.hidden = YES;
        
        [_searchTableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:[BaseTableViewCell identifier]];
//        [_searchTableView registerClass:[YDYGGoodsTableCell class] forCellReuseIdentifier:[YDYGGoodsTableCell identifier]];
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

@end

